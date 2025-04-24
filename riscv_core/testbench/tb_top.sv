//////////////////////////////////////////////////////////////////////
////                                                              ////
////                                                              ////
////  This file is part of the SDRAM Controller project           ////
////  http://www.opencores.org/cores/sdr_ctrl/                    ////
////                                                              ////
////  Description: RISC-V CPU core based on RV32I instruction set ////
////               No extensions.                                 ////
////                                                              ////
////  Version  :0.1 - Test Bench automation is improvised with     ////
//             seperate data,address,burst length fifo.           ////
//             Now user can create different write and            ////
//             read sequence                                      ////
//                                                                ////
////  Author(s):                                                  ////
////      - Joachim Debat                                         ////
////                                                              ////
//////////////////////////////////////////////////////////////////////


`timescale 1ns/1ps
`include "riscv_defines.sv"

module tb_top;

    parameter P_SYS = 10;     // 200MHz
    
    // Clock & Reset
    reg resetn;
    reg sys_clk = 0;
    
    always #(P_SYS/2) sys_clk = !sys_clk;
    
    /* RISC-V Core instance */
    riscv_core #(
        .DATA_WIDTH   (32),
        .DATA_MEM_SIZE(32),
        .PROG_MEM_SIZE(58),
        .NUM_CORE_REGS(31)
    ) riscv_core_inst(
        .clk  (sys_clk), 
        .reset(!resetn)
    );
  
    
    /////////////////////////
    //      Test Case      //
    /////////////////////////
    initial begin
        // Reset phase
        resetn = 1'b1;
        #100
        // Applying reset
        resetn = 1'b0;
        #1000;
        // Releasing reset
        resetn = 1'b1;
        #1000;
        $display("--------------------------------------- ");
        $display(" Test program:                          ");
		$display("(I) ADDI x1,x0,10101                    ");
		$display("(I) ADDI x2,x0,111                      ");
		$display("(I) ADDI x3,x0,111111111100             ");
		$display("(I) ANDI x5,x1,1011100                  ");
		$display("(I) XORI x5,x5,10101                    ");
		$display("(I) ORI x6,x1,1011100                   ");
		$display("(I) XORI x6,x6,1011100                  ");
		$display("(I) ADDI x7,x1,111                      ");
		$display("(I) XORI x7,x7,11101                    ");
		$display("(I) SLLI x8,x1,110                      ");
		$display("(I) XORI x8,x8,10101000001              ");
		$display("(I) SRLI x9,x1,10                       ");
		$display("(I) XORI x9,x9,100                      ");
		$display("(R) AND r10,x1,x2                       ");
		$display("(I) XORI x10,x10,100                    ");
		$display("(R) OR x11,x1,x2                        ");
		$display("(I) XORI x11,x11,10110                  ");
		$display("(R) XOR x12,x1,x2                       ");
		$display("(I) XORI x12,x12,10011                  ");
		$display("(R) ADD x13,x1,x2                       ");
		$display("(I) XORI x13,x13,11101                  ");
		$display("(R) SUB x14,x1,x2                       ");
		$display("(I) XORI x14,x14,1111                   ");
		$display("(R) SLL x15,x2,x2                       ");
		$display("(I) XORI x15,x15,1110000001             ");
		$display("(R) SRL x16,x1,x2                       ");
		$display("(I) XORI x16,x16,1                      ");
		$display("(R) SLTU x17,x2,x1                      ");
		$display("(I) XORI x17,x17,0                      ");
		$display("(I) SLTIU x18,x2,10101                  ");
		$display("(I) XORI x18,x18,0                      ");
		$display("(U) LUI x19,0                           ");
		$display("(I) XORI x19,x19,1                      ");
		$display("(I) SRAI x20,x3,1                       ");
		$display("(I) XORI x20,x20,111111111111           ");
		$display("(R) SLT x21,x3,x1                       ");
		$display("(I) XORI x21,x21,0                      ");
		$display("(I) SLTI x22,x3,1                       ");
		$display("(I) XORI x22,x22,0                      ");
		$display("(R) SRA x23,x1,x2                       ");
		$display("(I) XORI x23,x23,1                      ");
		$display("(U) AUIPC x4,100                        ");
		$display("(I) SRLI x24,x4,111                     ");
		$display("(I) XORI x24,x24,10000000               ");
		$display("(J) JAL x25,10                          ");
		$display("(U) AUIPC x4,0                          ");
		$display("(R) XOR x25,x25,x4                      ");
		$display("(I) XORI x25,x25,1                      ");
		$display("(I) JALR x26,x4,10000                   ");
		$display("(R) SUB x26,x26,x4                      ");
		$display("(I) ADDI x26,x26,111111110001           ");
		$display("(S) SW x2,x1,1                          ");
		$display("(I) LW x27,x2,1                         ");
		$display("(I) XORI x27,x27,10100                  ");
		$display("(I) ADDI x28,x0,1                       ");
		$display("(I) ADDI x29,x0,1                       ");
		$display("(I) ADDI x30,x0,1                       ");
		$display("(J) JAL x0,0                            ");
		$display("END                                     ");
        $display("--------------------------------------- ");
		
		// Waiting for program END
		#100000;

        // Finish simulation
        $finish;
    end

endmodule
