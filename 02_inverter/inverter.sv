module inverter(
    input a_i,
    output a_o
);

// we can use this
assign a_o = ~a_i;
// or this
// not(a_o, a_i);

endmodule

