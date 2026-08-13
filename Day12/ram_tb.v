`timescale 1ns/1ps
module tb_register_file;

    parameter D_WIDTH = 32; 
    parameter A_WIDTH = 6;

    reg t_clock;
    reg t_reset_b;
    reg t_wr_en;
    reg [D_WIDTH-1:0] t_wr_data;
    reg [A_WIDTH-1:0] t_rd_addr_1;
    reg [A_WIDTH-1:0] t_rd_addr_2;
    reg [A_WIDTH-1:0] t_wr_addr;
    
    wire [D_WIDTH-1:0] t_rd_data_1;
    wire [D_WIDTH-1:0] t_rd_data_2;

    register_file #(.D_WIDTH(D_WIDTH), .A_WIDTH(A_WIDTH)) dut (
        .clock(t_clock),
        .reset_b(t_reset_b),
        .wr_en(t_wr_en),
        .wr_data(t_wr_data),
        .rd_addr_1(t_rd_addr_1),
        .rd_addr_2(t_rd_addr_2),
        .wr_addr(t_wr_addr),
        .rd_data_1(t_rd_data_1),
        .rd_data_2(t_rd_data_2)
    );

    always #5 t_clock = ~t_clock;

    initial begin
        t_clock = 0; 
        t_reset_b = 0;
        t_wr_en = 0;
        #10;
        
        t_reset_b = 1;
        t_wr_en = 1; 
        t_wr_addr = 6'd0; 
        t_wr_data = 32'd31;
        #20;
        
        t_wr_addr = 6'd2; 
        t_wr_data = 32'd120;
        #10;
        
        t_wr_en = 0; 
        #10;
        
        t_rd_addr_1 = 6'd0; 
        t_rd_addr_2 = 6'd2; 
        
        if (t_rd_data_1 == 31) begin
            $display("Test0 Passed");
        end else begin
            $display("test0 failed");
        end

        if (t_rd_data_2 == 120) begin
            $display("Test1 Passed");
        end else begin
            $display("test1 failed");
        end
        
        #10;
        
        t_wr_en = 1; 
        t_wr_addr = 64; 
        t_wr_data = 60;
        #20;
        
        t_rd_addr_1 = 64; 
        t_wr_en = 0;
        
        if (t_rd_data_1 === 60) begin
            $display("Test0 Failed");
        end else begin
            $display("test0 Passed");
        end
        
        #100;
        $stop;
    end

endmodule