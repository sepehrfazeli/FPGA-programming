module p3_2(input [4:0] sw, output led);

assign led = sw[0] ^ sw[1] ^ sw[2] ^ sw[3] ^ sw[4];
		
endmodule