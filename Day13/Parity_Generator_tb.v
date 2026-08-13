`timescale 1ns/1ps
module tb_serial_parity;

    reg t_clock;
    reg t_reset_b;
    reg t_rx_data;
    wire t_par_flag;

    serial_parity_gen dut (
        .clock(t_clock),
        .reset_b(t_reset_b),
        .rx_data(t_rx_data),
        .par_flag(t_par_flag)
    );

    always #5 t_clock = ~t_clock;

    task inject_frame;
        input [7:0] frame_data;
        integer idx;
        begin
            for (idx = 0; idx < 8; idx = idx + 1) begin
                @(negedge t_clock) t_rx_data = frame_data[idx];
                #10;
            end
        end
    endtask

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
        
        t_clock = 0; 
        t_reset_b = 0;
        #10;
        
        t_reset_b = 1;
        
        inject_frame(8'b00010010);
        
        if (t_par_flag == 0) begin
            $display("Test1 Passed");
        end else begin
            $display("Test1 Failed");
        end
        
        #10;
        
        inject_frame(8'b01010100);
        
        if (t_par_flag == 1) begin
            $display("Test2 Passed");
        end else begin
            $display("Test2 Failed");
        end
        
        #100;
        $stop;
    end

endmodule