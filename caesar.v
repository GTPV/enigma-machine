`timescale 1ns / 1ps

module caesar(
    input[207:0] idx_in,
    input[31:0] sel,
    output[7:0] res

);

    always @ (*) begin
        if(sel >= 26) sel = sel - 26;
        else res[7:0] = idx_in[207-(sel*8):200-(sel*8)];
    end

endmodule