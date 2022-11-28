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
    reg [207:0] idx;
    reg [7:0] out_reg;
    always @(posedge clk or negedge reset_n)
    begin
        if(reset_n == 0) begin
            for(integer i=0;i<208;i=i+1) idx[i]<=1'b0;
        end
        else begin 
            if(set) idx<=idx_in;
            if(done)
            begin
                dout<=out_reg;
                done<=1'b0;
            end
        end
    end
    always @(*)
    begin
        if(valid)
        begin
            if(!dec)
            begin
                out_reg<=idx[207-(din-65)*8:200-(din-65)*8];
            end
            else
            begin
                for(integer i=0;i<26;i=i+1)
                begin
                    if(din==idx[207-i*8:200-i*8]) out_reg<=idx[207-i*8:200-i*8];
                end
            end
            done<=1'b1;
        end
    end

endmodule