//dff8.v
`timescale 1ns / 1ps

module dff8(
    input clk,
    input reset_n,
    input [7:0] D,
    output reg [7:0] Q
);
    always @(posedge clk or negedge reset_n) begin
        if(reset_n == 0) begin
            Q <= 8'b00000000;
        end
        else begin
            Q <= D;
        end
    end
endmodule