module AOI(
    input  wire a,
    input  wire b,
    input  wire c,
    input  wire d,
    output wire out,
    output wire out_n 
); 

    assign out = (a & b) | (c & d);
    
    assign out_n = ~out;

endmodule