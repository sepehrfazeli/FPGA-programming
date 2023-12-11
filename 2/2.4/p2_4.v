`timescale 1ns/1ps
module p2_4 (
	input [3:0] sw, // Input switches representing CT (sw[0]), CL (sw[1]), OT (sw[2]), and OL (sw[3])
	output [1:0] led // Blue LED led[0], Red LED led[1]
);
	

	assign led[0] = (sw[1] & ~sw[0] & ~sw[2] & ~sw[3]) | (sw[3] & ~sw[0] & ~sw[2] & ~sw[1]) | (sw[2] & ~sw[3] & ~sw[0] & ~sw[1]) | (sw[0] & sw[3] & ~sw[2] & ~sw[1]);
	assign led[1] = (sw[0] & sw[1]) | (sw[2] & sw[3]) | (sw[0] & sw[2]) | (sw[0] & sw[1] & sw[3] & ~sw[2]);

endmodule
