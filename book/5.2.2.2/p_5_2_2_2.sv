module p_5_2_2_2
(
	input logic clk , rst , en ,
	input logic d ,
	output logic q,
	output logic d_alert
) ;
assign d_alert = d;
logic [25:0] cntr;

 always @ (posedge(clk))begin
    cntr = cntr + 1;
 end
always_ff @ ( posedge cntr[25] ,posedge rst ) begin
	if ( rst )
		q <= '0;
	else if ( en )
		q <= d ;
	end
endmodule
