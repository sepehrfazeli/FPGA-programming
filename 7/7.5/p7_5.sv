`timescale 1ns / 1ps
module p7_5 (
    input	logic [7:0] in,
    input	logic clk,
    input	logic En,
    input	logic sel,
    input	logic n_shift,
    output	logic [7:0] led,
    output	logic clk_alert,
    output	logic shift_alert
    );
logic [25:0] cntr;

 always @ (posedge(clk))begin
    cntr = cntr + 1;
 end

logic [7:0] S, R, Q, Qn, E, D, tmp;
logic shift;
assign shift = !n_shift;
assign clk_alert = cntr[23];
assign shift_alert = shift;
//assign D = (shift) ? in : 8'b11000000;
assign E = (!En && cntr[23]) ? 8'b11111111: 8'b00000000;

always @(cntr[23]) begin
	if (n_shift) begin
		tmp <= in;
	end else begin
		tmp <= {tmp[6:0],tmp[7]};
	end
	D = tmp;
end


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