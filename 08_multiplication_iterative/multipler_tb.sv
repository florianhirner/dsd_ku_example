
import multipler_pkg::*;

module multipler_tb;

    logic                       clk_i;           // Rising edge active clk.
    logic                       rst_ni;          // Active low reset.
    logic                       start_i;         // Start signal.
    logic                       busy_o;          // Module busy. 
    logic                       finish_o;        // Module finish.
    logic [DATA_LENGTH-1:0]     indata_a_i;      // Input data -> operand a.
    logic [DATA_LENGTH-1:0]     indata_b_i;      // Input data -> operand b.
    logic [DATA_LENGTH*2-1:0]   outdata_r_o;     // Output data -> result a*b.

    logic [DATA_LENGTH*2-1:0]   reference_o;

    // Instantiate module
    multipler_top uut (
        .clk_i                  (clk_i),           // Rising edge active clk.
        .rst_ni                 (rst_ni),          // Active low reset.
        .start_i                (start_i),         // Start signal.
        .busy_o                 (busy_o),          // Module busy. 
        .finish_o               (finish_o),        // Module finish.
        .indata_a_i             (indata_a_i),      // Input data -> operand a.
        .indata_b_i             (indata_b_i),      // Input data -> operand b.
        .outdata_r_o            (outdata_r_o)      // Output data -> result a*b.
    );

    // Clock generation
    initial forever #5 clk_i = ~clk_i;

    // Dumpfile 
    initial begin
        $dumpfile("multipler.vcd");
        $dumpvars(0, multipler_tb);
    end

    // Stimulus generation
    initial begin

        $display("\n=======================================");
        $display("[%04t] > Start multipler test", $time);
        $display("=======================================\n");

        // Initialize inputs
        clk_i = 0;
        rst_ni = 0;
        start_i = 0;
        indata_a_i = 0;
        indata_b_i = 0;

        #20;
        $display("[%04t] > Set reset signal", $time);
        rst_ni = 1;

        // #50;
        // $display("> Reset reset signal");
        // rst_ni = 1;

        #10;
        $display("[%04t] > Set start signal", $time);
        indata_a_i = $random; // 64'h0003_0002_0001_0000;
        indata_b_i = $random; // 64'h0000_0000_0000_0002;
        reference_o = indata_a_i * indata_b_i;
        start_i = 1;

        $display("[%04t] > Set indata_a_i: %h", $time, indata_a_i);
        $display("[%04t] > Set indata_a_i: %h", $time, indata_b_i);

        #10;
        $display("[%04t] > Reset start signal", $time);
        start_i = 0;
        $display("");

        #10;
        $display("[%04t] < Wait for finish signal", $time);
        @(posedge finish_o)
        $display("[%04t] > Received finish signal", $time);
        $display("");

        $display("[%04t] > OUT data: %h", $time, outdata_r_o);
        $display("[%04t] > REF data: %h", $time, reference_o);
        if (outdata_r_o == reference_o) begin
            $display("[%04t] > Data is VALID", $time);
        end
        else begin
            $display("[%04t] > Data is INVALID", $time);
        end

        $display("\n=======================================");
        $display("[%04t] > Finish multipler test", $time);
        $display("=======================================\n");

        // Finish simulation
        #100;
        $finish;

    end

endmodule : multipler_tb 
