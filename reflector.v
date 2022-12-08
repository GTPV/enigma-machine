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
    reg [31:0] Din;

    integer i;
    reg cur, nxt;
    //S0 : none, S1 : output
    localparam S0=1'b0, S1=1'b1;

    //setting
    always @(posedge clk or negedge reset_n) begin
        if(reset_n == 0) begin
            Idx_in <= {208{1'b0}};
            Din <= {32{1'b0}};
        end
        else begin
            if(set == 1) Idx_in <= idx_in;
            if(valid == 1) Din <= din;
        end
    end

    //state transition
    always @(posedge clk or negedge reset_n) begin
        if(reset_n == 0) cur <= S0;
        else cur <= nxt;
    end

    //decide next state
    always @(*) begin
        case(cur)

            S0 : begin
                if(valid) nxt <= S1;
                else nxt <= S0;
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
				end
            end

            default : ;
        endcase
    end

endmodule
