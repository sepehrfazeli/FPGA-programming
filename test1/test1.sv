`timescale 1ns/1ps
module test1 (
    input logic [4:0] sw,
    output logic led
);

always_ff @(posedge sw) begin
    if (sw !== led)  // XOR the switch values with the led state
        led <= !led;  // Toggle the led state
end

endmodule