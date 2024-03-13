module inverter_tb;

reg a;
wire y;

inverter uut(
    .a_i(a),
    .a_o(y)
);

initial begin
    $dumpfile("inverter.vcd");
    $dumpvars(0,inverter_tb);

    a = 0;
    #10
    a = 1;
    #10 
    a = 0;
    #10
    a = 1;
    #10
    $finish();
end


endmodule
