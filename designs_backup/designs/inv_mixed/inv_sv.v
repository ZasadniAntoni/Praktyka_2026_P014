`timescale 1ns/1ps

module inv_sv (
    input  wire in,
    output wire out
);

    assign out = ~in;

endmodule
