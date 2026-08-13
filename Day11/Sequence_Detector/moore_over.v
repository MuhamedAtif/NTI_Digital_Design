module moore_over_det (
    input wire rx_bit,
    input wire clock,
    input wire reset_b,
    output reg det_res
);

    reg [2:0] curr_st, next_st;

    always @(posedge clock or negedge reset_b) begin
        if (!reset_b) begin
            curr_st <= 3'b000;
        end
        else begin
            curr_st <= next_st;
        end
    end  

    always @(*) begin
        next_st = 3'b000; 
        
        if (curr_st == 3'b110) begin
            det_res = 1;
        end else begin
            det_res = 0;
        end
        
        case (curr_st)
            3'b000 : begin
                if (rx_bit) begin
                    next_st = 3'b001;
                end
            end
            3'b001 : begin
                if (rx_bit) begin
                    next_st = 3'b010;
                end
            end
            3'b010 : begin
                if (!rx_bit) begin
                    next_st = 3'b011;
                end
            end
            3'b011 : begin
                if (rx_bit) begin
                    next_st = 3'b100;
                end
            end
            3'b100 : begin
                if (!rx_bit) begin
                    next_st = 3'b101;
                end
            end
            3'b101 : begin
                if (rx_bit) begin
                    next_st = 3'b110;
                end
            end
            3'b110 : begin
                if (rx_bit) begin
                    next_st = 3'b010;
                end
            end
            default: next_st = 3'b000;
        endcase
    end

endmodule