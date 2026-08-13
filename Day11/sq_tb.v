`default_nettype none

module tb_seq_detectors;

    reg test_clk;
    reg test_rst_b;
    reg test_rx;
    wire test_match;

    moore_nonover_det dut_active (
        .clock(test_clk),
        .reset_b(test_rst_b),
        .rx_bit(test_rx),
        .det_res(test_match)
    );

    // moore_over_det dut_m_over (
    //     .clock(test_clk),
    //     .reset_b(test_rst_b),
    //     .rx_bit(test_rx),
    //     .det_res(test_match)
    // );

    // seq_detector dut_mealy_non (
    //     .clock(test_clk),
    //     .reset_b(test_rst_b),
    //     .rx_bit(test_rx),
    //     .det_res(test_match)
    // );

    // mealy_over_det dut_mealy_over (
    //     .clock(test_clk),
    //     .reset_b(test_rst_b),
    //     .rx_bit(test_rx),
    //     .det_res(test_match)
    // );

    always #5 test_clk = ~test_clk;

    initial begin
        test_clk = 0;
        test_rst_b = 0;
        test_rx = 0;
        #10;
        
        test_rst_b = 1;
        test_rx = 1'b1; #10;
        test_rx = 1'b1; #10;
        test_rx = 1'b0; #10;
        test_rx = 1'b1; #10;
        test_rx = 1'b0; #10;
        test_rx = 1'b1; #10;
        test_rx = 1'b1; #10;
        test_rx = 1'b1; #10;
        test_rx = 1'b1; #10;
        test_rx = 1'b1; #10;
        
        $stop;
    end

endmodule