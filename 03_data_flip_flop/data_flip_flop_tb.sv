module data_flip_flop_tb;

// Inputs
logic clk;
logic rst;
logic en;
logic d;

// Outputs
logic q0;
logic q1;

// Instantiate the SimpleFlipFlop module
data_flip_flop_v0 uut_0 (
    .clk_i(clk),
    .rst_i(rst),
    .d_i(d),
    .q_o(q0)
);

// Instantiate the SimpleFlipFlop module with update logic
data_flip_flop_v1 uut_1 (
    .clk_i(clk),
    .rst_i(rst),
    .en_i(en),
    .d_i(d),
    .q_o(q1)
);

// Clock generation
initial forever #5 clk = ~clk;

// Stimulus generation and monitoring
initial begin
    $dumpfile("data_flip_flop.vcd");
    $dumpvars(0, data_flip_flop_tb);

    // Initialize inputs
    clk = 0;
    rst = 0;
    en = 0;
    d = 0;
    
    // Apply reset
    #10 rst = 1;

    // Release reset and observe flip-flop behavior for 20 clock cycles
    #10 rst = 0;

    repeat (20) begin
        #10 d = ~d;  // Toggle data input
    end

    #10 en = 1;

    repeat (10) begin
        #10 d = ~d;  // Toggle data input
    end

    #10 en = 0;

    repeat (10) begin
        #10 d = ~d;  // Toggle data input
    end

    // Finish simulation
    $finish;
end

endmodule
