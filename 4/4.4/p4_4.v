module p4_4(
    input [9:0] I,
    input [1:0] S,
    input D, // 1 for right, 0 for left
    input R, // 1 for shift, 0 for rotate
    output [9:0] Y
);

reg [9:0] shifter_data;

always @(*) begin
    if (D) begin // Right shift/rotate
        if (R) // Shift
            case (S)
                2'b00: shifter_data = {1'b0, I[9:3]};
                2'b01: shifter_data = {1'b0, I[9:2]};
                2'b10: shifter_data = {1'b0, I[9:1]};
                default: shifter_data = {1'b0, I[9:0]}; // S == 2'b11
            endcase
        else // Rotate
            shifter_data = (S == 2'b00) ? { I[2:0] ,I[9:3]} :
                          (S == 2'b01) ? { I[1:0] ,I[9:2]} :
                          (S == 2'b10) ? { I[0] , I[9:1]} :
                                         {I[9:0]}; // S == 2'b11
    end else begin // Left shift/rotate
        if (R) // Shift
            case (S)
                2'b00: shifter_data = {I[6:0], 3'b0};
                2'b01: shifter_data = {I[7:0], 2'b0};
                2'b10: shifter_data = {I[8:0], 1'b0};
                default: shifter_data = I[9:0]; // S == 2'b11
            endcase
        else // Rotate
            shifter_data = (S == 2'b00) ? { I[6:0], I[9:7]} :
                          (S == 2'b01) ? { I[7:0], I[9:8]} :
                          (S == 2'b10) ? { I[8:0], I[9]} :
                                         {I[9:0]}; // S == 2'b11
    end
end

assign Y = shifter_data;

endmodule