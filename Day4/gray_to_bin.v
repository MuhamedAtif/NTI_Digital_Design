module gray_to_bin (
    input  [3:0] g_code,
    output reg [3:0] b_code
);
    always @(*) begin
        b_code[3] = g_code[3];
        b_code[2] = g_code[3] ~^ g_code[2];
        b_code[1] = g_code[2] ~^ g_code[1];
        b_code[0] = g_code[1] ~^ g_code[0];
    end
endmodule