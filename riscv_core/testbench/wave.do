onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_top/riscv_core_inst/clk
add wave -noupdate /tb_top/riscv_core_inst/reset
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_r_instr
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_i_instr
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_s_instr
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_b_instr
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_u_instr
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_j_instr
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_addi
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_add
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_sub
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_sltu
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_sltiu
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_slt
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_slti
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_xor
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_xori
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_or
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_ori
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_and
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_andi
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_sll
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_slli
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_srl
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_srli
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_sra
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_srai
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_jal
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_jalr
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_lui
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_auipc
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_store
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_load
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_beq
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_bne
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_blt
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_bltu
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_bge
add wave -noupdate -expand -group {Instruction type} /tb_top/riscv_core_inst/decoder_inst/is_bgeu
add wave -noupdate -expand -group {Instruction bitfields} /tb_top/riscv_core_inst/decoder_inst/rd
add wave -noupdate -expand -group {Instruction bitfields} /tb_top/riscv_core_inst/decoder_inst/funct3
add wave -noupdate -expand -group {Instruction bitfields} /tb_top/riscv_core_inst/decoder_inst/rs1
add wave -noupdate -expand -group {Instruction bitfields} /tb_top/riscv_core_inst/decoder_inst/rs2
add wave -noupdate -expand -group {Instruction bitfields} /tb_top/riscv_core_inst/decoder_inst/imm
add wave -noupdate -expand -group {Instruction bitfields} /tb_top/riscv_core_inst/decoder_inst/opcode
add wave -noupdate -expand -group {Bitfields valid} /tb_top/riscv_core_inst/decoder_inst/rd_valid
add wave -noupdate -expand -group {Bitfields valid} /tb_top/riscv_core_inst/decoder_inst/funct3_valid
add wave -noupdate -expand -group {Bitfields valid} /tb_top/riscv_core_inst/decoder_inst/rs1_valid
add wave -noupdate -expand -group {Bitfields valid} /tb_top/riscv_core_inst/decoder_inst/rs2_valid
add wave -noupdate -expand -group {Bitfields valid} /tb_top/riscv_core_inst/decoder_inst/imm_valid
add wave -noupdate /tb_top/riscv_core_inst/decoder_inst/dec_bits
add wave -noupdate -expand -group {Register File} /tb_top/riscv_core_inst/reg_file_inst/xreg_a0
add wave -noupdate -expand -group {Register File} /tb_top/riscv_core_inst/reg_file_inst/xreg_n1
add wave -noupdate -expand -group {Register File} /tb_top/riscv_core_inst/reg_file_inst/reset
add wave -noupdate -expand -group {Register File} /tb_top/riscv_core_inst/reg_file_inst/rf1_wr_en
add wave -noupdate -expand -group {Register File} /tb_top/riscv_core_inst/reg_file_inst/rf1_wr_index
add wave -noupdate -expand -group {Register File} /tb_top/riscv_core_inst/reg_file_inst/rf1_wr_data
add wave -noupdate -expand -group {Register File} /tb_top/riscv_core_inst/reg_file_inst/rf1_rd_en1
add wave -noupdate -expand -group {Register File} /tb_top/riscv_core_inst/reg_file_inst/rf1_rd_index1
add wave -noupdate -expand -group {Register File} /tb_top/riscv_core_inst/reg_file_inst/rf1_rd_en2
add wave -noupdate -expand -group {Register File} /tb_top/riscv_core_inst/reg_file_inst/rf1_rd_index2
add wave -noupdate -expand -group {Register File} /tb_top/riscv_core_inst/reg_file_inst/src1_value
add wave -noupdate -expand -group {Register File} /tb_top/riscv_core_inst/reg_file_inst/src2_value
add wave -noupdate -expand -group {ALU results} /tb_top/riscv_core_inst/alu_inst/result
add wave -noupdate -expand -group {ALU results} /tb_top/riscv_core_inst/alu_inst/add_rslt
add wave -noupdate -expand -group {ALU results} /tb_top/riscv_core_inst/alu_inst/addi_rslt
add wave -noupdate -expand -group {ALU results} /tb_top/riscv_core_inst/alu_inst/sub_rslt
add wave -noupdate -expand -group {ALU results} /tb_top/riscv_core_inst/alu_inst/sltu_rslt
add wave -noupdate -expand -group {ALU results} /tb_top/riscv_core_inst/alu_inst/sltiu_rslt
add wave -noupdate -expand -group {ALU results} /tb_top/riscv_core_inst/alu_inst/slt_rslt
add wave -noupdate -expand -group {ALU results} /tb_top/riscv_core_inst/alu_inst/slti_rslt
add wave -noupdate -expand -group {ALU results} /tb_top/riscv_core_inst/alu_inst/xor_rslt
add wave -noupdate -expand -group {ALU results} /tb_top/riscv_core_inst/alu_inst/xori_rslt
add wave -noupdate -expand -group {ALU results} /tb_top/riscv_core_inst/alu_inst/or_rslt
add wave -noupdate -expand -group {ALU results} /tb_top/riscv_core_inst/alu_inst/ori_rslt
add wave -noupdate -expand -group {ALU results} /tb_top/riscv_core_inst/alu_inst/and_rslt
add wave -noupdate -expand -group {ALU results} /tb_top/riscv_core_inst/alu_inst/andi_rslt
add wave -noupdate -expand -group {ALU results} /tb_top/riscv_core_inst/alu_inst/sll_rslt
add wave -noupdate -expand -group {ALU results} /tb_top/riscv_core_inst/alu_inst/slli_rslt
add wave -noupdate -expand -group {ALU results} /tb_top/riscv_core_inst/alu_inst/srl_rslt
add wave -noupdate -expand -group {ALU results} /tb_top/riscv_core_inst/alu_inst/srli_rslt
add wave -noupdate -expand -group {ALU results} /tb_top/riscv_core_inst/alu_inst/sext_src1
add wave -noupdate -expand -group {ALU results} /tb_top/riscv_core_inst/alu_inst/sra_rslt
add wave -noupdate -expand -group {ALU results} /tb_top/riscv_core_inst/alu_inst/srai_rslt
add wave -noupdate -expand -group {ALU results} /tb_top/riscv_core_inst/alu_inst/jal_rslt
add wave -noupdate -expand -group {ALU results} /tb_top/riscv_core_inst/alu_inst/jalr_rslt
add wave -noupdate -expand -group {ALU results} /tb_top/riscv_core_inst/alu_inst/lui_rslt
add wave -noupdate -expand -group {ALU results} /tb_top/riscv_core_inst/alu_inst/auipc_rslt
add wave -noupdate -expand -group {ALU results} /tb_top/riscv_core_inst/alu_inst/store_rslt
add wave -noupdate -expand -group {ALU results} /tb_top/riscv_core_inst/alu_inst/load_rslt
add wave -noupdate -expand -group {Instruction Memory} /tb_top/riscv_core_inst/imem_inst/addr
add wave -noupdate -expand -group {Instruction Memory} /tb_top/riscv_core_inst/imem_inst/data
add wave -noupdate -expand -group {Instruction Memory} /tb_top/riscv_core_inst/imem_inst/instrs
add wave -noupdate -expand -group {Program Counters} /tb_top/riscv_core_inst/br_tgt_pc
add wave -noupdate -expand -group {Program Counters} /tb_top/riscv_core_inst/jalr_tgt_pc
add wave -noupdate -expand -group {Program Counters} /tb_top/riscv_core_inst/pc
add wave -noupdate -expand -group {Program Counters} -expand /tb_top/riscv_core_inst/next_pc
add wave -noupdate /tb_top/riscv_core_inst/branch_pred_inst/taken_br
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4644811 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 366
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {12656211 ps}
