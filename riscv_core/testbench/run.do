vlib work

vlog -work work -f filelist_top.f

vsim -voptargs="+acc" -gui work.tb_top

do wave.do

run -all
