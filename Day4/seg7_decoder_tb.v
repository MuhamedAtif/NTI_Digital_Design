module seg7_decoder_tb;

    reg [3:0] test_digit;
    wire [7:0] seg_wires; 
    
    sevenseg uut (
        .num(test_digit),
        .s(seg_wires)
    );
    
    initial begin
        test_digit = 4'b0000;
        #10;
        test_digit = 4'b0001;
        #10;
        test_digit = 4'b0010;
        #10;
        test_digit = 4'b0011;
        #10;
        test_digit = 4'b0100;
        #10;
        test_digit = 4'b0101;
        #10;
        test_digit = 4'b0110;
        #10;
        test_digit = 4'b0111;
        #10;
        test_digit = 4'b1000;
        #10;
        test_digit = 4'b1001;
        #10;
        test_digit = 4'b1111;
        #10;
        $stop;
    end
    
endmodule