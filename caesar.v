`timescale 1ns / 1ps

module caesar(
    input[207:0] idx_in,
    input[31:0] sel,
    output[7:0] res

);

    always @ (*)
    begin
        if(sel == 0)
            begin
                res[7] = idx_in[207]; res[6] = idx_in[206]; res[5] = idx_in[205]; res[4] = idx_in[204]; res[3] = idx_in[203]; res[2] = idx_in[202]; res[1] = idx_in[201]; res[0] = idx_in[200];
            end
        else if(sel == 1)
            begin
                res[7] = idx_in[199]; res[6] = idx_in[198]; res[5] = idx_in[197]; res[4] = idx_in[196]; res[3] = idx_in[195]; res[2] = idx_in[194]; res[1] = idx_in[193]; res[0] = idx_in[192];
            end
        else if(sel == 2)
            begin
                res[7] = idx_in[191]; res[6] = idx_in[190]; res[5] = idx_in[189]; res[4] = idx_in[188]; res[3] = idx_in[187]; res[2] = idx_in[186]; res[1] = idx_in[185]; res[0] = idx_in[184];
            end
        else if(sel == 3)
            begin
                res[7] = idx_in[183]; res[6] = idx_in[182]; res[5] = idx_in[181]; res[4] = idx_in[180]; res[3] = idx_in[179]; res[2] = idx_in[178]; res[1] = idx_in[177]; res[0] = idx_in[176];
            end
        else if(sel == 4)
            begin
                res[7] = idx_in[175]; res[6] = idx_in[174]; res[5] = idx_in[173]; res[4] = idx_in[172]; res[3] = idx_in[171]; res[2] = idx_in[170]; res[1] = idx_in[169]; res[0] = idx_in[168];
            end
        else if(sel == 5)
            begin
                res[7] = idx_in[167]; res[6] = idx_in[166]; res[5] = idx_in[165]; res[4] = idx_in[164]; res[3] = idx_in[163]; res[2] = idx_in[162]; res[1] = idx_in[161]; res[0] = idx_in[160];
            end
        else if(sel == 6)
            begin
                res[7] = idx_in[159]; res[6] = idx_in[158]; res[5] = idx_in[157]; res[4] = idx_in[156]; res[3] = idx_in[155]; res[2] = idx_in[154]; res[1] = idx_in[153]; res[0] = idx_in[152];
            end
        else if(sel == 7)
            begin
                res[7] = idx_in[151]; res[6] = idx_in[150]; res[5] = idx_in[149]; res[4] = idx_in[148]; res[3] = idx_in[147]; res[2] = idx_in[146]; res[1] = idx_in[145]; res[0] = idx_in[144];
            end
        else if(sel == 8)
            begin
                res[7] = idx_in[143]; res[6] = idx_in[142]; res[5] = idx_in[141]; res[4] = idx_in[140]; res[3] = idx_in[139]; res[2] = idx_in[138]; res[1] = idx_in[137]; res[0] = idx_in[136];
            end
        else if(sel == 9)
            begin
                res[7] = idx_in[135]; res[6] = idx_in[134]; res[5] = idx_in[133]; res[4] = idx_in[132]; res[3] = idx_in[131]; res[2] = idx_in[130]; res[1] = idx_in[129]; res[0] = idx_in[128];
            end
        else if(sel == 10)
            begin
                res[7] = idx_in[127]; res[6] = idx_in[126]; res[5] = idx_in[125]; res[4] = idx_in[124]; res[3] = idx_in[123]; res[2] = idx_in[122]; res[1] = idx_in[121]; res[0] = idx_in[120];
            end
        else if(sel == 11)
            begin
                res[7] = idx_in[119]; res[6] = idx_in[118]; res[5] = idx_in[117]; res[4] = idx_in[116]; res[3] = idx_in[115]; res[2] = idx_in[114]; res[1] = idx_in[113]; res[0] = idx_in[112];
            end
        else if(sel == 12)
            begin
                res[7] = idx_in[111]; res[6] = idx_in[110]; res[5] = idx_in[109]; res[4] = idx_in[108]; res[3] = idx_in[107]; res[2] = idx_in[106]; res[1] = idx_in[105]; res[0] = idx_in[104];
            end
        else if(sel == 13)
            begin
                res[7] = idx_in[103]; res[6] = idx_in[102]; res[5] = idx_in[101]; res[4] = idx_in[100]; res[3] = idx_in[99]; res[2] = idx_in[98]; res[1] = idx_in[97]; res[0] = idx_in[96];
            end
        else if(sel == 14)
            begin
                res[7] = idx_in[95]; res[6] = idx_in[94]; res[5] = idx_in[93]; res[4] = idx_in[92]; res[3] = idx_in[91]; res[2] = idx_in[90]; res[1] = idx_in[89]; res[0] = idx_in[88];
            end
        else if(sel == 15)
            begin
                res[7] = idx_in[87]; res[6] = idx_in[86]; res[5] = idx_in[85]; res[4] = idx_in[84]; res[3] = idx_in[83]; res[2] = idx_in[82]; res[1] = idx_in[81]; res[0] = idx_in[80];
            end
        else if(sel == 16)
            begin
                res[7] = idx_in[79]; res[6] = idx_in[78]; res[5] = idx_in[77]; res[4] = idx_in[76]; res[3] = idx_in[75]; res[2] = idx_in[74]; res[1] = idx_in[73]; res[0] = idx_in[72];
            end
        else if(sel == 17)
            begin
                res[7] = idx_in[71]; res[6] = idx_in[70]; res[5] = idx_in[69]; res[4] = idx_in[68]; res[3] = idx_in[67]; res[2] = idx_in[66]; res[1] = idx_in[65]; res[0] = idx_in[64];
            end
        else if(sel == 18)
            begin
                res[7] = idx_in[63]; res[6] = idx_in[62]; res[5] = idx_in[61]; res[4] = idx_in[60]; res[3] = idx_in[59]; res[2] = idx_in[58]; res[1] = idx_in[57]; res[0] = idx_in[56];
            end
        else if(sel == 19)
            begin
                res[7] = idx_in[55]; res[6] = idx_in[54]; res[5] = idx_in[53]; res[4] = idx_in[52]; res[3] = idx_in[51]; res[2] = idx_in[50]; res[1] = idx_in[49]; res[0] = idx_in[48];
            end
        else if(sel == 20)
            begin
                res[7] = idx_in[47]; res[6] = idx_in[46]; res[5] = idx_in[45]; res[4] = idx_in[44]; res[3] = idx_in[43]; res[2] = idx_in[42]; res[1] = idx_in[41]; res[0] = idx_in[40];
            end
        else if(sel == 21)
            begin
                res[7] = idx_in[39]; res[6] = idx_in[38]; res[5] = idx_in[37]; res[4] = idx_in[36]; res[3] = idx_in[35]; res[2] = idx_in[34]; res[1] = idx_in[33]; res[0] = idx_in[32];
            end
        else if(sel == 22)
            begin
                res[7] = idx_in[31]; res[6] = idx_in[30]; res[5] = idx_in[29]; res[4] = idx_in[28]; res[3] = idx_in[27]; res[2] = idx_in[26]; res[1] = idx_in[25]; res[0] = idx_in[24];
            end
        else if(sel == 23)
            begin
                res[7] = idx_in[23]; res[6] = idx_in[22]; res[5] = idx_in[21]; res[4] = idx_in[20]; res[3] = idx_in[19]; res[2] = idx_in[18]; res[1] = idx_in[17]; res[0] = idx_in[16];
            end
        else if(sel == 24)
            begin
                res[7] = idx_in[15]; res[6] = idx_in[14]; res[5] = idx_in[13]; res[4] = idx_in[12]; res[3] = idx_in[11]; res[2] = idx_in[10]; res[1] = idx_in[9]; res[0] = idx_in[8];
            end
        else if(sel == 25)
            begin
                res[7] = idx_in[7]; res[6] = idx_in[6]; res[5] = idx_in[5]; res[4] = idx_in[4]; res[3] = idx_in[3]; res[2] = idx_in[2]; res[1] = idx_in[1]; res[0] = idx_in[0];
            end
    end

endmodule