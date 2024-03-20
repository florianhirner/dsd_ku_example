import cipher_pkg::*;

module cipher_core (
    input  logic                   clk_i,           // Rising edge active clk.
    input  logic                   rst_ni,          // Active low reset.
    input  logic [KEY_LENGTH-1:0]  key_i,           // Encryption key.
    input  logic [DATA_LENGTH-1:0] nonce_i,         // Nonce.
    input  logic [LENGTH-1:0]      data_len_i,      // # of data blocks.
    input  logic [LENGTH-1:0]      ad_len_i,        // # of ad blocks.
    input  logic [DATA_LENGTH-1:0] indata_i,        // Plaintext and AD.
    input  logic                   indata_valid_i,  // Master valid.
    output logic                   indata_ready_o,  // Slave ready.
    output logic [DATA_LENGTH-1:0] outdata_o,       // Ciphertext.
    output logic                   outdata_valid_o, // Slave valid.
    input  logic                   outdata_ready_i, // Master ready.
    output logic [DATA_LENGTH-1:0] tag_o,           // Tag.
    input  logic                   start_i,         // Start signal.
    output logic                   busy_o,          // Cipher busy.
    output logic                   finish_o         // Cipher finish.
);

    
    // ...

    // = blocking assignment
    // <= non-blocking assignment

    state_t curr_state, next_state;

    key_t key;
    logic [LENGTH-1:0] counter_init;
    logic [LENGTH-1:0] counter_rd_ad, counter_rd_ad_max;

    // state logic

    always_ff @(posedge clk_i) begin : currStateReg
        if (rst_ni == 0) begin
            curr_state <= idle;
        end 
        else begin
            curr_state <= next_state;
        end
    end : currStateReg

    always_comb begin : nextStateLogic
        next_state = curr_state; // default is to stay in current state
        case (curr_state)
            idle : begin
                if (start_i == 1) begin
                    next_state = init;
                end
            end
            init : begin
                if (counter_init == 16'h3) begin
                    next_state = read_ad;
                end
            end
            read_ad : begin
                if (indata_valid_i) begin
                    next_state = read_ad_check;
                end
            end
            read_ad_check : begin
                if (counter_rd_ad==counter_rd_ad_max) begin
                    next_state = read_data;
                end
                else begin
                    next_state = read_ad;
                end
            end
            read_data : begin
                next_state = compute;
            end
            compute : begin
                next_state = write_data;
            end
            write_data : begin
                next_state = write_tag;
            end
            write_tag : begin
                next_state = finish;
            end
            finish : begin
                next_state = idle;
            end
            default : begin
                next_state = idle;
            end
        endcase
    end : nextStateLogic

    // data logic

    always_ff @(posedge clk_i) begin : keyReg
        if (rst_ni == 0) begin
            key <= 0;
        end 
        else begin
            key <= key_i;
        end
    end : keyReg

    always_ff @(posedge clk_i) begin : counterDelayInitReg
        if (rst_ni == 0) begin
            counter_init <= 0;
        end 
        else begin
            if (curr_state == init) begin
                counter_init <= counter_init + 1;
            end
        end
    end : counterDelayInitReg

    always_ff @(posedge clk_i) begin : counterRdAdMaxReg
        if (rst_ni == 0) begin
            counter_rd_ad_max <= 0;
        end 
        else begin
            if (curr_state == init) begin
                counter_rd_ad_max <= ad_len_i;
            end
        end
    end : counterRdAdMaxReg

    always_ff @(posedge clk_i) begin : counterRdAdReg
        if (rst_ni == 0) begin
            counter_rd_ad_max <= 0;
        end 
        else begin
            if (curr_state == init) begin
                counter_rd_ad <= 0;
            end
            else if (curr_state == read_ad && indata_ready_o && indata_valid_i) begin
                counter_rd_ad <= counter_rd_ad + 1;
            end
        end
    end : counterRdAdReg

    // output logic

    // TODO Your implementation!

    assign indata_ready_o = (curr_state == read_ad || curr_state == read_data);
    assign outdata_o = {DATA_LENGTH{1'b0}};
    assign outdata_valid_o = 1'b0;
    assign tag_o = {DATA_LENGTH{1'b0}};
    assign busy_o = (curr_state != idle && curr_state != finish);
    assign finish_o = (curr_state == finish);


endmodule : cipher_core
