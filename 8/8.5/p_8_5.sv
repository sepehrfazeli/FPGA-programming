`timescale 1ns / 1ps
module p_8_5 (
    input logic clk,
    input logic rst,
    output logic led,
    output logic [6:0] D0_SEG,D1_SEG,D2_SEG,D3_SEG
    );

logic [26:0] din;
logic [26:0] clkdiv;
// Define seven-segment segment patterns
logic [6:0] segment_patterns [10:0];
logic [3:0] D0,D1,D2,D3;

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
	if (rst) D0 <= 0;
	else if (D0 == 4'b1001) D0 <= 0;
	else D0 <= D0 + 1;
end
always_ff @(negedge (D0 == 4'b1001), posedge rst) begin
	if (rst) D1 <= 0;
	else if (D1 == 4'b1001) D1 <= 0;
	else D1 <= D1 + 1;
end
always_ff @(negedge (D1 == 4'b1001) , posedge rst) begin
	if (rst) D2 <= 0;
	else if (D2 == 4'b1001) D2 <= 0;
	else D2 <= D2 + 1;
end
always_ff @(negedge (D2 == 4'b1001) , posedge rst) begin
	if (rst) D3 <= 0;
	else if (D3 == 4'b1001) D3 <= 0;
	else D3 <= D3 + 1;
end

always_comb begin
	case(D0)
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
	case(D1)
        4'b0000: D1_SEG = segment_patterns[0]; // '0'
        4'b0001: D1_SEG = segment_patterns[1]; // '1'
        4'b0010: D1_SEG = segment_patterns[2]; // '2'
        4'b0011: D1_SEG = segment_patterns[3]; // '3'
        4'b0100: D1_SEG = segment_patterns[4]; // '4'
        4'b0101: D1_SEG = segment_patterns[5]; // '5'
        4'b0110: D1_SEG = segment_patterns[6]; // '6'
        4'b0111: D1_SEG = segment_patterns[7]; // '7'
        4'b1000: D1_SEG = segment_patterns[8]; // '8'
        4'b1001: D1_SEG = segment_patterns[9]; // '9'
        default: D1_SEG = 7'b1000000; // Blank display if none selected
	endcase
	case(D2)
        4'b0000: D2_SEG = segment_patterns[0]; // '0'
        4'b0001: D2_SEG = segment_patterns[1]; // '1'
        4'b0010: D2_SEG = segment_patterns[2]; // '2'
        4'b0011: D2_SEG = segment_patterns[3]; // '3'
        4'b0100: D2_SEG = segment_patterns[4]; // '4'
        4'b0101: D2_SEG = segment_patterns[5]; // '5'
        4'b0110: D2_SEG = segment_patterns[6]; // '6'
        4'b0111: D2_SEG = segment_patterns[7]; // '7'
        4'b1000: D2_SEG = segment_patterns[8]; // '8'
        4'b1001: D2_SEG = segment_patterns[9]; // '9'
        default: D2_SEG = 7'b1000000; // Blank display if none selected
	endcase
	case(D3)
        4'b0000: D3_SEG = segment_patterns[0]; // '0'
        4'b0001: D3_SEG = segment_patterns[1]; // '1'
        4'b0010: D3_SEG = segment_patterns[2]; // '2'
        4'b0011: D3_SEG = segment_patterns[3]; // '3'
        4'b0100: D3_SEG = segment_patterns[4]; // '4'
        4'b0101: D3_SEG = segment_patterns[5]; // '5'
        4'b0110: D3_SEG = segment_patterns[6]; // '6'
        4'b0111: D3_SEG = segment_patterns[7]; // '7'
        4'b1000: D3_SEG = segment_patterns[8]; // '8'
        4'b1001: D3_SEG = segment_patterns[9]; // '9'
        default: D3_SEG = 7'b1000000; // Blank display if none selected
	endcase
end

endmodule