do:
	iverilog -o a.out alu_module/alu_tb.v alu_module/*_.v arithmetic_part/*_.v comparison_part/*_.v logic_part/and/*_.v logic_part/logic_module/*_.v logic_part/nor/*_.v logic_part/or/*_.v logic_part/xor/*_.v
	vvp a.out

clean:
	rm a.out
