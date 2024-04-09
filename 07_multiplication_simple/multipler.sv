import multipler_pkg::*;

module multipler (
    input  logic                        clk_i,           // Rising edge active clk.
    input  logic                        rst_ni,          // Active low reset.
    input  logic                        start_i,         // Start signal.
    output logic                        busy_o,          // Module busy.
    output logic                        finish_o,        // Module finish.
    input  logic [DATA_LENGTH-1:0]      indata_a_i,      // Input data -> operand a.
    input  logic [DATA_LENGTH-1:0]      indata_b_i,      // Input data -> operand b.
    output logic [DATA_LENGTH*2-1:0]    outdata_r_o      // Output data -> result a*b.
);

state_t curr_state, next_state;

logic ctrl_update_operands;
logic ctrl_update_result;

logic [DATA_LENGTH-1:0] operand_a;
logic [DATA_LENGTH-1:0] operand_b;
logic [DATA_LENGTH*2-1:0] result;

// counter_t indata_counter;

///////////////////////////////////////////////////////////////////////////////
// State logic
///////////////////////////////////////////////////////////////////////////////

always_comb begin
    ctrl_update_operands   = (curr_state == init);
    ctrl_update_result = (curr_state == compute);
end

always_ff @(posedge clk_i) begin
    if (rst_ni == 0) begin
        curr_state <= idle;
    end 
    else begin
        curr_state <= next_state;
    end
end

always_comb begin
    next_state = curr_state; // default is to stay in current state
    case (curr_state)
        idle : begin
            if (start_i == 1) begin
                next_state = init;
            end
        end
        init : begin
            next_state = compute;
        end
        compute : begin
            next_state = finish;
        end
        finish : begin
            next_state = idle;
        end
        default : begin
            next_state = idle;
        end
    endcase
end

///////////////////////////////////////////////////////////////////////////////
// Data logic
///////////////////////////////////////////////////////////////////////////////

always_ff @(posedge clk_i) begin
    if (rst_ni == 0) begin
        operand_a <= 0;
    end 
    else if (ctrl_update_operands) begin
        operand_a <= indata_a_i;
    end
end

always_ff @(posedge clk_i) begin
    if (rst_ni == 0) begin
        operand_b <= 0;
    end 
    else if (ctrl_update_operands) begin
        operand_b <= indata_b_i;
    end
end

always_ff @(posedge clk_i) begin
    if (rst_ni == 0) begin
        result <= 0;
    end 
    else if (ctrl_update_result) begin
        result <= operand_a * operand_b;
    end
end

///////////////////////////////////////////////////////////////////////////////
// Output logic
///////////////////////////////////////////////////////////////////////////////

assign busy_o = (curr_state != idle && curr_state != finish);
assign finish_o = (curr_state == finish);

assign outdata_r_o = result;

endmodule : multipler