iverilog -g2012 -o data_flip_flop.vvp data_flip_flop.sv data_flip_flop_tb.sv 
vvp data_flip_flop.vvp

gtkwave -f data_flip_flop.vcd # new session -> empty 
# gtkwave -f data_flip_flop.vcd -3 # restore previous gtk session