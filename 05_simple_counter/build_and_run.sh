iverilog -g2012 -o counter.vvp counter_tb.sv counter.sv 
vvp counter.vvp

gtkwave -f counter.vcd # new session -> empty 
# gtkwave -f counter.vcd -3 # restore previous gtk session