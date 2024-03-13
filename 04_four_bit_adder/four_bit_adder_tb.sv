module four_bit_adder_tb;

    // Inputs
    logic clk, rst;
    logic [3:0] a, b;

    // Outputs
    logic [3:0] sum0, sum1;

    // Instantiate the four_bit_adder module
    four_bit_adder uut0 (
        .clk_i(clk),
        .a_i(a),
        .b_i(b),
        .sum_o(sum0)
    );

    // Clock generation
    initial forever #5 clk = ~clk;

    // Dumpfile 
    initial begin
        $dumpfile("four_bit_adder.vcd");
        $dumpvars(0, four_bit_adder_tb);
    end

    // Stimulus generation
    initial begin

        $display("=======================================");
        $display("> Four bit adder without overflow check");        
        $display("=======================================\n");

        // Initialize inputs
        clk = 0;
        // rst = 0;
        a = 4'b0;
        b = 4'b0;

        // e1 : no overflow
        @(posedge clk);
        a = 4'b0101;
        b = 4'b0011;
        $display("Inputs: a=%b, b=%b", a, b);
        #1;
        $display("Sum: %b", sum0);

        // e2 : overflow
        @(posedge clk);
        a = 4'b1100;
        b = 4'b0100;
        $display("Inputs: a=%b, b=%b", a, b);
        #1;
        $display("Sum: %b", sum0);

        // e3 : no overflow
        @(posedge clk);
        a = 4'b1100;
        b = 4'b0011;
        $display("Inputs: a=%b, b=%b", a, b);
        #1;
        $display("Sum: %b", sum0);

        // Finish simulation
        // @(posedge clk);
        // $finish;
    end

    /////////////////////////////////////////////////////////
    logic overflow;

    // Instantiate the four_bit_adder_with_overflow_detection module
    four_bit_adder_with_overflow_detection uut1 (
        .clk_i(clk),
        .a_i(a),
        .b_i(b),
        .overflow_o(overflow),
        .sum_o(sum1)
    );


    // Stimulus generation
    initial begin
        // Initialize inputs
        // clk = 0;
        // rst = 0;
        #100;

        $display("=======================================");
        $display("> Four bit adder with overflow check");        
        $display("=======================================\n");

        #50;
        a = 4'b0;
        b = 4'b0;

        // e1 : no overflow
        @(posedge clk);
        a = 4'b0101;
        b = 4'b0011;
        $display("Inputs: a=%b, b=%b", a, b);
        #1;
        $display("Sum: %b, Overflow: %b", sum1, overflow);

        // e2 : overflow
        @(posedge clk);
        a = 4'b1100;
        b = 4'b0100;
        $display("Inputs: a=%b, b=%b", a, b);
        #1;
        $display("Sum: %b, Overflow: %b", sum1, overflow);

        // e3 : no overflow
        @(posedge clk);
        a = 4'b1100;
        b = 4'b0011;
        $display("Inputs: a=%b, b=%b", a, b);
        #1;
        $display("Sum: %b, Overflow: %b", sum1, overflow);

        // Finish simulation
        @(posedge clk);
        $finish;
    end
endmodule

