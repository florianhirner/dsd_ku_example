iverilog -o inverter.vpp inverter.v inverter_tb.v
vvp inverter.vpp

gtkwave inverter.vcd # new session -> empty 
# gtkwave -f inverter.vcd -3 # restore previous gtk session