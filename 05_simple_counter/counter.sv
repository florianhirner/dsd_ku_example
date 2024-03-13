/////////////////////////////////////////////////////////
// 
/////////////////////////////////////////////////////////

module counter_v0 (
    input logic clk_i, // Clock input
    input logic reset_i, // Active-high synchronous reset
    input logic enable_i, // Enable input
    output logic [3:0] counter_value_o, // 4-bit counter output
    output logic done_o // Done output
);

    // Counter register
    logic [3:0] counter;

    // Sequential logic for counter
    always_ff @(posedge clk_i) begin
        if (reset_i) begin
            counter <= 4'h0; // Reset condition
        end
        else if (enable_i) begin
            counter <= counter + 1; // Increment on each clock edge if enable bit is set
        end
        else begin
            counter <= counter; // default condition
        end
    end 

    // Output
    assign counter_value_o = counter;
    assign done_o = (counter == 4'hf);

endmodule

/////////////////////////////////////////////////////////
// 
/////////////////////////////////////////////////////////

module counter_v1 (
    input logic clk_i, // Clock input
    input logic reset_i, // Active-high synchronous reset
    input logic enable_i, // Enable input
    input logic [3:0] counter_init_i, // Initial value input
    input logic [3:0] counter_inc_i, // Increment value input
    input logic [3:0] counter_target_i, // Target value input
    output logic [3:0] counter_value_o, // 4-bit counter output
    output logic done_o // Done output
);

    // Counter register
    logic [4:0] counter;

    // Sequential logic for counter
    always_ff @(posedge clk_i) begin
        if (reset_i) begin
            counter <= counter_init_i; // Reset condition
        end
        else if (enable_i) begin
            counter <= counter + counter_inc_i; // Increment on each clock edge if enable bit is set
        end
        else begin
            counter <= counter; // default condition
        end
    end 

    // Output
    assign counter_value_o = counter;
    assign done_o = (enable_i && counter >= counter_target_i);

endmodule

