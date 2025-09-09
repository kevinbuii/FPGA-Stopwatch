`timescale 1ns / 1ps

module counter_divider (output reg tc, 
    input logic clk, input logic ena, input logic rst, input wire [18:0] i_count);

    reg [18:0] counts, next_count;
    
    // seq logic
    always_ff @ (posedge clk) begin
        counts <= next_count;
    end
    
    // comb logic
    always @* begin
        // default
        tc = 1'b0;
        next_count = counts;
        
        if (ena == 1'b1) begin
            next_count = counts - 1;
            if (counts == 0) begin
                tc = 1;
                next_count = i_count;
            end
        end
        
        // priority logic
        if (rst == 1) begin
            next_count = i_count;
        end
    end
endmodule