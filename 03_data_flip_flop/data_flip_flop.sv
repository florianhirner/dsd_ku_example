/////////////////////////////////////////////////////////
// Examole of a Data Flip Flop (D-FF)
/////////////////////////////////////////////////////////

module data_flip_flop_v0 (
    input logic clk_i, // Clock input
    input logic rst_i, // Active-High synchronous reset
    input logic d_i, // Data input
    output logic q_o // Data output
);

    // Flip-flop state element
    logic flop_state;

    always_ff @(posedge clk_i) begin
        if (rst_i) begin
            flop_state <= 1'b0; // Reset condition
        end
        else begin
            flop_state <= d_i; // Positive edge-triggered
        end
    end

    // Output
    assign q_o = flop_state;

endmodule

module data_flip_flop_v1 (
    input logic clk_i, // Clock input
    input logic rst_i, // Active-High synchronous reset
    input logic en_i, // Enable input
    input logic d_i, // Data input
    output logic q_o // Data output
);

    // Flip-flop state element
    logic flop_state;

    always_ff @(posedge clk_i) begin // Positive edge-triggered
        if (rst_i) begin
            flop_state <= 1'b0; // Reset condition
        end
        else if (en_i) begin
            flop_state <= d_i; // Update condition
        end
        else begin
            flop_state <= flop_state; // Default - keep state
        end
    end

    // Output
    assign q_o = flop_state;

endmodule

