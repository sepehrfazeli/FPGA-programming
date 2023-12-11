module ALU #( parameter N )
(
    input logic [2:0] ctrl,
    input logic [N-1:0] A, B,
    output logic [2*N-1:0] F
);
    always_comb begin
        case (ctrl)
            3'b000: F = A + B;
            3'b001: F = A + 1;
            3'b010: F = A - B;
            3'b011: F = A ^ B;
            3'b100: F = A | B;
            3'b101: F = A & B;
            default: F = '0;
        endcase
    end
endmodule

module register_N_bit #( parameter N )
(
    input logic [N-1:0] data_in,
    input logic load,
    output logic [N-1:0] data_out
);
    always_ff
        if (~load) data_out <= data_in;
endmodule

module seg_controler #( parameter N )
(
	input  logic [N-1:0] result,
	output logic [6:0] seg0,seg1,seg2
);
	logic [3:0] first_digit, second_digit, third_digit;
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
		third_digit = result / 100;
		second_digit = result / 10;
		first_digit = result % 10;
		
		case(first_digit)
		  4'b0000: seg0 = segment_patterns[0]; // '0'
		  4'b0001: seg0 = segment_patterns[1]; // '1'
		  4'b0010: seg0 = segment_patterns[2]; // '2'
		  4'b0011: seg0 = segment_patterns[3]; // '3'
		  4'b0100: seg0 = segment_patterns[4]; // '4'
		  4'b0101: seg0 = segment_patterns[5]; // '5'
		  4'b0110: seg0 = segment_patterns[6]; // '6'
		  4'b0111: seg0 = segment_patterns[7]; // '7'
		  4'b1000: seg0 = segment_patterns[8]; // '8'
		  4'b1001: seg0 = segment_patterns[9]; // '9'
		  default: seg0 = 7'b1000000; // Blank display if none selected
		endcase
		case(second_digit)
		  4'b0000: seg1 = segment_patterns[0]; // '0'
		  4'b0001: seg1 = segment_patterns[1]; // '1'
		  4'b0010: seg1 = segment_patterns[2]; // '2'
		  4'b0011: seg1 = segment_patterns[3]; // '3'
		  4'b0100: seg1 = segment_patterns[4]; // '4'
		  4'b0101: seg1 = segment_patterns[5]; // '5'
		  4'b0110: seg1 = segment_patterns[6]; // '6'
		  4'b0111: seg1 = segment_patterns[7]; // '7'
		  4'b1000: seg1 = segment_patterns[8]; // '8'
		  4'b1001: seg1 = segment_patterns[9]; // '9'
		  default: seg1 = 7'b1000000; // Blank display if none selected
		endcase
		case(third_digit)
		  4'b0000: seg2 = segment_patterns[0]; // '0'
		  4'b0001: seg2 = segment_patterns[1]; // '1'
		  4'b0010: seg2 = segment_patterns[2]; // '2'
		  4'b0011: seg2 = segment_patterns[3]; // '3'
		  4'b0100: seg2 = segment_patterns[4]; // '4'
		  4'b0101: seg2 = segment_patterns[5]; // '5'
		  4'b0110: seg2 = segment_patterns[6]; // '6'
		  4'b0111: seg2 = segment_patterns[7]; // '7'
		  4'b1000: seg2 = segment_patterns[8]; // '8'
		  4'b1001: seg2 = segment_patterns[9]; // '9'
		  default: seg2 = 7'b1000000; // Blank display if none selected
		endcase
	
	end

endmodule



module p_10_1 #( parameter N = 4)
(
	input logic [2:0] opcode,
	input logic [N-1:0] sw,
	input logic EN1, EN2,
	output logic [6:0] D0_SEG, D1_SEG, D2_SEG
);
	logic [2*N-1:0] F;
	logic [N-1:0] A, B;
	
	
    register_N_bit #(N) register1 (
        .data_in(sw),
        .load(EN1),
        .data_out(A)
    );
	 
    register_N_bit #(N) register2 (
        .data_in(sw),
        .load(EN2),
        .data_out(B)
    );
	 
    ALU #(N) alu (
        .ctrl(opcode),
        .A(A),
        .B(B),
        .F(F)
    );
	 
	 
    seg_controler #(2*N) seg_control (
        .result(F),
        .seg0(D0_SEG),
        .seg1(D1_SEG),
        .seg2(D2_SEG)
    );
	 
endmodule