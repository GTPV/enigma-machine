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

    wire done_1, done_2, done_3, done_11, done_22, done_33;   
    //done_11 = Done
    wire done_reflector;

    wire [7:0] dout_1;
    wire [7:0] dout_2;
    wire [7:0] dout_3;
    wire [7:0] dout_11;
    wire [7:0] dout_22;
    wire [7:0] dout_33;
    //dout_11 = dout
    wire [7:0] dout_reflector;

    reg [7:0] Dout_1;
    reg [7:0] Dout_2;
    reg [7:0] Dout_3;
    reg [7:0] Dout_33;
    reg [7:0] Dout_22;
    reg [7:0] Dout_11;


    rotor Rotor1(.clk(clk), .reset_n(reset_n), .set(set), .en(en), .valid(valid), .rot(1'b1), .din(din), .offset(first_offset), .delay(first_delay), .idx_in(first_idx_in), .dec(dec), .dout(dout_1), .done(done_1));

    wire valid_2;
    wire [7:0] din_2;
    dff Done1_valid2(.clk(clk), .reset_n(reset_n), .Q(valid_2), .D(done_1));
    dff8 Dout1_Din2(.clk(clk), .reset_n(reset_n), .Q(din_2), .D(dout_1));

    rotor Rotor2(.clk(clk), .reset_n(reset_n), .set(set), .en(en), .valid(valid_2), .rot(1'b1), .din(din_2), .offset(second_offset), .delay(second_delay), .idx_in(second_idx_in), .dec(dec), .dout(dout_2), .done(done_2));

    wire valid_3;
    wire [7:0] din_3;
    dff Done2_valid3(.clk(clk), .reset_n(reset_n), .Q(valid_3), .D(done_2));
    dff8 Dout2_Din3(.clk(clk), .reset_n(reset_n), .Q(din_3), .D(dout_2));

    rotor Rotor3(.clk(clk), .reset_n(reset_n), .set(set), .en(en), .valid(valid_3), .rot(1'b1), .din(din_3), .offset(third_offset), .delay(third_delay), .idx_in(third_idx_in), .dec(dec), .dout(dout_3), .done(done_3));

    wire valid_reflector;
    wire [7:0] din_reflector;
    dff Done3_validReflector(.clk(clk), .reset_n(reset_n), .Q(valid_reflector), .D(done_3));
    dff8 Dout3_DinReflector(.clk(clk), .reset_n(reset_n), .Q(din_reflector), .D(dout_3));

    reflector Reflector(.clk(clk), .reset_n(reset_n), .set(set), .idx_in(reflector_idx_in), .valid(valid_reflector), .din(din_reflector), .dec(dec), .dout(dout_reflector), .done(done_reflector));

    rotor Rotor33(.clk(clk), .reset_n(reset_n), .set(set), .en(en), .valid(done_reflector), .rot(1'b1), .din(dout_reflector), .offset(third_offset), .delay(third_delay), .idx_in(third_idx_in), .dec(dec), .dout(dout_33), .done(done_33));

    wire valid_22;
    wire [7:0] din_22;
    dff Done33_valid22(.clk(clk), .reset_n(reset_n), .Q(valid_22), .D(done_33));
    dff8 Dout33_Din22(.clk(clk), .reset_n(reset_n), .Q(din_22), .D(dout_33));

    rotor Rotor22(.clk(clk), .reset_n(reset_n), .set(set), .en(en), .valid(valid_22), .rot(1'b1), .din(din_22), .offset(second_offset), .delay(second_delay), .idx_in(second_idx_in), .dec(dec), .dout(dout_22), .done(done_22));

    wire valid_11;
    wire [7:0] din_11;
    dff Done22_valid11(.clk(clk), .reset_n(reset_n), .Q(valid_11), .D(done_22));
    dff8 Dout22_Din11(.clk(clk), .reset_n(reset_n), .Q(din_11), .D(dout_22));

    rotor Rotor11(.clk(clk), .reset_n(reset_n), .set(set), .en(en), .valid(valid_11), .rot(1'b1), .din(din_11), .offset(first_offset), .delay(first_delay), .idx_in(first_idx_in), .dec(dec), .dout(dout), .done(done));

endmodule
