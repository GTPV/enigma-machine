//dff.v
`timescale 1ns / 1ps

module dff(
    input clk,
    input reset_n,
    input D,
    output reg Q
);
    always @(posedge clk or negedge reset_n) begin
        if(reset_n == 0) begin
            Q <= 1'b0;
        end
        else begin
            Q <= D;
        end
    end
endmodule