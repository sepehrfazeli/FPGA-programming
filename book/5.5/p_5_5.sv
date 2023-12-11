module p_5_5
	#( parameter N = 6)
	(
		input logic clk , rst , s_in ,
		input logic [1:0] ctrl ,
		input logic [N -1:0] d ,
		output logic [N -1:0] q ,
		output logic s_out
	);
	logic [N -1:0] r_reg , r_next ;
	logic [25:0] cntr;

	 always @ (posedge(clk))begin
		 cntr = cntr + 1;
	 end
	// state register
	always_ff @ ( posedge cntr[23] , posedge rst )
		if ( rst )
			r_reg <= '0;
		else
			r_reg <= r_next ;
			
	// next - state logic
	always_comb
		unique case ( ctrl )
			2'b00 : r_next = r_reg ;
			2'b01 : r_next = { r_reg[0] , r_reg [N-1:1]};
			2'b10 : r_next = d ;
		endcase
		
	// output logic
	assign q = r_reg ;
	assign s_out = r_reg [0];
endmodule