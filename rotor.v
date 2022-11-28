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
    reg [7:0] Din;
    reg [31:0] Offset;
    reg [31:0] Delay;
    reg [207:0] Idx_in;

    integer Shifted;
    integer Sel;
    integer Delaycnt;
    reg [7:0] Dout;

    always @(posedge clk or negedge reset_n) begin
        if(reset_n == 0) begin
            Din = 0;
            Offset = 0;
            Delay = 0;
            Idx_in = 0;
            Shifted = 0;
            Sel = 0;
            Delaycnt = 0;
            Dout = 0;
        end
        else begin
            if(set == 1) begin
                Offset <= offset;
                Delay <= delay;
                Idx_in <= idx_in;
            end
            if(en == 1) begin
                Delaycnt = Delaycnt + 1;

                //rotate roter
                if(dec == 0) begin
                    Shifted = Shifted + Offset;
                    if(Shifted >= 26) begin
                        Shifted = Shifted - 26;
                    end
                end
                else begin
                    Shifted = Shifted + 26 - Offset;
                    if(Shifted >= 26) begin
                        Shifted = Shifted - 26;
                    end
                end

            end
            if(valid == 1) begin
                Din = din;
                Delaycnt = 1;
            end
            if(done == 1) begin
                dout <= Dout;
                done <= 0;
            end
        end
    end


    always @(*) begin
        if(Delaycnt >= Delay) begin

            //caesar(.idx_in(Idx_in), .sel(Sel), .res(Dout));
            if(dec == 0) begin
                Sel = Din + Shifted;
                if(Sel >= 26) Sel = Sel - 26;
                Dout[7:0] = idx_in[207-(Sel*8):200-(Sel*8)];
            end
            else begin
                for(integer i = 0; i < 26; i = i+1) begin
                    if(Din[7:0] == idx_in[207-(i*8):200-(i*8)]) begin
                        Sel = i - Shifted;
                        if(Sel < 0) Sel = Sel + 26;
                        Dout[7:0] = idx_in[207-(Sel*8):200-(Sel*8)];
                    end
                end
            end

            done = 1;
        end
    end

endmodule
