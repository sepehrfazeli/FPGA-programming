module p_7_6
  #( parameter N = 10)
  (
    input logic clk , rst ,
    input logic d ,
    output logic [N -1:0] q
  );

  // state register
  always_ff @ ( posedge !clk , posedge rst )
    if ( rst )
      q <= '0;
    else
      q <= { q [N-2:0], d} ;
      
  
endmodule