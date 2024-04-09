iverilog -g2012 -o multipler.vvp multipler_pkg.sv multipler_tb.sv multipler.sv 
vvp multipler.vvp

gtkwave -f multipler.vcd # new session -> empty 
# gtkwave -f multipler.vcd -3 # restore previous gtk session

rm *.vvp
rm *.vcd