module P_5_2_2_1
(
	input logic clk , rst ,
	input logic d ,
	output logic q,
	output logic d_alert
) ;
assign d_alert = d;
logic [25:0] cntr;

 always @ (posedge(clk))begin
    cntr = cntr + 1;
 end

always @( posedge cntr[25] , posedge rst ) begin

	if ( rst )
		q <= '0;
	else
		q <= d ;
end
	
endmodule