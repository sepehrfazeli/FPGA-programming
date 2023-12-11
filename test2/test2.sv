module test2
(
	input logic clk , rst ,
	input logic in ,
	output logic out
) ;
	typedef enum { s1 , s2 , s3 } state_t ;
	state_t state_reg , state_next ;
	
	always_ff @ ( posedge clk , posedge rst )
		if ( rst )
			state_reg <= s1 ;
		else
			state_reg <= state_next ;
	
	always_comb begin
		state_next = state_reg ; // default state : the same
		out = 1'b0 ; // default output : 0
		unique case ( state_reg )
			s1 :
				if ( in )
					state_next = s2 ;
			s2 : 
			begin
				out = 1'b1 ;
//				out1 = 1'b1 ;
				if ( in )
					state_next = s3 ;
				else
					state_next = s1 ;
			end
			s3 :
				if ( ~in )
					state_next = s1 ;
		endcase
	end
endmodule