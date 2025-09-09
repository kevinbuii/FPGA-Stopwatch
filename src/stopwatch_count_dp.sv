`timescale 1ns / 1ps

module stopwatch_dp (output logic [3:0] digit5, output logic [3:0] digit4, output logic [3:0] digit3, output logic [3:0] digit2,
	output logic [3:0] digit1, output logic [3:0] digit0,
	input logic enable, input logic up_down, input logic rst, input clk);

	logic c_out0, c_out1, c_out2, c_out3, c_out4, c_out5;	// internal carry out signals

	// instantiate the 6 binary coded decimal counters
	stopwatch_bcd_counter u_bcd0 (.bcd(digit0), .carry_out(c_out0),
		.carry_in(enable), .up_down, .rst, .clk, .max_digit(4'd9));

	stopwatch_bcd_counter u_bcd1 (.bcd(digit1), .carry_out(c_out1),
		.carry_in(c_out0), .up_down, .rst, .clk, .max_digit(4'd9));

	stopwatch_bcd_counter u_bcd2 (.bcd(digit2), .carry_out(c_out2),
		.carry_in(c_out1), .up_down, .rst, .clk, .max_digit(4'd9));

	stopwatch_bcd_counter u_bcd3 (.bcd(digit3), .carry_out(c_out3),
		.carry_in(c_out2), .up_down, .rst, .clk, .max_digit(4'd5));
		
	stopwatch_bcd_counter u_bcd4 (.bcd(digit4), .carry_out(c_out4),
		.carry_in(c_out3), .up_down, .rst, .clk, .max_digit(4'd9));
		
	stopwatch_bcd_counter u_bcd5 (.bcd(digit5), .carry_out(c_out5),
		.carry_in(c_out4), .up_down, .rst, .clk, .max_digit(4'd5));

endmodule
