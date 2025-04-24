//---------------------------------------------------------------------------------
// RISC-V CPU core
//---------------------------------------------------------------------------------

module riscv_core #(
    parameter DATA_WIDTH = 32,
    parameter DATA_MEM_SIZE = 32,
    parameter PROG_MEM_SIZE = 58,
    parameter NUM_CORE_REGS = 31
)
(
    // Clock & Reset
    input logic clk, 
    input logic reset
);
   
    /* Signal declarations */
    // instruction fields
    logic [31:0] instr;
    logic [6:0]  opcode;
    logic [4:0]  rd;
    logic [2:0]  funct3;
    logic [4:0]  rs1; 
    logic [4:0]  rs2;   
    logic [31:0] imm;
    logic [10:0] dec_bits;
    
    // instruction types
    logic is_r_instr;
    logic is_i_instr;
    logic is_s_instr;
    logic is_b_instr;
    logic is_u_instr;
    logic is_j_instr;
    
    // valid field flags
    logic rd_valid;
    logic funct3_valid;
    logic rs1_valid;
    logic rs2_valid;
    logic imm_valid;
    
    // branch instructions
    logic is_beq;
    logic is_bne;
    logic is_blt;
    logic is_bge;
    logic is_bltu;
    logic is_bgeu;
    // compute instructions
    logic is_addi;
    logic is_slti;
    logic is_sltiu;
    logic is_xori;
    logic is_ori;
    logic is_andi;
    logic is_slli;
    logic is_srli;
    logic is_srai;
    logic is_add;
    logic is_sub;
    logic is_sll;
    logic is_slt;
    logic is_sltu;
    logic is_xor;
    logic is_srl;
    logic is_sra;
    logic is_or;
    logic is_and;
    // jump instructions
    logic is_jal;
    logic is_jalr;
    // store & load instructions
    logic is_store;
    logic is_load;
    // other instructions
    logic is_lui;
    logic is_auipc;
    
    // ALU registers
    logic [DATA_WIDTH-1:0] src1_value;
    logic [DATA_WIDTH-1:0] src2_value;
    logic [DATA_WIDTH-1:0] result;
 
    // others
    logic [DATA_WIDTH-1:0] rd_result;
    logic [DATA_WIDTH-1:0] ld_data;
    logic wr_en;
    logic taken_br;
    
    /* Program Counter logic */
    logic [DATA_WIDTH-1:0] pc, next_pc;
    logic [DATA_WIDTH-1:0] br_tgt_pc;
    logic [DATA_WIDTH-1:0] jalr_tgt_pc;

    assign next_pc = reset ? 32'b0 : 
                     (taken_br || is_jal) ? br_tgt_pc :
                     is_jalr ? jalr_tgt_pc : pc + 4;  // Default is to execute next instruction
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            pc <= 32'b0;
        else
            pc <= next_pc;
    end

    /* Write-back logic */
    assign wr_en = (rd == 5'h0) ? 1'b0 : rd_valid;  // x0 cannot be written
    
    /* Instruction Memory */
    instruction_mem #(
        .MEM_SIZE(PROG_MEM_SIZE)
    )
    imem_inst(
        .addr(pc   ),
        .data(instr)
    );
    
    /* Decode logic */
    instruction_decoder decoder_inst(
        // instruction to decode
        .instr     (instr),
        // instruction type decoded
        .is_r_instr  (is_r_instr),
        .is_i_instr  (is_i_instr),
        .is_s_instr  (is_s_instr),
        .is_b_instr  (is_b_instr),
        .is_u_instr  (is_u_instr),
        .is_j_instr  (is_j_instr),
        // instruction decoded
        .is_addi     (is_addi   ),
        .is_add      (is_add    ),
        .is_sub      (is_sub    ), 
        .is_sltu     (is_sltu   ), 
        .is_sltiu    (is_sltiu  ),
        .is_slt      (is_slt    ),
        .is_slti     (is_slti   ), 
        .is_xor      (is_xor    ),
        .is_xori     (is_xori   ), 
        .is_or       (is_or     ),
        .is_ori      (is_ori    ),  
        .is_and      (is_and    ), 
        .is_andi     (is_andi   ), 
        .is_sll      (is_sll    ),
        .is_slli     (is_slli   ), 
        .is_srl      (is_srl    ),
        .is_srli     (is_srli   ), 
        .is_sra      (is_sra    ),
        .is_srai     (is_srai   ), 
        .is_jal      (is_jal    ),
        .is_jalr     (is_jalr   ), 
        .is_lui      (is_lui    ),
        .is_auipc    (is_auipc  ),
        .is_store    (is_store  ),
        .is_load     (is_load   ),
        // bitfield extracted
        .rd          (rd        ),
        .funct3      (funct3    ),
        .rs1         (rs1       ),
        .rs2         (rs2       ),   
        .imm         (imm       ),
        // bitfield valid
        .rd_valid    (rd_valid    ),
        .funct3_valid(funct3_valid),
        .rs1_valid   (rs1_valid   ),
        .rs2_valid   (rs2_valid   ),
        .imm_valid   (imm_valid   )

    );
   
    /* Arithmetic Logic Unit */
    alu alu_inst(
        // scr1 & src2 registers
        .src1_value(src2_value),
        .src2_value(src1_value),
        .imm       (imm       ),
        .pc        (pc        ),
        // instruction to compute
        .is_addi   (is_addi   ),
        .is_add    (is_add    ),
        .is_sub    (is_sub    ), 
        .is_sltu   (is_sltu   ), 
        .is_sltiu  (is_sltiu  ),
        .is_slt    (is_slt    ),
        .is_slti   (is_slti   ), 
        .is_xor    (is_xor    ),
        .is_xori   (is_xori   ), 
        .is_or     (is_or     ),
        .is_ori    (is_ori    ),  
        .is_and    (is_and    ), 
        .is_andi   (is_andi   ), 
        .is_sll    (is_sll    ),
        .is_slli   (is_slli   ), 
        .is_srl    (is_srl    ),
        .is_srli   (is_srli   ), 
        .is_sra    (is_sra    ),
        .is_srai   (is_srai   ), 
        .is_jal    (is_jal    ),
        .is_jalr   (is_jalr   ), 
        .is_lui    (is_lui    ),
        .is_auipc  (is_auipc  ),
        .is_store  (is_store  ),
        .is_load   (is_load   ),
        // final result  
        .result    (result    )
    );
   
    /* Branch/Jump logic */
    branch_predictor branch_pred_inst(
        // program counter
        .pc         (pc         ),
        // immediate jump value
        .imm        (imm        ),
        // rs1 & rs2 jump register value(s)
        .src1_value (src1_value ),
        .src2_value (src2_value ),
        // branch type
        .is_beq     (is_beq     ),
        .is_bne     (is_bne     ),
        .is_blt     (is_blt     ),
        .is_bge     (is_bge     ),
        .is_bltu    (is_bltu    ),
        .is_bgeu    (is_bgeu    ),
        // is branch taken ?
        .taken_br   (taken_br   ),
        // target branch pc values
        .br_tgt_pc  (br_tgt_pc  ),
        .jalr_tgt_pc(jalr_tgt_pc)
    );
    
    /* Register file */
    reg_file #(
         .DATA_WIDTH(DATA_WIDTH),
	     .REG_SIZE  (NUM_CORE_REGS)
    )
    reg_file_inst(
        // Clock & Reset
        .clk          (clk       ),
        .reset        (reset     ),
        // Registers & Addresses
        .rf1_wr_en    (wr_en     ),
        .rf1_wr_index (rd        ),
        .rf1_wr_data  (rd_result ),
        .rf1_rd_en1   (rs1_valid ),
        .rf1_rd_index1(rs1       ),
        .rf1_rd_en2   (rs2_valid ),
        .rf1_rd_index2(rs2       ),
	    .src1_value   (src1_value),
	    .src2_value   (src2_value)
    );
   
    /* Data memory */
    data_mem #(
       .DATA_WIDTH(DATA_WIDTH),
       .MEM_SIZE  (DATA_MEM_SIZE)
    )
    dmem_inst(
        // Clk & Reset
        .clk     (clk            ),
        .reset   (reset          ),
        // Address & Data
        .addr   (result[6:2]     ),
        .wr_en  (is_store        ),
        .wr_data(src2_value[31:0]),
        .rd_en  (is_load         ),
        .ld_data(ld_data         )
    );
   
   // word-aligned memory (2 lsbs assumed to be 1'b0)
   assign rd_result = is_load ? ld_data : result;
   
endmodule