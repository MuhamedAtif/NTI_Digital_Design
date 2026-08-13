module serial_parity_gen (
    input clock,
    input reset_b,
    input rx_data,
    output reg par_flag
);

    reg [3:0] cnt_reg, cnt_next;
    reg [7:0] data_reg, data_next;
    reg par_next;

    always @(posedge clock or negedge reset_b) begin
        if (!reset_b) begin
            cnt_reg <= 0;
            data_reg <= 8'b0;
            par_flag <= 0;
        end
        else begin
            cnt_reg <= cnt_next;
            data_reg <= data_next;
            par_flag <= par_next;
        end
    end

    always @(*) begin
        cnt_next = cnt_reg;
        data_next = data_reg;
        par_next = par_flag;

        if (cnt_reg < 9) begin
            if (cnt_reg == 0) begin
                par_next = 0;
            end
            
            cnt_next = cnt_reg + 1;
            data_next = {rx_data, data_reg[7:1]};
            
            if (cnt_reg == 8) begin
                par_next = eval_parity(data_reg);
                cnt_next = 0;
            end
        end
    end  

    function eval_parity;
        input [7:0] bits_vec; 
        integer idx;  
        reg temp_par; 
        begin
            temp_par = 0;
            for (idx = 0; idx < 8; idx = idx + 1) begin
                temp_par = temp_par ^ bits_vec[idx];
            end
            eval_parity = temp_par; 
        end
    endfunction

endmodule