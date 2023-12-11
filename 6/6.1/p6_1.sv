`timescale 1ns / 1ps
module p6_1 (
   input  logic A,
   input  logic B,
   input  logic C,
   output logic  X
   );

//wire N1, N2, N3;
logic n_B , X1 , X2 ;

// AND gate with 1ns delay
and #1 g1 ( X1, A, B ) ;
//assign #1 N1 = A & B;

// Not Gate with 1ns delay
not #1 g2 ( n_B , B ) ;
//assign #1 N2 = ~B;

// And Gate with 1ns delay
and #1 g3 ( X2, n_B, C ) ;
//assign #1 N3 = N2 & C;

// Or Gate with 1ns delay
or #1 g4 ( X, X1, X2 ) ;
//assign #1 X = N1 | N3;


endmodule