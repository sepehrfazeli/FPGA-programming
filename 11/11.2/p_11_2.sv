`timescale 1ns / 1ps
module p_11_2 #(parameter N=16)
(
	input logic [3:0] btn,
	input logic clk,
	output logic [6:0] D0_SEG, D1_SEG, D2_SEG, D3_SEG,
	output logic [3:0] led
);

logic clk1Hz, cen, rst;
logic [N-1:0] Data;
assign rst = ~btn[3];

Clock_Divider clk1 (
	.clk(clk),
	.clk1Hz(clk1Hz)
);

stateLogic stateLogic1 (
	.start(~btn[0]),
	.stop(~btn[1]),
	.inc(~btn[2]),
	.rst(~btn[3]),
	.clk(clk1Hz),
	.cen(cen),
	.led(led)
);

counter #(N) counter1 (
	.clk(clk1Hz),
	.cen(cen),
	.rst(rst),
	.out(Data)
);

seg_controler #(N) seg_control (
	.result(Data),
	.seg0(D0_SEG),
	.seg1(D1_SEG),
	.seg2(D2_SEG),
	.seg3(D3_SEG)
);

endmodule

module counter # (parameter N)
(
	input logic clk,
	input logic cen,
	input logic rst,
	output logic [N-1:0] out
);
always_ff @(posedge clk, posedge rst)
begin
	if (rst)
		out <= 0;
	else if (cen) // Increment D when cen is high
		out <= out + 1;
end

endmodule

module stateLogic(
	input logic start,
	input logic stop,
	input logic inc,
	input logic rst,
	input logic clk,
	output logic cen,
	output logic [3:0] led
);
	typedef enum { S0, S1 , S2 , S3 } state_t ;
	state_t pState , nState ;

	// Combinational Logic: Next State Logic
	always_comb
	begin
		unique case (pState)
			S0:
				if (start)
					nState = S1;
				else if (inc)
					nState = S3;
				else
					nState = S0;
			S1:
				if (stop)
					nState = S2;
				else
					nState = S1;
			S2:
				if (start)
					nState = S1;
				else if (inc)
					nState = S3;
				else
					nState = S2;
			S3:
				nState = S2;
			default:
				nState = S0;
		endcase
	end

	// State Registers
	always_ff @(posedge clk, posedge rst)
	begin
		if (rst)
			pState <= S0;
		else
			pState <= nState;
	end

	// Output Logic
	assign cen = (pState == S1 || pState == S3) ? 1'b1 : 1'b0;
	assign led[0] = (pState == S0) ? 1'b1 : 1'b0;
	assign led[1] = (pState == S1) ? 1'b1 : 1'b0;
	assign led[2] = (pState == S2) ? 1'b1 : 1'b0;
	assign led[3] = (pState == S3) ? 1'b1 : 1'b0;

endmodule

module seg_controler #( parameter N )
(
	input  logic [N-1:0] result,
	output logic [6:0] seg0,seg1,seg2,seg3
);
	logic [3:0] first_digit, second_digit, third_digit, forth_digit;
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
		forth_digit = result / 1000;
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
		case(forth_digit)
		  4'b0000: seg3 = segment_patterns[0]; // '0'
		  4'b0001: seg3 = segment_patterns[1]; // '1'
		  4'b0010: seg3 = segment_patterns[2]; // '2'
		  4'b0011: seg3 = segment_patterns[3]; // '3'
		  4'b0100: seg3 = segment_patterns[4]; // '4'
		  4'b0101: seg3 = segment_patterns[5]; // '5'
		  4'b0110: seg3 = segment_patterns[6]; // '6'
		  4'b0111: seg3 = segment_patterns[7]; // '7'
		  4'b1000: seg3 = segment_patterns[8]; // '8'
		  4'b1001: seg3 = segment_patterns[9]; // '9'
		  default: seg3 = 7'b1000000; // Blank display if none selected
		endcase
	
	end
endmodule

module Clock_Divider(
	input logic clk,
	output logic clk1Hz
);
logic [26:0] din;
logic [26:0] clkdiv;

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
assign clk1Hz = clkdiv[22];

endmodule

