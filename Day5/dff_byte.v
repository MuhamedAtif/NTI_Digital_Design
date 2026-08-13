module dff_byte_en (
    input clock,
    input rst_n,
    input [1:0] byte_en,
    input [15:0] data_bus,
    output reg [15:0] q_state
);

    always @(posedge clock) begin
        if (!rst_n)
            q_state <= 16'b0;
        else begin
            if (byte_en[1])
                q_state[15:8] <= data_bus[15:8];

            if (byte_en[0])
                q_state[7:0] <= data_bus[7:0];
        end
    end

endmodule