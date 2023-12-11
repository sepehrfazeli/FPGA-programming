module d_ff
(
	input logic clk ,
	input logic d ,
	output logic q,
	output logic d_alert
) ;
logic [25:0] cntr;

//always_comb @ ( posedge cntr[25] ) X
//always @ ( posedge cntr[25] ) 
always_comb
//	assign d_alert = d;
	d_alert = d;

always @ (posedge(clk))begin
	cntr = cntr + 1;
end
 
always_ff @ ( posedge cntr[25] )
	q <= d ;
	
endmodule