module ram #(
    parameter D_WIDTH = 32, 
    parameter A_WIDTH = 6
)(
    input clock,
    input reset_b,
    input wr_en,
    input [D_WIDTH-1:0] wr_data,
    input [A_WIDTH-1:0] rd_addr_1,
    input [A_WIDTH-1:0] rd_addr_2,
    input [A_WIDTH-1:0] wr_addr,
    output wire [D_WIDTH-1:0] rd_data_1,
    output wire [D_WIDTH-1:0] rd_data_2
);

    localparam MEM_DEPTH = 1 << A_WIDTH;
    
    reg [D_WIDTH-1:0] mem_array [0:MEM_DEPTH-1];
    integer idx;

    always @(posedge clock or negedge reset_b) begin
        if (!reset_b) begin
            for (idx = 0; idx < MEM_DEPTH; idx = idx + 1) begin
                mem_array[idx] <= {D_WIDTH{1'b0}};
            end
        end 
        else if (wr_en) begin
            mem_array[wr_addr] <= wr_data;
        end
    end 

    assign rd_data_1 = mem_array[rd_addr_1];
    assign rd_data_2 = mem_array[rd_addr_2];

endmodule