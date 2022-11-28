//reflector.v
`timescale 1ns / 1ps

module reflector(
    input clk,
    input reset_n,
    input set,
    input [207:0] idx_in,
    input valid,
    input[7:0] din,
    input dec,
    output reg [7:0] dout,
    output reg done
);
    reg [207:0] Idx_in;
    reg [7:0] out_reg;
    reg [31:0] Din;

    integer i;
    reg cur, nxt;
    //S0 : none, S1 : output
    localparam S0=1'b0, S1=1'b1;

    always @(posedge clk or negedge reset_n)
    begin
        if(reset_n == 0) begin
            for(i=0;i<208;i=i+1) Idx_in[i]<=1'b0;
        end
        else begin 
            cur <= nxt;
            if(set) begin 
                Idx_in<=idx_in;
            end
            if(valid) begin
                Din[7:0] <= din[7:0];
            end
        end
    end

    //state transition
    always @(*) begin
        case(cur)

            S0 : begin
                if(valid) nxt <= S1;
            end

            S1 : begin
                nxt <= S0;
            end

            default : ;
        endcase
    end

    //Moore output
    always @(*) begin
        case(cur)

            S0 : begin
                done <= 0;
                dout <= 8'b00000000;
            end

            S1 : begin
                done <= 1;
                if(dec == 0) begin
                    dout <= Idx_in[200 - (8*(Din-65)) +: 8];
                end
                else begin
                    for(i = 0; i < 26; i = i+1) begin
                        if(Din[7:0] == Idx_in[200 - (8*i) +: 8]) begin
                            dout <= 65 + i;
                        end
                    end
                else
            end

            default : ;
        endcase
    end

endmodule