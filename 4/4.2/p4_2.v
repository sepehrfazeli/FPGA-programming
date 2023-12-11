module p4_2 (
    input [1:0] sw,
    input [3:0] btn,
    output [3:0] led
);

reg [3:0] Y;

always @ (sw)
begin
    case (sw)
        2'd0:    Y <= 4'd1;
        2'd1:    Y <= 4'd2;
        2'd2:    Y <= 4'd4;
        2'd3:    Y <= 4'd8;
        default: Y <= 4'd0;
    endcase
end

    // AND gates to enable LEDs
    assign led[0] = Y[0] & ~btn[0];// to edit push botton to low active
    assign led[1] = Y[1] & ~btn[1];// to edit push botton to low active
    assign led[2] = Y[2] & ~btn[2];// to edit push botton to low active
    assign led[3] = Y[3] & ~btn[3];// to edit push botton to low active

endmodule