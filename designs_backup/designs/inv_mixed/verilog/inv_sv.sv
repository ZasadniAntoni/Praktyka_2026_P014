`timescale 1ps/1ps

module inv_sv (
    input  logic in,
    output logic out
);

assign out = ~in;

endmodule
