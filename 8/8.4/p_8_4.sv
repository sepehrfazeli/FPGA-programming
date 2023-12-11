`timescale 1ns / 1ps
module p_8_4 (
    input logic clk,
    input logic rst,
    output logic led,
    output logic [6:0] D0_SEG
    );

logic [26:0] din;
logic [26:0] clkdiv;
// Define seven-segment segment patterns
logic [6:0] segment_patterns [10:0];
logic [3:0] cntr;

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

dff dff_inst0 (
    .clk(clk),
    .D(din[0]),
    .Q(clkdiv[0])
);

genvar i;
generate
for (i = 1; i < 27; i=i+1)

	begin : dff_gen_label
		dff dff_inst (
		.clk(clkdiv[i-1]),
		.D(din[i]),
		.Q(clkdiv[i])
		);
	end
	 
endgenerate

assign din = ~clkdiv;
assign led = clkdiv[26];

always_ff @(posedge clkdiv[26] , posedge rst) begin
	if (rst) cntr <= 0;
	else if (cntr == 4'b1001) cntr <= 0;
	else cntr <= cntr + 1;
end

always_comb begin
	case(cntr)
        4'b0000: D0_SEG = segment_patterns[0]; // '0'
        4'b0001: D0_SEG = segment_patterns[1]; // '1'
        4'b0010: D0_SEG = segment_patterns[2]; // '2'
        4'b0011: D0_SEG = segment_patterns[3]; // '3'
        4'b0100: D0_SEG = segment_patterns[4]; // '4'
        4'b0101: D0_SEG = segment_patterns[5]; // '5'
        4'b0110: D0_SEG = segment_patterns[6]; // '6'
        4'b0111: D0_SEG = segment_patterns[7]; // '7'
        4'b1000: D0_SEG = segment_patterns[8]; // '8'
        4'b1001: D0_SEG = segment_patterns[9]; // '9'
        default: D0_SEG = 7'b1000000; // Blank display if none selected
	endcase
end

endmodule