vlib work
vlog -f "do file/list.list" -mfcu +cover -covercells
vsim -voptargs=+acc work.tb_top -cover -classdebug -uvmcontrol=all
add wave /tb_top/DUT/*
coverage save top.ucdb -onexit -du work.ALU
run -all
coverage report -detail -cvg -directive -comments -output reports/alu_cover_report.txt /ALU_coverage_pkg/ALU_coverage/opcode_cov /ALU_coverage_pkg/ALU_coverage/operand_range_cov
coverage exclude -src design/ALU.sv -line 32 -code s -code b
#quit -sim
vcover report top.ucdb -details -annotate -all -output reports/alurpt.txt
