module bit_slice(
	input  logic a, b, cin, 
	output logic sum, cout
);
    assign {cout, sum} = a + b + cin;
endmodule

module cpgn(
input  logic [3:0] a, b, 
output logic [4:0] c
);
    logic [3:0] g, p;
    assign g = a & b;  // Generate
    assign p = a ^ b;  // Propagate
    assign c[0] = 0;
    assign c[1] = g[0] | (p[0] & c[0]);
    assign c[2] = g[1] | (p[1] & c[1]);
    assign c[3] = g[2] | (p[2] & c[2]);
    assign c[4] = g[3] | (p[3] & c[3]);
endmodule

module p_9_1(
input  logic [3:0] a, b, 
input  logic cin, 
output logic [6:0] D0_SEG,D1_SEG
);

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

	logic [4:0] c; 
	logic [3:0] sum,first_digit, second_digit; 
	logic cout;
	logic [6:0] segment_patterns [10:0];
	
	cpgn cpgn1 (.a(a), .b(b), .c(c));
	bit_slice bs0 (.a(a[0]), .b(b[0]), .cin(c[0]), .sum(sum[0]), .cout());
	bit_slice bs1 (.a(a[1]), .b(b[1]), .cin(c[1]), .sum(sum[1]), .cout());
	bit_slice bs2 (.a(a[2]), .b(b[2]), .cin(c[2]), .sum(sum[2]), .cout());
	bit_slice bs3 (.a(a[3]), .b(b[3]), .cin(c[3]), .sum(sum[3]), .cout(cout));
	
	always_comb begin
		second_digit = {cout,sum} / 10;
		first_digit = {cout,sum} % 10;
		
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