module b_6_4
(
	input logic clk ,
	input logic [3:0] btn,
	output logic [3:0] led
) ;
	typedef enum { S0, S1 , S2 , S3 } state_t ;
	state_t pState , nState ;

		

	// Combinational Logic: Next State Logic
	always_comb
	begin
	    unique case (pState)
		 S0:
			  if (~btn[0])
				  nState = S1;
			  else
				  nState = S0; // Add this line
		 S1:
			  if (~btn[1])
				  nState = S2;
			  else
				  nState = S1; // Add this line
		 S2:
			  if (~btn[2])
				  nState = S3;
			  else
				  nState = S2; // Add this line
		 S3:
			  if (~btn[3])
				  nState = S0;
			  else
				  nState = S3; // Add this line
		 default:
			  nState = S0;
	    endcase
	end

	// State Registers
	always_ff
	begin
		 if (~btn[3])
			  pState <= S0;
		 else
			  pState <= nState;
	end

//	 Output Logic
	
	
	assign led[0] = (pState == S0) ? 1'b1 : 1'b0;
	assign led[1] = (pState == S1) ? 1'b1 : 1'b0;
	assign led[2] = (pState == S2) ? 1'b1 : 1'b0;
	assign led[3] = (pState == S3) ? 1'b1 : 1'b0;
	

	
	
	
endmodule
