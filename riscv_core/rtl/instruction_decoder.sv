module instruction_decoder(
    // instruction to decode
    input logic [31:0] instr,
    // instruction type decoded
    output logic is_r_instr,
    output logic is_i_instr,
    output logic is_s_instr,
    output logic is_b_instr,
    output logic is_u_instr,
    output logic is_j_instr,
    // instruction decoded
    output logic is_addi,
    output logic is_add,
    output logic is_sub, 
    output logic is_sltu, 
    output logic is_sltiu,
    output logic is_slt,
    output logic is_slti, 
    output logic is_xor,
    output logic is_xori, 
    output logic is_or,
    output logic is_ori,  
    output logic is_and, 
    output logic is_andi, 
    output logic is_sll,
    output logic is_slli, 
    output logic is_srl,
    output logic is_srli, 
    output logic is_sra,
    output logic is_srai, 
    output logic is_jal,
    output logic is_jalr, 
    output logic is_lui,
    output logic is_auipc,
    output logic is_store,
    output logic is_load,
    // bitfield extracted
    output logic [4:0]  rd,
    output logic [2:0]  funct3,
    output logic [4:0]  rs1,
    output logic [4:0]  rs2,   
    output logic [31:0] imm,
    // bitfield valid
    output logic rd_valid,
    output logic funct3_valid,
    output logic rs1_valid,
    output logic rs2_valid,
    output logic imm_valid
);
    // instruction fields
    logic [6:0]  opcode;
    logic [10:0] dec_bits;

    // Determine instruction type from opcode
    assign is_r_instr = instr[6:2] ==? 5'b011x0 ||
                        instr[6:2] ==  5'b10100 ||
                        instr[6:2] ==  5'b01011;
    assign is_i_instr = instr[6:2] ==? 5'b0000x ||
                        instr[6:2] ==? 5'b001x0 ||
                        instr[6:2] ==  5'b11001;
    assign is_s_instr = instr[6:2] ==? 5'b0100x;
    assign is_b_instr = instr[6:2] ==  5'b11000;
    assign is_u_instr = instr[6:2] ==? 5'b0x101;
    assign is_j_instr = instr[6:2] ==  5'b11011;
    
    // Extract instruction fields
    assign opcode = instr[6:0];
    assign rd = instr[11:7];
    assign funct3 = instr[14:12];
    assign rs1 = instr[19:15];
    assign rs2 = instr[24:20];
    assign imm = is_i_instr ? { {21{instr[31]}}, instr[30:20] } :
                       is_s_instr ? { {21{instr[31]}}, instr[30:25], instr[11:7]} :
                       is_b_instr ? { {20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0 } :
                       is_u_instr ? { instr[31:12], 12'b0 } :
                       is_j_instr ? { {12{instr[31]}}, instr[19:12], instr[20] , instr[30:21], 1'b0 } : 32'b0; // Default
    
    // Determine whether fields are valid
    assign rd_valid = is_r_instr || is_i_instr || is_u_instr || is_j_instr;
    assign funct3_valid = is_r_instr || is_i_instr || is_s_instr || is_b_instr;
    assign rs1_valid = is_r_instr || is_i_instr || is_s_instr || is_b_instr;
    assign rs2_valid = is_r_instr || is_s_instr || is_b_instr;
    assign imm_valid = is_i_instr || is_s_instr || is_b_instr || is_u_instr || is_j_instr;
    
    // Determine specific instruction to execute
    assign dec_bits[10:0] = {instr[30], funct3, opcode};  // funct7[5] & funct3 & opcode
    // Branch instructions
    assign is_beq  = dec_bits ==? 11'bx_000_1100011;
    assign is_bne  = dec_bits ==? 11'bx_001_1100011;
    assign is_blt  = dec_bits ==? 11'bx_100_1100011;
    assign is_bge  = dec_bits ==? 11'bx_101_1100011;
    assign is_bltu = dec_bits ==? 11'bx_110_1100011;
    assign is_bgeu = dec_bits ==? 11'bx_111_1100011;
    // Compute instructions
    assign is_addi  = dec_bits ==? 11'bx_000_0010011;
    assign is_slti  = dec_bits ==? 11'bx_010_0010011;
    assign is_sltiu = dec_bits ==? 11'bx_011_0010011;
    assign is_xori  = dec_bits ==? 11'bx_100_0010011;
    assign is_ori   = dec_bits ==? 11'bx_110_0010011;
    assign is_andi  = dec_bits ==? 11'bx_111_0010011;
    assign is_slli  = dec_bits ==  11'b0_001_0010011;
    assign is_srli  = dec_bits ==  11'b0_101_0010011;
    assign is_srai  = dec_bits ==  11'b1_101_0010011;
    assign is_add   = dec_bits ==  11'b0_000_0110011;
    assign is_sub   = dec_bits ==  11'b1_000_0110011;
    assign is_sll   = dec_bits ==  11'b0_001_0110011;
    assign is_slt   = dec_bits ==  11'b0_010_0110011;
    assign is_sltu  = dec_bits ==  11'b0_011_0110011;
    assign is_xor   = dec_bits ==  11'b0_100_0110011;
    assign is_srl   = dec_bits ==  11'b0_101_0110011;
    assign is_sra   = dec_bits ==  11'b1_101_0110011;
    assign is_or    = dec_bits ==  11'b0_110_0110011;
    assign is_and   = dec_bits ==  11'b0_111_0110011;
    // Jump instructions
    assign is_jal  = dec_bits ==? 11'bx_xxx_1101111;
    assign is_jalr = dec_bits ==? 11'bx_xxx_1100111;
    // Store & Load instructions
    assign is_store = is_s_instr;
    assign is_load = opcode ==? 7'b0000011;
    // Other instructions
    assign is_lui   = dec_bits ==? 11'bx_xxx_0110111;
    assign is_auipc = dec_bits ==? 11'bx_xxx_0010111;

endmodule
