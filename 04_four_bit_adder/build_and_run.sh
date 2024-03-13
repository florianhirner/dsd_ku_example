iverilog -g2012 -o four_bit_adder.vvp four_bit_adder.sv four_bit_adder_tb.sv 
vvp four_bit_adder.vvp

gtkwave -f four_bit_adder.vcd # new session -> empty 
# gtkwave -f four_bit_adder.vcd -3 # restore previous gtk session