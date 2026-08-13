module mux_6to1 ( 
    input [2:0] s_line, 
    input [3:0] d0,
    input [3:0] d1,
    input [3:0] d2,
    input [3:0] d3,
    input [3:0] d4,
    input [3:0] d5,
    output reg [3:0] res   
); 

    always @(*) begin  
        case (s_line)
            3'b000: res = d0;
            3'b001: res = d1;
            3'b010: res = d2;
            3'b011: res = d3;
            3'b100: res = d4;
            3'b101: res = d5;
            default: res = 4'b0000;
        endcase	
    end

endmodule