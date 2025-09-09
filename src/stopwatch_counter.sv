`timescale 1ns / 1ps

module stopwatch_counter (output logic [6:0] hex0, output logic [6:0] hex1,
	output logic [6:0] hex2, output logic [6:0] hex3, output logic [6:0] hex4, output logic [6:0] hex5,
	input logic light, input logic start , input logic rst, input logic clk);

	// digit signals
	logic [3:0] digit5, digit4, digit3, digit2, digit1, digit0;
	logic up_down, enable;
	logic tc;
	
	// instantiate stopwatch finite state machine
	stopwatch_fsm u_fsm (.enable(enable), .up_down(up_down), .start(start), .light(light), .rst(rst), .clk(clk));
	
	// instantiate the counter divider
	counter_divider d_cd (.tc(tc), .clk(clk), .ena(1'b1), .rst(rst), .i_count(19'd500000));

	// instantiate stopwatch data path
	stopwatch_dp u_uddp (.digit5(digit5), .digit4(digit4), .digit3(digit3), .digit2(digit2), .digit1(digit1), .digit0(digit0), .enable(tc & enable), .up_down(up_down), .rst(rst), .clk(clk));
	
	// instantiate seven segment display for each digilight (6 digits)
	svn_seg_decoder u_sd0 (.seg_out(hex0), .bcd_in(digit0), .display_on(1'b1));
	svn_seg_decoder u_sd1 (.seg_out(hex1), .bcd_in(digit1), .display_on(1'b1));
	svn_seg_decoder u_sd2 (.seg_out(hex2), .bcd_in(digit2), .display_on(1'b1));
	svn_seg_decoder u_sd3 (.seg_out(hex3), .bcd_in(digit3), .display_on(1'b1));
	svn_seg_decoder u_sd4 (.seg_out(hex4), .bcd_in(digit4), .display_on(1'b1));
	svn_seg_decoder u_sd5 (.seg_out(hex5), .bcd_in(digit5), .display_on(1'b1));

endmodule
