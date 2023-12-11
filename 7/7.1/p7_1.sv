`timescale 1ns / 1ps
module p7_1 (
    input logic S,
    input logic R,
    output logic Q,
    output logic Qn
    );

//wire Q_int, Qn_int;
//logic Q_int, Qn_int;

//assign #1 Q_int = ~(S & Qn_int);
assign #1 Q = !(S && Qn);

//assign #1 Qn_int = ~(R & Q_int);
assign #1 Qn = !(R && Q);

//assign Q = Q_int;

//assign Qn = Qn_int;


endmodule