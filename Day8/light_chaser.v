module chaser (
    input wire clock,
    input wire rst_n,
    input wire freeze_sig,
    output reg [3:0] led_seq
);
       
    wire slow_clk;
    
    clk_divider div_inst (
        .clkin(clock),
        .reset(rst_n),
        .clkout(slow_clk)
    );
      
    always @(posedge slow_clk, negedge rst_n) begin
        if (!rst_n)
            led_seq <= 4'b1011;
        else if (!freeze_sig)
            led_seq <= led_seq;
        else 
            led_seq <= (led_seq >> 1) | (led_seq << 3);
    end	

endmodule