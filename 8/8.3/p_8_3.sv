`timescale 1ns / 1ps
module p_8_3 (
    input logic clk,
    input logic rst,
    output logic [1:0] led
    );

logic [15:0] din1;
logic [15:0] clkdiv1;

dff dff_inst1 (
    .clk(clk),
    .D(din1[0]),
    .Q(clkdiv1[0])
);

generate
genvar i;
for (i = 1; i < 16; i=i+1)

	begin : dff_gen_1
		dff dff_inst (
		.clk(clkdiv1[i-1]),
		.D(din1[i]),
		.Q(clkdiv1[i])
		);
	end
	 
endgenerate

assign din1 = ~clkdiv1;
assign led[0] = clkdiv1[15];

logic [9:0] din2;
logic [9:0] clkdiv2;

dff dff_inst2 (
    .clk(clkdiv1[15]),
    .D(din2[0]),
    .Q(clkdiv2[0])
);

generate
genvar j;
for (j = 1; j < 10; j=j+1)

	begin : dff_gen_2
		dff dff_inst (
		.clk(clkdiv2[j-1]),
		.D(din2[j]),
		.Q(clkdiv2[j])
		);
	end
	 
endgenerate

assign din2 = ~clkdiv2;
assign led[1] = clkdiv2[9];

endmodule