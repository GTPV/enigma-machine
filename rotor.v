`timescale 1ns / 1ps

module rotor(
    input clk,
    input reset_n,
    input set,
    input en,
    input valid,
    input rot,
    input[7:0] din,
    input[31:0] offset,
    input[31:0] delay,
    input[207:0] idx_in,
    input dec,
    output [7:0] dout,
    output reg done

);
	reg [31:0]cnt, [31:0]delaycnt;

endmodule
