`timescale 1ps/1ps

module inv_sv_tb;

    logic in;
    logic out;

    inv_sv dut (
        .in(in),
        .out(out)
    );

    initial begin
        in = 0;
        #10;
        in = 1;
        #10;
        in = 0;
        #10;
        $finish;
    end

    initial begin
        $monitor("Time = %0t | in = %b | out = %b", $time, in, out);
    end

endmodule
