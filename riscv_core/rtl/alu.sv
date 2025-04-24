module alu(
    // scr1 & src2 registers + immediate
    input logic [31:0] src1_value,
    input logic [31:0] src2_value,
    input logic [31:0] imm,
    // program counter
    input logic [31:0] pc,
    // instruction to compute
    input logic is_addi,
    input logic is_add,
    input logic is_sub, 
    input logic is_sltu, 
    input logic is_sltiu,
    input logic is_slt,
    input logic is_slti, 
    input logic is_xor,
    input logic is_xori, 
    input logic is_or,
    input logic is_ori,  
    input logic is_and, 
    input logic is_andi, 
    input logic is_sll,
    input logic is_slli, 
    input logic is_srl,
    input logic is_srli, 
    input logic is_sra,
    input logic is_srai, 
    input logic is_jal,
    input logic is_jalr, 
    input logic is_lui,
    input logic is_auipc,
    input logic is_store,
    input logic is_load,
    // final result
    output logic [31:0] result
);
    // instruction results
    logic [31:0] add_rslt;
    logic [31:0] addi_rslt;
    logic [31:0] sub_rslt;
    // SLTU and SLTIU (set 
    logic [31:0] sltu_rslt;
    logic [31:0] sltiu_rslt;
    // SLT and SLTI (set if
    logic [31:0] slt_rslt;
    logic [31:0] slti_rslt;
    // XOR and XORI results
    logic [31:0] xor_rslt;
    logic [31:0] xori_rslt;
    // OR and ORI results:
    logic [31:0] or_rslt;
    logic [31:0] ori_rslt;
    // AND and ANDI results
    logic [31:0] and_rslt;
    logic [31:0] andi_rslt;
    // SLL and SLLI (shifht
    logic [31:0] sll_rslt;
    logic [31:0] slli_rslt;
    // SRL and SRLI (shifht
    logic [31:0] srl_rslt;
    logic [31:0] srli_rslt;
    // SRA and SRAI (shift 
    // sign-extended src1
    logic [63:0] sext_src1;
    //64-bit sign-extended 
    logic [63:0] sra_rslt;
    logic [63:0] srai_rslt;
    // JAL and JALR ((jump 
    logic [31:0] jal_rslt; 
    logic [31:0] jalr_rslt;
    // LUI (load upper imme
    logic [31:0] lui_rslt;
    logic [31:0] auipc_rslt;
    // S(B/H/W) and L(B/H/W
    logic [31:0] store_rslt;
    logic [31:0] load_rslt;

    /* Compute results for all instructions */
    // ADD, ADDI and SUB results:
    assign add_rslt  = src1_value + src2_value;
    assign addi_rslt = src1_value + imm;
    assign sub_rslt  = src1_value - src2_value;
    // SLTU and SLTIU (set if less than, unsigned) results:
    assign sltu_rslt  = {31'b0, src1_value < src2_value};
    assign sltiu_rslt = {31'b0, src1_value < imm};
    // SLT and SLTI (set if less than) results:
    assign slt_rslt  = (src1_value[31] == src2_value[31]) ?
                         sltu_rslt :
                         {31'b0, src1_value[31]};
    assign slti_rslt = (src1_value[31] == imm[31]) ?
                         sltiu_rslt :
                         {31'b0, src1_value[31]};
    // XOR and XORI results:
    assign xor_rslt  = src1_value ^ src2_value;
    assign xori_rslt = src1_value ^ imm;
    // OR and ORI results:
    assign or_rslt  = src1_value | src2_value;
    assign ori_rslt = src1_value | imm;
    // AND and ANDI results:
    assign and_rslt  = src1_value & src2_value;
    assign andi_rslt = src1_value & imm;
    // SLL and SLLI (shifht left, logical) results:
    assign sll_rslt  = src1_value << src2_value[4:0];
    assign slli_rslt = src1_value << imm[4:0];
    // SRL and SRLI (shifht right, logical) results:
    assign srl_rslt  = src1_value >> src2_value[4:0];
    assign srli_rslt = src1_value >> imm;
    // SRA and SRAI (shift right, arithmetic) results:
    // sign-extended src1
    assign sext_src1 = { {32{src1_value[31]}}, src1_value };
    //64-bit sign-extended results, to be truncated
    assign sra_rslt  = sext_src1 >> src2_value[4:0];
    assign srai_rslt = sext_src1 >> imm[4:0];
    // JAL and JALR ((jump and link, reg) results:
    assign jal_rslt  = pc + 32'd4;
    assign jalr_rslt = pc + 32'd4;
    // LUI (load upper immediate) and AUIPC (add upper immediate to PC) results:
    assign lui_rslt   = {imm[31:12], 12'b0};
    assign auipc_rslt = pc + {imm[31:12], 12'b0};
    // S(B/H/W) and L(B/H/W/BU/HU) results:
    assign store_rslt = src1_value + imm;
    assign load_rslt  = src1_value + imm;
    
    assign result = is_addi  ? addi_rslt :
                    is_add   ? add_rslt :
                    is_sub   ? sub_rslt :
                    is_sltu  ? sltu_rslt :
                    is_sltiu ? sltiu_rslt :
                    is_slt   ? slt_rslt :
                    is_slti  ? slti_rslt :
                    is_xor   ? xor_rslt :
                    is_xori  ? xori_rslt :
                    is_or    ? or_rslt :
                    is_ori   ? ori_rslt :
                    is_and   ? and_rslt :
                    is_andi  ? andi_rslt :
                    is_sll   ? sll_rslt :
                    is_slli  ? slli_rslt :
                    is_srl   ? srl_rslt :
                    is_srli  ? srli_rslt :
                    is_sra   ? sra_rslt[31:0] :
                    is_srai  ? srai_rslt[31:0] :
                    is_jal   ? jal_rslt :
                    is_jalr  ? jalr_rslt :
                    is_lui   ? lui_rslt :
                    is_auipc ? auipc_rslt :
                    is_store ? store_rslt :
                    is_load  ? load_rslt : 32'b0;  // Default value is 32'b0

endmodule
