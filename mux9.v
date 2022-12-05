//mux9.v
`timescale 1ns / 1ps

module mux9(
    input sel,
    input a1,
    input [7:0] a8,
    input b1,
    input [7:0] b8,
    output o1,
    output [7:0] o8
);
    assign o1 = (a1 & (!sel)) | (b1 & sel);
    assign o8[7] = (a8[7] & (!sel)) | (b8[7] & sel);
    assign o8[6] = (a8[6] & (!sel)) | (b8[7] & sel);
    assign o8[5] = (a8[5] & (!sel)) | (b8[7] & sel);
    assign o8[4] = (a8[4] & (!sel)) | (b8[7] & sel);
    assign o8[3] = (a8[3] & (!sel)) | (b8[7] & sel);
    assign o8[2] = (a8[2] & (!sel)) | (b8[7] & sel);
    assign o8[1] = (a8[1] & (!sel)) | (b8[7] & sel);
    assign o8[0] = (a8[0] & (!sel)) | (b8[7] & sel);

endmodule