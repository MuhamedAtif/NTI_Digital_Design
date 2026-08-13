`timescale 1ns/1ps

module tb_chaser;

    reg t_clock;
    reg t_rst; 
    reg t_freeze;  
    wire [3:0] t_seq_res;

    light_chaser dut (
        .clk(t_clock),
        .reset(t_rst),
        .hold(t_freeze),
        .sout(t_seq_res)
    );

    always #10 t_clock = ~t_clock;
         
    initial begin
        t_rst = 0; 
        t_clock = 0;
        #50;
        t_freeze = 0;
        #10;
        t_freeze = 1; 
        #10;
        t_rst = 0; 
        #10;
        t_rst = 1;
        #100;
        $stop;
    end
    
endmodule