module p_5_3_ex
(
	input logic clk ,
	input logic [1:0] d ,
	output logic [1:0] q
) ;
assign d_alert = d;
logic [25:0] cntr;

always @ (posedge(clk))begin
	cntr = cntr + 1;
end

always @ ( cntr[25] , d[0] , d[1] )
	if ( cntr[25] )
		q[0] <= d[0] & d[1] ;	
	else
		q[0] <= d[0] | d[1] ;
		
endmodule