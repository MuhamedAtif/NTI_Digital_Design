module adder (
    input wire a,
    input wire b,
    output wire res,
    output wire c_flag
);
    assign {c_flag, res} = a + b;
endmodule