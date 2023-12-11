`timescale 1ns/1ps
module p5_1 (
	input clk,
	input [7:0] D,
	output [7:0] Y,
	output Data
);

reg [27:0] counter;
reg max_result;
reg [7:0] dec_result;

always @ (posedge clk)
begin
	counter <= counter + 1;
end


always @ (counter[27:25]) begin

	case (counter[27:25])
		3'b000: max_result <= D[0];
		3'b001: max_result <= D[1];
		3'b010: max_result <= D[2];
		3'b011: max_result <= D[3];
		3'b100: max_result <= D[4];
		3'b101: max_result <= D[5];
		3'b110: max_result <= D[6];
		3'b111: max_result <= D[7];
		default:  max_result <= 1'b0;
	endcase
	if ( max_result == 1) 
		begin
			case( counter[27:25] )

				3'b000: dec_result <= 8'b00000001;
				3'b001: dec_result <= 8'b00000010;
				3'b010: dec_result <= 8'b00000100;
				3'b011: dec_result <= 8'b00001000;
				3'b100: dec_result <= 8'b00010000;
				3'b101: dec_result <= 8'b00100000;
				3'b110: dec_result <= 8'b01000000;
				3'b111: dec_result <= 8'b10000000;
				default:  dec_result <= 8'b00000000;
			endcase	
		end else dec_result <= 8'b00000000;
	
end

assign Data = max_result;

assign Y = dec_result;



endmodule