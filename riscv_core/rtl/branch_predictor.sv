module branch_predictor(
    // program counter
    input  logic [31:0] pc,
    // immediate jump value
    input logic [31:0] imm,
    // rs1 & rs2 jump register value(s)
    input logic [31:0] src1_value,
    input logic [31:0] src2_value,
    // branch type
    input logic is_beq, 
    input logic is_bne, 
    input logic is_blt, 
    input logic is_bge, 
    input logic is_bltu,
    input logic is_bgeu,
    // is branch taken ?
    output logic taken_br,
    // target branch pc values
    output logic [31:0] br_tgt_pc,
    output logic [31:0] jalr_tgt_pc
);
    // Branch prediction logic
    assign taken_br = is_beq  ? (src1_value == src2_value) :
                      is_bne  ? (src1_value != src2_value) :
                      is_blt  ? (src1_value < src2_value) ^ (src1_value[31] != src2_value[31]) :
                      is_bge  ? (src1_value >= src2_value) ^ (src1_value[31] != src2_value[31]) :
                      is_bltu ? (src1_value < src2_value) :
                      is_bgeu ? (src1_value >= src2_value) : 1'b0;  // Default, branch not taken
    
    assign br_tgt_pc = pc + imm;  // target PC value = current branch PC + relative offset jump (in $imm value)
    assign jalr_tgt_pc = src1_value + imm;  // target PC value = address in reg + relative offset jump (in $imm value)

endmodule
