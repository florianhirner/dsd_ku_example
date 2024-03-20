iverilog -g2012 -o cipher_core.vvp cipher_pkg.sv cipher_core_tb.sv cipher_core.sv 
vvp cipher_core.vvp

gtkwave -f cipher_core.vcd # new session -> empty 
# gtkwave -f cipher_core.vcd -3 # restore previous gtk session