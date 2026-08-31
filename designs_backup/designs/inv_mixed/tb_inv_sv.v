`timescale 1ns/1ps

module tb_inv_sv;
    reg in;
    wire out;

    // Instantiate your inverter module
    inv_sv uut (
        .in(in),
        .out(out)
    );

    integer pipe_in, pipe_out;
    integer status;
    reg [31:0] in_val;

    initial begin
        // Open ngspice communication pipes
        pipe_in  = $fopen("ngspice_in", "r");
        pipe_out = $fopen("ngspice_out", "w");

        forever begin
            // Read digital input state from ngspice
            status = $fscanf(pipe_in, "%b\n", in_val);
            if (status == 1) begin
                in = in_val[0];
                #1; // Delay for output propagation
                // Send digital output back to ngspice
                $fdisplay(pipe_out, "%b", out);
                $fflush(pipe_out);
            end
        end
    end
endmodule
