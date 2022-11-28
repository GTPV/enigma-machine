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

    always @(posedge clk or negedge reset_n)
    begin
        if(reset_n == 0) begin
            for(i=0;i<208;i=i+1) Idx_in[i]<=1'b0;
        end
        else begin 
            if(set) begin 
                Idx_in<=idx_in;
            end
            if(valid) begin
                Din[7:0] <= din[7:0];
            end
            if(done)
            begin
                dout<=out_reg;
                done<=1'b0;
            end
        end
    end
    always @(*)
    begin
        if(!dec)
        begin
            out_reg<=Idx_in[200-(Din-65)*8 +: 8];
        end
        else
        begin
            for(i=0;i<26;i=i+1)
            begin
                if(Din==Idx_in[200-i*8 +: 8]) out_reg<=Idx_in[200-i*8 +: 8];
            end
        end
        done<=1'b1;
    end

endmodule