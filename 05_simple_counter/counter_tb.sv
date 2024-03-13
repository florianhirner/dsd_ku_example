module Counter_tb;

    // Inputs
    logic clk, rst;
    logic en_0, en_1;

    logic [3:0] counter_init, counter_inc, counter_target;

    // Outputs
    logic done_0, done_1;
    logic [3:0] counter_value_0, counter_value_1;

    // Instantiate module v0
    counter_v0 uut0 (
        .clk_i(clk),
        .reset_i(rst),
        .enable_i(en_0),
        .counter_value_o(counter_value_0),
        .done_o(done_0)
    );

    // Instantiate module v1
    counter_v1 uut1 (
        .clk_i(clk),
        .reset_i(rst),
        .enable_i(en_1),
        .counter_init_i(counter_init), 
        .counter_inc_i(counter_inc), 
        .counter_target_i(counter_target),
        .counter_value_o(counter_value_1),
        .done_o(done_1)
    );

    // Clock generation
    initial forever #5 clk = ~clk;

    // Dumpfile 
    initial begin
        $dumpfile("counter.vcd");
        $dumpvars(0, Counter_tb);
    end

    // Stimulus generation
    initial begin

        // Initialize inputs
        clk = 0;
        rst = 0;
        en_0 = 0;
        en_1 = 0;

        /////////////////////////////////////////////////////////////
        // test counter version 0
        /////////////////////////////////////////////////////////////

        $display("=======================================");
        $display("> counter_v0 with simple +1 increment");        
        $display("=======================================\n");

        #10;
        $display("> set reset signal");
        rst = 1;

        #10;
        $display("> clear reset signal");
        rst = 0;

        $display("> set enable signal");
        en_0 = 1;

        // wait for the done signal with print output
        while (done_0 != 1) begin
            // print counter value each clock cycle
            @(posedge clk);
            $display("> ouputs: %03d  = %d", $time, counter_value_0);
        end

        // wait for the done signal without print output
        // @(posedge done_0);

        #10;
        $display("> reset enable signal");
        en_0 = 0;

        $display("\n=======================================");
        $display("> Finished counter_v0");
        $display("=======================================\n");

        // $finish; // stop after counter version 0

        /////////////////////////////////////////////////////////////
        // test counter version 1
        /////////////////////////////////////////////////////////////

        #10;
        $display("=======================================");
        $display("> Begin counter_v1 with base and end value");    
        $display("=======================================\n");

        #10;
        $display("> set init, inc, and target values");
        counter_init = 4'h0;
        counter_inc = 4'h3;
        counter_target = 4'hf;

        #10;
        $display("> set reset signal");
        rst = 1;

        #10;
        rst = 0;

        #10;
        $display("> set enable signal");
        en_1 = 1;

        // wait for the done signal
        while (done_1 != 1) begin
            // print counter value each clock cycle
            @(posedge clk);
            $display("> ouputs: %03d  = %d", $time, counter_value_1);
        end

        // wait for the done signal
        // @(posedge done_0);

        #10;
        $display("> reset enable signal");
        en_1 = 0;

        $display("\n=======================================");
        $display("> Finished counter_v1");
        $display("=======================================\n");

        // Finish simulation
        $finish;

    end

endmodule

