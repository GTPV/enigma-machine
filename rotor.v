//rotor.v
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
    reg [31:0] Din;
    reg [31:0] Offset;
    reg [31:0] Delay;
    reg [207:0] Idx_in;
    reg [7:0] Dout;

    integer Shifted;
    integer Sel;
    integer Delaycnt;
    integer i;

    reg [2:0] cur, nxt;
    //S0 : reset, S1 : encoding ongoing, S2 : encoding done, S3 : decoding ongoing, S4 : decoding done
    localparam S0=3'b000, S1=3'b001, S2=3'b010, S3=3'b011, S4=3'b100;

    always @(posedge clk or negedge reset_n) begin
        if(reset_n == 0) begin
            cur <= S0;
            Delaycnt = 0;
        end
        else begin
            cur <= nxt;
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
                //reverse rotate roter
                else begin
                    Shifted = Shifted + 26 - Offset;
                    if(Shifted >= 26) begin
                        Shifted = Shifted - 26;
                    end
                end

            end
            if(valid == 1) begin
                Din[7:0] <= din[7:0];
                Delaycnt = 1;
            end
        end
    end

    //state transition
    always @(*) begin
        case(cur)
            S0 : begin
                if(dec == 0) nxt <= S1;
                else nxt <= S3;
            end
            S1 : begin
                if(Delaycnt >= delay) begin
                    nxt <= S2;
                end
            end
            S2 : begin
                nxt <= S0;
            end
            S3 : begin
                if(Delaycnt >= delay) begin
                    nxt <= S4;
                end
            end
            S4 : begin
                nxt <= S0;
            end
            default: ;
        endcase
    end

    //Moore Output
    always @(*) begin
        case(cur)

            S0 : begin
                done <= 0;
                dout = 8'b00000000;
            end

            S1 : begin
                done <= 0;
                dout = 8'b00000000;
            end

            S2 : begin
                done <= 1;
                if((Din - 65 + Shifted) >= 26) begin
                    dout = idx_in[200-(8*(Din-65+Shifted-26)) +: 8];
                end
                else begin
                    dout = idx_in[200-(8*(Din-65+Shifted)) +: 8];
                end
            end

            S3 : begin
                for(i = 0; i < 26; i = i+1) begin
                    if(Din[7:0] == idx_in[200-(i*8) +: 8]) begin
                        if((i - Shifted) >= 0) begin
                            Sel <= i - Shifted;
                        end
                        else begin
                            Sel <= i - Shifted + 26;
                        end
                    end
                end
                done <= 0;
                dout = 8'b00000000;
            end

            S4 : begin
                done <= 1;
                dout = Sel + 65;
            end

            default: ;
        endcase
    end

endmodule
