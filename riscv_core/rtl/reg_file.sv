module reg_file #(
    parameter DATA_WIDTH = 32,
	parameter REG_SIZE = 31
)
(
    // Clock & Reset
    input  logic clk,
    input  logic reset,
    // Registers & Addresses
    input  logic rf1_wr_en,
    input  logic [$clog2(DATA_WIDTH)-1:0] rf1_wr_index,
    input  logic [DATA_WIDTH-1:0] rf1_wr_data,
    input  logic rf1_rd_en1,
    input  logic [$clog2(DATA_WIDTH)-1:0] rf1_rd_index1,
    input  logic rf1_rd_en2,
    input  logic [$clog2(DATA_WIDTH)-1:0] rf1_rd_index2,
	output logic [DATA_WIDTH-1:0] src1_value,
	output logic [DATA_WIDTH-1:0] src2_value
);

    // Register file
	logic [DATA_WIDTH-1:0] xreg_a0 [REG_SIZE];
    logic [DATA_WIDTH-1:0] xreg_n1 [REG_SIZE];
	genvar xreg_i;
    for (xreg_i = 0; xreg_i <= REG_SIZE; xreg_i++) begin
        logic wr;
        assign wr = rf1_wr_en && (rf1_wr_index == xreg_i);
        assign xreg_n1[xreg_i] = reset ? xreg_i :
                                 wr    ? rf1_wr_data : xreg_a0[xreg_i];
        always_ff @(posedge clk) xreg_a0[xreg_i] <= xreg_n1[xreg_i];
	end
    
    assign src1_value = rf1_rd_en1 ? xreg_a0[rf1_rd_index1] : 'X;
    assign src2_value = rf1_rd_en2 ? xreg_a0[rf1_rd_index2] : 'X;
   
endmodule