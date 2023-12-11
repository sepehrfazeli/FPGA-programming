`timescale 1ns/1ps
module seven_segment(
    input [9:0] sw,     // Slide switches for segment control
    input [3:0] btn,    // Pushbuttons for digit control
    output reg [6:0] D0_SEG,  // Seven-segment display segments for HEX0
    output reg [6:0] D1_SEG,  // Seven-segment display segments for HEX1
    output reg [6:0] D2_SEG,  // Seven-segment display segments for HEX2
    output reg [6:0] D3_SEG,  // Seven-segment display segments for HEX3
    output reg [6:0] D4_SEG,  // Seven-segment display segments for HEX4
    output reg [6:0] D5_SEG   // Seven-segment display segments for HEX5
);

// Define seven-segment segment patterns
reg [6:0] segment_patterns [10:0];
reg [6:0] status;

initial begin
    segment_patterns[0] = 7'b1000000; // '0'
    segment_patterns[1] = 7'b1111001; // '1'
    segment_patterns[2] = 7'b0100100; // '2'
    segment_patterns[3] = 7'b0110000; // '3'
    segment_patterns[4] = 7'b0011001; // '4'
    segment_patterns[5] = 7'b0010010; // '5'
    segment_patterns[6] = 7'b0000010; // '6'
    segment_patterns[7] = 7'b1111000; // '7'
    segment_patterns[8] = 7'b0000000; // '8'
    segment_patterns[9] = 7'b0011000; // '9'
    segment_patterns[10] = 7'b1111111; // Blank display
end

always @(*) begin
    // Determine which segments to illuminate based on slide switches
    case(sw)
        10'b0000000001: status = segment_patterns[0]; // '0'
        10'b0000000010: status = segment_patterns[1]; // '1'
        10'b0000000100: status = segment_patterns[2]; // '2'
        10'b0000001000: status = segment_patterns[3]; // '3'
        10'b0000010000: status = segment_patterns[4]; // '4'
        10'b0000100000: status = segment_patterns[5]; // '5'
        10'b0001000000: status = segment_patterns[6]; // '6'
        10'b0010000000: status = segment_patterns[7]; // '7'
        10'b0100000000: status = segment_patterns[8]; // '8'
        10'b1000000000: status = segment_patterns[9]; // '9'
        default: status = 7'b1111111; // Blank display if none selected
    endcase
	 
    D4_SEG = segment_patterns[10];
    D5_SEG = segment_patterns[10];

    // Control display anodes using pushbuttons
    if (btn[0] == 1'b1) begin
        D0_SEG = segment_patterns[10]; // HEX1 off
    end else begin
        D0_SEG = status; // HEX1 follows the pattern of HEX0
    end

    if (btn[1] == 1'b1) begin
        D1_SEG = segment_patterns[10]; // HEX2 off
    end else begin
        D1_SEG = status; // HEX2 follows the pattern of HEX0
    end

    if (btn[2] == 1'b1) begin
        D2_SEG = segment_patterns[10]; // HEX3 off
    end else begin
        D2_SEG = status; // HEX3 follows the pattern of HEX0
    end

    if (btn[3] == 1'b1) begin
        D3_SEG = segment_patterns[10]; // HEX4 off
    end else begin
        D3_SEG = status; // HEX4 follows the pattern of HEX0
    end
end

endmodule
