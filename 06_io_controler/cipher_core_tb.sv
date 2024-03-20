
import cipher_pkg::*;

module cipher_core_tb;

    logic                   clk_i;           // Rising edge active clk.
    logic                   rst_ni;          // Active low reset.
    logic [KEY_LENGTH-1:0]  key_i;           // Encryption key.
    logic [DATA_LENGTH-1:0] nonce_i;         // Nonce.
    logic [LENGTH-1:0]      data_len_i;      // # of data blocks.
    logic [LENGTH-1:0]      ad_len_i;        // # of ad blocks.
    logic [DATA_LENGTH-1:0] indata_i;        // Plaintext and AD.
    logic                   indata_valid_i;  // Master valid.
    logic                   indata_ready_o;  // Slave ready.
    logic [DATA_LENGTH-1:0] outdata_o;       // Ciphertext.
    logic                   outdata_valid_o; // Slave valid.
    logic                   outdata_ready_i; // Master ready.
    logic [DATA_LENGTH-1:0] tag_o;           // Tag.
    logic                   start_i;         // Start signal.
    logic                   busy_o;          // Cipher busy. 
    logic                   finish_o;        // Cipher finish.

    // Instantiate cipher_core module
    cipher_core uut (
        .clk_i              (clk_i),           // Rising edge active clk.
        .rst_ni             (rst_ni),          // Active low reset.
        .key_i              (key_i),           // Encryption key.
        .nonce_i            (nonce_i),         // Nonce.
        .data_len_i         (data_len_i),      // # of data blocks.
        .ad_len_i           (ad_len_i),        // # of ad blocks.
        .indata_i           (indata_i),        // Plaintext and AD.
        .indata_valid_i     (indata_valid_i),  // Master valid.
        .indata_ready_o     (indata_ready_o),  // Slave ready.
        .outdata_o          (outdata_o),       // Ciphertext.
        .outdata_valid_o    (outdata_valid_o), // Slave valid.
        .outdata_ready_i    (outdata_ready_i), // Master ready.
        .tag_o              (tag_o),           // Tag.
        .start_i            (start_i),         // Start signal.
        .busy_o             (busy_o),          // Cipher busy. 
        .finish_o           (finish_o)         // Cipher finish.
    );

    // Clock generation
    initial forever #5 clk_i = ~clk_i;

    // Dumpfile 
    initial begin
        $dumpfile("cipher_core.vcd");
        $dumpvars(0, cipher_core_tb);
    end

    // Stimulus generation
    initial begin

        $display("\n=======================================");
        $display("> Start I/O control test");
        $display("=======================================\n");

        // Initialize inputs
        clk_i = 0;              // Rising edge active clk.
        rst_ni = 0;             // Active low reset.
        key_i = 0;              // Encryption key.
        nonce_i = 0;            // Nonce.
        data_len_i = 0;         // # of data blocks.
        ad_len_i = 0;           // # of ad blocks.
        indata_i = 0;           // Plaintext and AD.
        indata_valid_i = 0;     // Master valid.
        outdata_ready_i = 0;    // Master ready.
        start_i = 0;            // Start signal.

        #20;
        $display("> Set reset signal");
        rst_ni = 1;

        // #50;
        // $display("> Reset reset signal");
        // rst_ni = 1;

        #10;
        $display("> Set start signal");
        key_i = 128'h0123_4567_89ab_cdef_0123_4567_89ab_cdef;
        nonce_i = 128'hfedc_ba98_7654_3210_fedc_ba98_7654_3210;
        data_len_i = 2;
        ad_len_i = 2;
        indata_i = 0;
        indata_valid_i = 0;
        outdata_ready_i = 0;
        start_i = 1;

        #10;
        $display("> Reset start signal");
        start_i = 0;

        #10;
        $display("< Wait for  indata_ready_o signal");
        #100;
        while(indata_ready_o != 1) begin
            #10;
        end
        $display("> Set for  indata_valid_i signal");
        indata_valid_i = 1;
        indata_i = 128'had00_ad00_ad00_ad00_ad00_ad00_ad00_ad00;

        #10;
        $display("> Reset for indata_valid_i signal");
        indata_valid_i = 0;
        indata_i = 128'h0;

        #20;
        #5;
        $display("< Wait for indata_ready_o signal");
        while(indata_ready_o != 1);
        $display("> Set for indata_valid_i signal");
        indata_valid_i = 1;
        indata_i = 128'had01_ad01_ad01_ad01_ad01_ad01_ad01_ad01;

        #10;
        $display("> Reset for indata_valid_i signal");
        indata_valid_i = 0;
        indata_i = 128'h0;

        // TODO @students implement handling PT, CT, and TAG

        #10;
        $display("< Wait for finish signal");
        @(posedge finish_o)
        $display("> Received finish signal");

        $display("\n=======================================");
        $display("> Finish I/O control test");
        $display("=======================================\n");

        // Finish simulation
        #100;
        $finish;

    end

endmodule : cipher_core_tb 
