module register_8bit(
    input logic [7:0] data_in,
    input logic load,
    output logic [7:0] data_out
);
    always_ff
        if (~load) data_out <= data_in;
endmodule

module multiplier(
    input logic [3:0] op1, op2,
    output logic [7:0] result
);
    always_ff
        result <= op1 * op2;
endmodule

module comparator_8bit(
    input logic [7:0] op1, op2,
    output logic LT, EQ, GT
);
    always_comb begin
        if (op1 > op2) begin
            LT = 1; EQ = 0; GT = 0;
        end else if (op1 == op2) begin
            LT = 0; EQ = 1; GT = 0;
        end else begin
            LT = 0; EQ = 0; GT = 1;
        end
    end
endmodule


module p_9_4 (
	input  logic  [3:0] op1, op2,
	input logic load,
	output logic [6:0] D0_SEG,D1_SEG,D2_SEG,
	output logic LT, EQ, GT
);
	logic [7:0] result;
	logic [7:0] register_output;
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
	

	
	
	multiplier mult (
		.op1(op1),
		.op2(op2),
		.result(result)
	);

	
	register_8bit register (
		.data_in(result),
		.load(load),
		.data_out(register_output)
	);

	
	comparator_8bit comp (
		.op1(register_output),
		.op2(result),
		.LT(LT),
		.EQ(EQ),
		.GT(GT)
	);

	
	
	always_comb begin
		third_digit = result / 100;
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
		case(third_digit)
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
	end
endmodule