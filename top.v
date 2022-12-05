//top.v
`timescale 1ns / 1ps

module top(
    input clk,
    input reset_n,
    input set,
    input en,
    input valid,
    input[7:0] din,
    input dec,
    output [7:0] dout,
    output done,

    input[31:0] first_offset,
    input[31:0] second_offset,
    input[31:0] third_offset,
    input[31:0] first_delay,
    input[31:0] second_delay,
    input[31:0] third_delay,
    input[207:0] first_idx_in,
    input[207:0] second_idx_in,
    input[207:0] third_idx_in,
    input [207:0] reflector_idx_in
);

    wire [7:0] wdin1;
    wire wvalid1;
    wire [7:0] wdout1;
    wire wdone1;

    wire [7:0] wdin2;
    wire wvalid2;
    wire [7:0] wdout2;
    wire wdone2;

    wire [7:0] wdin3;
    wire wvalid3;
    wire [7:0] wdout3;
    wire wdone3;

    wire [7:0] wdinreflector;
    wire wvalidreflector;
    wire [7:0] wdoutreflector;
    wire wdonereflector;

    wire [7:0] wdout1_din2;
    wire wdone1_valid2;

    wire [7:0] wdout2_din3;
    wire wdone2_valid3;

    wire [7:0] wdout3_dinreflector;
    wire wdone3_validreflector;

    wire dff_reset;

    assign dff_reset = !((!reset_n) | valid | done);


    reg reflected;

    always @(posedge valid or posedge wdonereflector or negedge reset_n) begin
        if(reset_n == 0) begin
            reflected <= 1'b0;
        end
        else if(valid == 1) begin
            reflected <= 1'b0;
        end
        else if(wdonereflector) begin
            reflected <= 1'b1;
        end
    end

    mux9 Mux1(
        .sel(reflected),
        .a1(valid), .a8(din),
        .b1(wdone2_valid3), .b8(wdout2_din3),
        .o1(wvalid1), .o8(wdin1)
    );

    rotor Rotor1(
        .clk(clk), .reset_n(reset_n), .set(set), .en(en), .rot(1'b1), .dec(dec),
        .offset(first_offset), .delay(first_delay), .idx_in(first_idx_in),
        .valid(wvalid1), .din(wdin1),
        .done(wdone1), .dout(wdout1)
    );

    dff9 DFF1(
        .clk(clk), .reset_n(dff_reset),
        .D1(wdone1), .D8(wdout1),
        .Q1(wdone1_valid2), .Q8(wdout1_din2)
    );

    mux9 Mux2(
        .sel(reflected),
        .a1(wdone1_valid2), .a8(wdout1_din2),
        .b1(wdone3_validreflector), .b8(wdout3_dinreflector),
        .o1(wvalid2), .o8(wdin2)
    );

    rotor Rotor2(
        .clk(clk), .reset_n(reset_n), .set(set), .en(en), .rot(1'b1), .dec(dec),
        .offset(second_offset), .delay(second_delay), .idx_in(second_idx_in),
        .valid(wvalid2), .din(wdin2),
        .done(wdone2), .dout(wdout2)
    );

    dff9 DFF2(
        .clk(clk), .reset_n(dff_reset),
        .D1(wdone2), .D8(wdout2),
        .Q1(wdone2_valid3), .Q8(wdout2_din3)
    );

    mux9 Mux3(
        .sel(reflected),
        .a1(wdone2_valid3), .a8(wdout2_din3),
        .b1(wdonereflector), .b8(wdoutreflector),
        .o1(wvalid3), .o8(wdin3)
    );
    
    rotor Rotor3(
        .clk(clk), .reset_n(reset_n), .set(set), .en(en), .rot(1'b1), .dec(dec),
        .offset(third_offset), .delay(third_delay), .idx_in(third_idx_in),
        .valid(wvalid3), .din(wdin3),
        .done(wdone3), .dout(wdout3)
    );

    dff9 DFF3(
        .clk(clk), .reset_n(dff_reset),
        .D1(wdone3), .D8(wdout3),
        .Q1(wdone3_validreflector), .Q8(wdout3_dinreflector)
    );

    mux9 Mux4(
        .sel(reflected),
        .a1(wdone3_validreflector), .a8(wdout3_dinreflector),
        .b1(1'b0), .b8(8'b00000000),
        .o1(wvalidreflector), .o8(wdinreflector)
    );

    reflector Reflector(.clk(clk), .reset_n(reset_n), .set(set), .idx_in(reflector_idx_in), .valid(wvalidreflector), .din(wdinreflector), .dec(dec), .dout(wdoutreflector), .done(wdonereflector));

    mux9 MuxOut(
        .sel(reflected),
        .a1(1'b0), .a8(8'b00000000),
        .b1(wdone1), .b8(wdout1),
        .o1(done), .o8(dout)
    );

endmodule
