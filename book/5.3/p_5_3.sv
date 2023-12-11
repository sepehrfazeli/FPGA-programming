module p_5_3
(
	input logic clk ,
	input logic d ,
	output logic q,
	output logic d_alert
) ;

assign d_alert = d;
logic [25:0] cntr;

 always @ (posedge(clk))begin
    cntr = cntr + 1;
 end
 
always_latch
	if ( cntr[25] )
		q <= d ;
endmodule
