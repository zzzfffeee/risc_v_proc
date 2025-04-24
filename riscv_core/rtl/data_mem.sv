module data_mem #(
    parameter DATA_WIDTH = 32,
	parameter MEM_SIZE = 32
)
(
    // Clk & Reset
    input  logic clk,
    input  logic reset,
    // Address & Data
    input  logic [$clog2(DATA_WIDTH)-1:0] addr,
    input  logic wr_en,
    input  logic [DATA_WIDTH-1:0] wr_data,
    input  logic rd_en,
    output logic [DATA_WIDTH-1:0] ld_data
);

    // Read-Write data memory
    logic [DATA_WIDTH-1:0] dmem_a0 [MEM_SIZE];
    logic [DATA_WIDTH-1:0] dmem_n1 [MEM_SIZE];
    // Write logic
    genvar dmem_i;
    for (dmem_i = 0; dmem_i <= (MEM_SIZE-1); dmem_i++) begin
        logic wr;
        assign wr = wr_en && (addr == dmem_i);
        assign dmem_n1[dmem_i] = reset ? 0 :
                                 wr    ? wr_data : dmem_a0[dmem_i];
        always_ff @(posedge clk) dmem_a0[dmem_i] <= dmem_n1[dmem_i];
    end
    // Read logic
    assign ld_data[DATA_WIDTH-1:0] = rd_en ? dmem_a0[addr] : 'X;
    
endmodule
