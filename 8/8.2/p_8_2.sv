`timescale 1ns / 1ps
module p_8_2 (
    input logic clk,
    input logic rst,
    output logic led,
	 output logic [3:0] cntr
    );

logic [27:0] din;
logic [27:0] clkdiv;

always_ff @(posedge(clkdiv[27])) begin
	cntr <= cntr + 1;
end

dff dff_inst0 (
    .clk(clk),
    .D(din[0]),
    .Q(clkdiv[0])
);

genvar i;
generate
for (i = 1; i < 28; i=i+1)

	begin : dff_gen_label
		dff dff_inst (
		.clk(clkdiv[i-1]),
		.D(din[i]),
		.Q(clkdiv[i])
		);
	end
	 
endgenerate

assign din = ~clkdiv;

assign led = clkdiv[27];

endmodule