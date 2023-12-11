`timescale 1ns / 1ps
module p7_3 (
    input logic D,
    input logic G,
    output logic Q,
    output logic Qn
    );

//wire Q_int, Qn_int;
logic n_D, R1, R2;

//assign #1 Q_int = ~(S & Qn_int);
assign #1 Q = !(R1 && Qn);

//assign #1 Qn_int = ~(R & Q_int);
assign #1 Qn = !(R2 && Q);

//assign Q = Q_int;

//assign Qn = Qn_int;

nand	g1 ( R1, D,  G);
not	g2 ( n_D, D);
nand	g3 ( R2, G, n_D);


endmodule