module cpu_ctrl_unit (
    input wire z_flag,
    input wire [2:0] op_code,
    input wire [2:0] exec_step,
    output reg mux_sel,
    output reg read_en,
    output reg load_inst,
    output reg halt_sig,
    output reg pc_inc,
    output reg load_accum,
    output reg write_en,
    output reg load_prog_cnt,
    output reg data_enable 
);

    localparam CMD_HLT = 3'b000;
    localparam CMD_SKZ = 3'b001;
    localparam CMD_ADD = 3'b010;
    localparam CMD_AND = 3'b011;
    localparam CMD_XOR = 3'b100;
    localparam CMD_LDA = 3'b101;
    localparam CMD_STO = 3'b110;
    localparam CMD_JMP = 3'b111;

    localparam ST_IADDR  = 3'b000;
    localparam ST_IFETCH = 3'b001;
    localparam ST_ILOAD  = 3'b010;
    localparam ST_IDLE   = 3'b011;
    localparam ST_OADDR  = 3'b100;
    localparam ST_OFETCH = 3'b101;
    localparam ST_ALU    = 3'b110;
    localparam ST_STORE  = 3'b111;

    always @(*) begin
        mux_sel = 0;
        read_en = 0;
        load_inst = 0;
        halt_sig = 0;
        pc_inc = 0;
        load_accum = 0;
        write_en = 0;
        load_prog_cnt = 0;
        data_enable = 0;
        
        case (exec_step)
            ST_IADDR: begin 
                mux_sel = 1; 
            end
            
            ST_IFETCH: begin 
                mux_sel = 1; 
                read_en = 1; 
            end
            
            ST_ILOAD: begin 
                mux_sel = 1; 
                read_en = 1; 
                load_inst = 1; 
            end
            
            ST_IDLE: begin 
                mux_sel = 1; 
                read_en = 1; 
                load_inst = 1; 
            end
            
            ST_OADDR: begin 
                pc_inc = 1; 
                halt_sig = (op_code == CMD_HLT); 
            end
            
            ST_OFETCH: begin 
                read_en = (op_code == CMD_ADD || op_code == CMD_AND || op_code == CMD_XOR || op_code == CMD_LDA); 
            end
            
            ST_ALU: begin 
                read_en = (op_code == CMD_ADD || op_code == CMD_AND || op_code == CMD_XOR || op_code == CMD_LDA);  
                pc_inc = (op_code == CMD_SKZ) && z_flag;  
                load_prog_cnt = (op_code == CMD_JMP);    
                data_enable = (op_code == CMD_STO); 
            end
            
            ST_STORE: begin 
                read_en = (op_code == CMD_ADD || op_code == CMD_AND || op_code == CMD_XOR || op_code == CMD_LDA);  
                write_en = (op_code == CMD_STO);
                load_accum = (op_code == CMD_ADD || op_code == CMD_AND || op_code == CMD_XOR || op_code == CMD_LDA);
                load_prog_cnt = (op_code == CMD_JMP);    
                data_enable = (op_code == CMD_STO); 
            end
        endcase
    end

endmodule