// Custom 4-bit DAC - ideal behavioral RTL model
// Note: analog_out is a 12-bit DIGITAL CODE representing the ideal
// analog level. This RTL does not physically implement an R-2R resistor ladder.

module custom_dac_4bit #(
    parameter integer VREF_CODE = 4095
) (
    input  wire [3:0]  digital_in,
    output reg  [11:0] analog_out
);

    // Maximum product = 15 * 4095 = 61425, which needs 16 bits.
    reg [15:0] scaled_product;

    always @(*) begin
        scaled_product = digital_in * VREF_CODE;
        // Transfer equation: VOUT / VREF = D / 16
        // 12-bit output code = floor(D * 4095 / 16)
        analog_out = scaled_product / 16;
    end

endmodule
