module d_flip_flop (
    input clock,
    input rst,
    input [7:0] data_bus,
    output reg [7:0] q_state
);

    always @(negedge clock) begin
        if (rst) begin
            q_state <= 8'b00110100;
        end
        else begin
            q_state <= data_bus;
        end
    end 
    
endmodule