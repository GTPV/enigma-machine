//dff9.v
`timescale 1ns / 1ps

module dff9(
    input clk,
    input reset_n,
    input D1,
    input [7:0] D8,
    output reg Q1,
    output reg [7:0] Q8
);
    always @(posedge clk or negedge reset_n) begin
        if(reset_n == 0) begin
            Q1 <= 1'b0;
            Q8 <= 8'b00000000;
        end
        else begin
            Q1 <= D1;
            Q8 <= D8;
        end
    end
endmodule