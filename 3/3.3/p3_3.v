`timescale 1ns/1ps
module p3_3 (
    input [7:0] sw, // 8-bit binary representation
    output led       // Output signal indicating temperature in range
);

// Define temperature range boundaries in binary
wire [7:0] lower_limit = 8'b10100000; // 62.5 degrees
wire [7:0] upper_limit = 8'b10111010; // 72.5 degrees

assign led = (sw > lower_limit) && (sw < upper_limit);

endmodule