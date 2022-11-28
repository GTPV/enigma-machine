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
    output[7:0] dout,
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

    wire dout_1, dout_2, dout_3, dout_11, dout_22, dout_33;
    //dout_11 = dout
    wire dout_reflector;

    reg [7:0] Dout;
    reg Done;

    always @(posedge clk or negedge reset_n) begin
        if(reset_n == 1'b0) begin
            Dout <= 8'b00000000;
            Done <= 1'b0;
        end
        if(Done == 1'b1) begin
            dout <= Dout;
            Done <= 1'b0;
        end
    end

    rotor Rotor1(.clk(clk), .reset_n(reset_n), .set(set), .en(en), .valid(valid), .rot(1'b1), .din(din), .offset(first_offset), .delay(first_delay), .idx_in(first_idx_in), .dec(dec), .dout(dout_1), .done(done_1));
    rotor Rotor2(.clk(clk), .reset_n(reset_n), .set(set), .en(en), .valid(done_1), .rot(1'b1), .din(dout_1), .offset(second_offset), .delay(second_delay), .idx_in(second_idx_in), .dec(dec), .dout(dout_2), .done(done_2));
    rotor Rotor3(.clk(clk), .reset_n(reset_n), .set(set), .en(en), .valid(done_2), .rot(1'b1), .din(dout_2), .offset(third_offset), .delay(third_delay), .idx_in(third_idx_in), .dec(dec), .dout(dout_3), .done(dont_3));
    reflector Reflector(.clk(clk), .reset_n(reset_n), .set(set), .idx_in(reflector_idx_in), .valid(done_3) .din(dout_3), .dec(dec), .dout(dout_reflector), .done(done_reflector));
    rotor Rotor33(.clk(clk), .reset_n(reset_n), .set(set), .en(en), .valid(done_reflector), .rot(1'b1), .din(dout_reflector), .offset(third_offset), .delay(third_delay), .idx_in(third_idx_in), .dec(dec), .dout(dout_33), .done(done_33));
    rotor Rotor22(.clk(clk), .reset_n(reset_n), .set(set), .en(en), .valid(done_33), .rot(1'b1), .din(dout_33), .offset(second_offset), .delay(second_delay), .idx_in(second_idx_in), .dec(dec), .dout(dout_22), .done(done_22));
    rotor Rotor11(.clk(clk), .reset_n(reset_n), .set(set), .en(en), .valid(done_22), .rot(1'b1), .din(dout_22), .offset(first_offset), .delay(first_delay), .idx_in(first_idx_in), .dec(dec), .dout(Dout), .done(Done));

endmodule
