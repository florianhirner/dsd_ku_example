module four_bit_adder (
    input logic clk_i,
    input logic [3:0] a_i, // 4-bit input
    input logic [3:0] b_i, // 4-bit input
    output logic [3:0] sum_o // 4-bit sum output
);

    // Combinational logic for addition (simplified description)
    // assign sum_o = a_i + b_i;
    
    // Combinational logic for addition (gate level description)
    logic [3:0] carry;
    logic [3:0] sum;

    assign sum_o = sum;

    half_adder half_adder_0 (
        .a_i(a_i[0]),
        .b_i(b_i[0]),
        .sum_o(sum[0]),
        .carry_o(carry[0])
    );

    full_adder full_adder_0 (
        .a_i(a_i[1]),
        .b_i(b_i[1]),
        .carry_i(carry[0]),
        .sum_o(sum[1]),
        .carry_o(carry[1])
    );

    full_adder full_adder_1 (
        .a_i(a_i[2]),
        .b_i(b_i[2]),
        .carry_i(carry[1]),
        .sum_o(sum[2]),
        .carry_o(carry[2])
    );

    full_adder full_adder_2 (
        .a_i(a_i[3]),
        .b_i(b_i[3]),
        .carry_i(carry[2]),
        .sum_o(sum[3]),
        .carry_o(carry[3])
    );
endmodule

module half_adder (
    input a_i,
    input b_i,
    output sum_o,
    output carry_o
);

logic sum, carry;

xor(sum, a_i, b_i);
and(carry, a_i, b_i);

assign sum_o = sum;
assign carry_o = carry;

endmodule

module full_adder (
    input a_i,
    input b_i,
    input carry_i,
    output sum_o,
    output carry_o
);

logic w1, w2, w3, w4;
logic sum, carry;

xor(w1, a_i, b_i);
xor(sum, w1, carry_i);

and(w2, a_i, b_i);
and(w3, b_i, carry_i);
and(w4, carry_i, a_i);

or(carry, w2, w3, w4);

assign sum_o = sum;
assign carry_o = carry;

endmodule

module four_bit_adder_with_overflow_detection (
    input logic clk_i,
    input logic [3:0] a_i, // 4-bit inputs
    input logic [3:0] b_i, // 4-bit inputs
    output logic overflow_o, // 1-bit overflow output
    output logic [3:0] sum_o // 4-bit sum output
);
    // Combinational logic for addition that uses a temporary value to 
    // catch carry/overflow bit
    logic [4:0] sum5bit;

    assign sum5bit = a_i + b_i;
    assign overflow_o = sum5bit[4];
    assign sum_o = sum5bit[3:0];

    // you can also use this syntax if preferred
    assign {overflow_o, sum_o} = sum5bit;

    // Note that a direct assignment will not work since a and b are 4bit.
    // The result of a 4 bit addition is still 4 bit -> so no 5th overflow bit
    assign {overflow_o, sum_o} = {a_i + b_i};

endmodule