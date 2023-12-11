module p_9_2 (
	input  logic  [3:0] op1, op2,
	input  logic  sub,
	output logic [6:0] D0_SEG,D1_SEG
);
	logic [4:0] result;
	logic [3:0] first_digit, second_digit;
	logic [6:0] segment_patterns [10:0];

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
	always_comb begin
		if (sub) begin
			 result <= op1 + op2;
		end else begin
			 result <= op1 + (~op2 + 1);
		end
	end
	
	always_comb begin
		second_digit = result / 10;
		first_digit = result % 10;
		
		case(first_digit)
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
		case(second_digit)
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
	end
endmodule