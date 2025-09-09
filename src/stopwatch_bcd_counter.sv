`timescale 1ns / 1ps

module stopwatch_bcd_counter (output logic [3:0] bcd, output logic carry_out,
	input logic [3:0] max_digit, input logic carry_in, input logic up_down, input logic rst, input logic clk);

	logic [3:0] next_bcd;

	// sequential logic
	always_ff @(posedge clk) begin
		bcd <= next_bcd;
	end

	// combinational logic
	always_comb begin
		// default values
		next_bcd = bcd;
		carry_out = 1'b0;
		
		if (rst == 1) begin
			next_bcd = 4'd0;
			carry_out = 1'bx;
		end else begin
			casez ({carry_in, up_down})
				2'b0z: begin
					// hold
					next_bcd = bcd;
					carry_out = 1'b0;
				end
				2'b11: begin
				// count up
					if (bcd == max_digit) begin
						next_bcd = 4'd0;
						carry_out = 1'b1;
					end
					else begin
						next_bcd = bcd + 1;
						carry_out = 1'b0;
					end
				end
				2'b10: begin
					// count down
					if (bcd == 4'd0) begin
						next_bcd = max_digit;
						carry_out = 1'b1;
					end
					else begin
						next_bcd = bcd - 1;
						carry_out = 1'b0;
					end
				end
			endcase
		end
	end

endmodule
