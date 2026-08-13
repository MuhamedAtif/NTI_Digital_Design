module tb_cpu_ctrl;

    localparam integer CMD_HLT = 0, CMD_SKZ = 1, CMD_ADD = 2, CMD_AND = 3, CMD_XOR = 4, CMD_LDA = 5, CMD_STO = 6, CMD_JMP = 7;

    reg  [2:0] op_code;
    reg  [2:0] exec_step;
    reg        z_flag;
    
    wire       mux_sel;
    wire       read_en;
    wire       load_inst;
    wire       pc_inc;
    wire       halt_sig;
    wire       load_prog_cnt;
    wire       data_enable;
    wire       load_accum;
    wire       write_en;

    cpu_ctrl_unit dut (
        .op_code       (op_code),
        .exec_step     (exec_step),
        .z_flag        (z_flag),
        .mux_sel       (mux_sel),
        .read_en       (read_en),
        .load_inst     (load_inst),
        .pc_inc        (pc_inc),
        .halt_sig      (halt_sig),
        .load_prog_cnt (load_prog_cnt),
        .data_enable   (data_enable),
        .load_accum    (load_accum),
        .write_en      (write_en) 
    );

    task check_res;
        input [8:0] exp_res;
        if ({mux_sel, read_en, load_inst, pc_inc, halt_sig, load_prog_cnt, data_enable, load_accum, write_en} !== exp_res) begin
            $display("\nTEST FAILED");
            $display("time\top_code exec_step z_flag mux_sel read_en load_inst pc_inc halt_sig load_prog_cnt data_enable load_accum write_en");
            $display("====\t======= ========= ====== ======= ======= ========= ====== ======== ============= =========== ========== ========");
            $display("%0d\t%d       %d         %b      %b       %b         %b      %b        %b             %b           %b          %b",
                     $time, op_code, exec_step, z_flag, mux_sel, read_en, load_inst, pc_inc, halt_sig, load_prog_cnt, data_enable, load_accum, write_en);
            $display("WANT\t                               %b       %b         %b      %b        %b             %b           %b          %b",
                     exp_res[8], exp_res[7], exp_res[6], exp_res[5], exp_res[4], exp_res[3], exp_res[2], exp_res[1], exp_res[0]);
            $stop;
        end
    endtask

    initial begin
        z_flag = 0;

        $write("Testing CMD_HLT exec_step"); op_code = CMD_HLT;
        $write(" 0"); exec_step = 0; #1 check_res(9'b100000000); 
        $write(" 1"); exec_step = 1; #1 check_res(9'b110000000); 
        $write(" 2"); exec_step = 2; #1 check_res(9'b111000000); 
        $write(" 3"); exec_step = 3; #1 check_res(9'b111000000); 
        $write(" 4"); exec_step = 4; #1 check_res(9'b000110000); 
        $write(" 5"); exec_step = 5; #1 check_res(9'b000000000); 
        $write(" 6"); exec_step = 6; #1 check_res(9'b000000000); 
        $write(" 7"); exec_step = 7; #1 check_res(9'b000000000); 
        $write("\n");

        $write("Testing CMD_SKZ exec_step"); op_code = CMD_SKZ;
        $write(" 0"); exec_step = 0; #1 check_res(9'b100000000); 
        $write(" 1"); exec_step = 1; #1 check_res(9'b110000000); 
        $write(" 2"); exec_step = 2; #1 check_res(9'b111000000); 
        $write(" 3"); exec_step = 3; #1 check_res(9'b111000000); 
        $write(" 4"); exec_step = 4; #1 check_res(9'b000100000); 
        $write(" 5"); exec_step = 5; #1 check_res(9'b000000000); 
        $write(" 6"); exec_step = 6; #1 check_res(9'b000000000); 
                      z_flag = 1;    #1 check_res(9'b000100000); 
        $write(" 7"); exec_step = 7; #1 check_res(9'b000000000); 
        $write("\n");

        $write("Testing CMD_ADD exec_step"); op_code = CMD_ADD;
        $write(" 0"); exec_step = 0; #1 check_res(9'b100000000); 
        $write(" 1"); exec_step = 1; #1 check_res(9'b110000000); 
        $write(" 2"); exec_step = 2; #1 check_res(9'b111000000); 
        $write(" 3"); exec_step = 3; #1 check_res(9'b111000000); 
        $write(" 4"); exec_step = 4; #1 check_res(9'b000100000); 
        $write(" 5"); exec_step = 5; #1 check_res(9'b010000000); 
        $write(" 6"); exec_step = 6; #1 check_res(9'b010000000); 
        $write(" 7"); exec_step = 7; #1 check_res(9'b010000010); 
        $write("\n");

        $write("Testing CMD_AND exec_step"); op_code = CMD_AND;
        $write(" 0"); exec_step = 0; #1 check_res(9'b100000000); 
        $write(" 1"); exec_step = 1; #1 check_res(9'b110000000); 
        $write(" 2"); exec_step = 2; #1 check_res(9'b111000000); 
        $write(" 3"); exec_step = 3; #1 check_res(9'b111000000); 
        $write(" 4"); exec_step = 4; #1 check_res(9'b000100000); 
        $write(" 5"); exec_step = 5; #1 check_res(9'b010000000); 
        $write(" 6"); exec_step = 6; #1 check_res(9'b010000000); 
        $write(" 7"); exec_step = 7; #1 check_res(9'b010000010); 
        $write("\n");

        $write("Testing CMD_XOR exec_step"); op_code = CMD_XOR;
        $write(" 0"); exec_step = 0; #1 check_res(9'b100000000); 
        $write(" 1"); exec_step = 1; #1 check_res(9'b110000000); 
        $write(" 2"); exec_step = 2; #1 check_res(9'b111000000); 
        $write(" 3"); exec_step = 3; #1 check_res(9'b111000000); 
        $write(" 4"); exec_step = 4; #1 check_res(9'b000100000); 
        $write(" 5"); exec_step = 5; #1 check_res(9'b010000000); 
        $write(" 6"); exec_step = 6; #1 check_res(9'b010000000); 
        $write(" 7"); exec_step = 7; #1 check_res(9'b010000010); 
        $write("\n");

        $write("Testing CMD_LDA exec_step"); op_code = CMD_LDA;
        $write(" 0"); exec_step = 0; #1 check_res(9'b100000000); 
        $write(" 1"); exec_step = 1; #1 check_res(9'b110000000); 
        $write(" 2"); exec_step = 2; #1 check_res(9'b111000000); 
        $write(" 3"); exec_step = 3; #1 check_res(9'b111000000); 
        $write(" 4"); exec_step = 4; #1 check_res(9'b000100000); 
        $write(" 5"); exec_step = 5; #1 check_res(9'b010000000); 
        $write(" 6"); exec_step = 6; #1 check_res(9'b010000000); 
        $write(" 7"); exec_step = 7; #1 check_res(9'b010000010); 
        $write("\n");

        $write("Testing CMD_STO exec_step"); op_code = CMD_STO;
        $write(" 0"); exec_step = 0; #1 check_res(9'b100000000); 
        $write(" 1"); exec_step = 1; #1 check_res(9'b110000000); 
        $write(" 2"); exec_step = 2; #1 check_res(9'b111000000); 
        $write(" 3"); exec_step = 3; #1 check_res(9'b111000000); 
        $write(" 4"); exec_step = 4; #1 check_res(9'b000100000); 
        $write(" 5"); exec_step = 5; #1 check_res(9'b000000000); 
        $write(" 6"); exec_step = 6; #1 check_res(9'b000000100); 
        $write(" 7"); exec_step = 7; #1 check_res(9'b000000101); 
        $write("\n");

        $write("Testing CMD_JMP exec_step"); op_code = CMD_JMP;
        $write(" 0"); exec_step = 0; #1 check_res(9'b100000000); 
        $write(" 1"); exec_step = 1; #1 check_res(9'b110000000); 
        $write(" 2"); exec_step = 2; #1 check_res(9'b111000000); 
        $write(" 3"); exec_step = 3; #1 check_res(9'b111000000); 
        $write(" 4"); exec_step = 4; #1 check_res(9'b000100000); 
        $write(" 5"); exec_step = 5; #1 check_res(9'b000000000); 
        $write(" 6"); exec_step = 6; #1 check_res(9'b000001000); 
        $write(" 7"); exec_step = 7; #1 check_res(9'b000001000); 

        $display("\nTEST PASSED");
        $stop;
    end

endmodule