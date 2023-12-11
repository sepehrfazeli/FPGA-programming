`timescale 1ns/1ps
module p5_2 (
    input [3:0] sw,     // Slide switches for segment control
    output [6:0] D0_SEG  // Seven-segment display segments for HEX0
);

// Define seven-segment segment patterns
reg [6:0] segment_patterns [16:0];
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
	 segment_patterns[10] = 7'b0001000; // 'A'
    segment_patterns[11] = 7'b0000011; // 'B'
    segment_patterns[12] = 7'b1000110; // 'C'
    segment_patterns[13] = 7'b0100001; // 'D'
    segment_patterns[14] = 7'b0000110; // 'E'
    segment_patterns[15] = 7'b0001110; // 'F'
    segment_patterns[16] = 7'b1111111; // Blank display
end

always @(*) begin
    // Determine which segments to illuminate based on slide switches
    case(sw)
        4'd0: status = segment_patterns[0]; // '0'
        4'd1: status = segment_patterns[1]; // '1'
        4'd2: status = segment_patterns[2]; // '2'
        4'd3: status = segment_patterns[3]; // '3'
        4'd4: status = segment_patterns[4]; // '4'
        4'd5: status = segment_patterns[5]; // '5'
        4'd6: status = segment_patterns[6]; // '6'
        4'd7: status = segment_patterns[7]; // '7'
        4'd8: status = segment_patterns[8]; // '8'
        4'd9: status = segment_patterns[9]; // '9'
        4'ha: status = segment_patterns[10]; // 'A'
        4'hb: status = segment_patterns[11]; // 'B'
        4'hc: status = segment_patterns[12]; // 'C'
        4'hd: status = segment_patterns[13]; // 'D'
        4'he: status = segment_patterns[14]; // 'E'
        4'hf: status = segment_patterns[15]; // 'F'
        default: status = segment_patterns[16]; // Blank display if none selected
    endcase

end
    assign D0_SEG = status;

endmodule
