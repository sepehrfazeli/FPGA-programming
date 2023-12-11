`timescale 1ns / 1ps
module p7_4_2 (
    input	logic [7:0] D,
    input	logic clk,
    input	logic En,
    input	logic sel,
    output	logic [7:0] led,
    output	logic clk_alert,
    output	logic sel_alert
    );
logic [25:0] cntr;

 always @ (posedge(clk))begin
    cntr = cntr + 1;
 end

logic [7:0] S;
logic [7:0] R;
logic [7:0] Q;
logic [7:0] Qn;
logic [7:0] E;
assign clk_alert = cntr[23];
assign sel_alert = !sel;
assign E = (!En && cntr[23]) ? 8'b11111111: 8'b00000000;

//D latch section
assign S		= ~(D & E);
assign R		= ~(E & ~D);

//S-R latch section
assign Q		= ~(S & Qn);
assign Qn	= ~(R & Q);

//mux 2:1
always_comb begin
	case(!sel)
		1'd0: led = D; // '0'
		1'd1: led = Q; // '1'
	endcase
end

endmodule