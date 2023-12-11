`timescale 1ns/1ps
module p2_2(
    input [7:0] sw,
    output [2:0] led
);

assign led[0] = (~sw[1] | ~sw[0]) & (sw[0] | sw[1]);
assign led[1] = (~sw[3] | ~sw[2]) & (~sw[2] | sw[1]) & (~sw[3] | sw[1]) & (~sw[1] | sw[2] | sw[3]);
assign led[2] = (~sw[5] | sw[4]) & (~sw[4] | sw[7] | ~sw[6]) & (~sw[7] | sw[5]) & (sw[4] | sw[7] | sw[6]) & (~sw[7] | sw[6]);

endmodule