`timescale 1ns/1ps

module tb_custom_dac_4bit;

    reg  [3:0]  digital_in;
    wire [11:0] analog_out;

    integer i;
    integer expected_code;
    real    vout_volts;
    integer errors;

    custom_dac_4bit #(
        .VREF_CODE(4095)
    ) dut (
        .digital_in(digital_in),
        .analog_out(analog_out)
    );

    initial begin
        errors = 0;
        $display("------------------------------------------------");
        $display("4-bit DAC verification (VREF = 5.0 V)");
        $display("Input  Decimal  Output_Code  Ideal_VOUT(V)  Check");
        $display("------------------------------------------------");

        for (i = 0; i < 16; i = i + 1) begin
            digital_in = i;
            #10;

            expected_code = (i * 4095) / 16;
            vout_volts = (i * 5.0) / 16.0;

            if (analog_out !== expected_code[11:0]) begin
                $display("%b     %2d       %4d         %0.4f       FAIL",
                         digital_in, i, analog_out, vout_volts);
                errors = errors + 1;
            end
            else begin
                $display("%b     %2d       %4d         %0.4f       PASS",
                         digital_in, i, analog_out, vout_volts);
            end
        end

        $display("------------------------------------------------");
        if (errors == 0)
            $display("RESULT: PASS - all 16 input codes verified.");
        else
            $display("RESULT: FAIL - %0d error(s) found.", errors);

        $finish;
    end

endmodule
