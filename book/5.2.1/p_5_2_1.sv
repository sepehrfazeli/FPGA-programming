module p_5_2_1
(
input logic clk ,
input logic d ,
output logic q,
output logic d_alert
) ;
always_ff @ ( posedge clk )
	q = d ;

endmodule
