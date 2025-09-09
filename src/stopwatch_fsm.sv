`timescale 1ns / 1ps
// stopwatch_fsm.sv
module stopwatch_fsm (output logic enable, output logic up_down,
	input logic start, input logic light,
	input logic rst, input logic clk);

	enum logic [1:0] {HOLD, UP} state, next_state;

	// sequential logic
	always_ff @(posedge clk) begin
		state <= next_state;
	end

	// combinational logic
	always_comb begin
		// defaults
		next_state = state;
		enable = 1'b0;
		up_down = 1'b0;
		// main logic
		if (rst == 1'b1) begin	// priority logic
			next_state = HOLD;	
		end else begin
			case (state)
				HOLD: begin
					enable = 1'b0;
					
					if (start == 1'b1) begin
						next_state = UP;
					end
				end
				UP: begin
					up_down = 1'b1;
					enable = 1'b1;
					
					if (light == 1'b1) begin
						next_state = HOLD;
					end
				end
			endcase
		end
	end

endmodule
