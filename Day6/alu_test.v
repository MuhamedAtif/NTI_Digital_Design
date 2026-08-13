module alu_test;

    parameter WIDTH = 8;
    
    reg [WIDTH-1:0] in_a;
    reg [WIDTH-1:0] in_b;
    reg [2:0] opcode;
    wire [WIDTH-1:0] alu_out;
    wire a_is_zero;

    alu #(WIDTH) dut (
        .in_a(in_a),
        .in_b(in_b),
        .opcode(opcode),
        .alu_out(alu_out),
        .a_is_zero(a_is_zero)
    );

    initial begin
        in_a = 8'b01000010; 
        in_b = 8'b10000110;
        
        opcode = 3'b000; #1;
        opcode = 3'b001; #1;
        opcode = 3'b010; #1;
        opcode = 3'b011; #1;
        opcode = 3'b100; #1;
        opcode = 3'b101; #1;
        opcode = 3'b110; #1;
        opcode = 3'b111; #1;
        
        in_a = 8'b00000000; 
        opcode = 3'b111; #1;
        
        $stop;
    end

endmodule