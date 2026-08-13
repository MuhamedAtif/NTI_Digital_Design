module shift_reg ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] out 
);

    wire [7:0] q1, q2, q3;

    my_dff8 dff1 (.clk(clk), .d(d),  .q(q1));
    my_dff8 dff2 (.clk(clk), .d(q1), .q(q2));
    my_dff8 dff3 (.clk(clk), .d(q2), .q(q3));

    assign out = (sel == 2'b00) ? d  :
                 (sel == 2'b01) ? q1 :
                 (sel == 2'b10) ? q2 :
                                  q3 ;

endmodule