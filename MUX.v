module MUX (
input       clk,
input       rst,
input       ser_data,
input       par_bit,
input [1:0] mux_sel,
output reg  TX_OUT
);

always @(posedge clk or negedge rst)
begin
  if(!rst)
    TX_OUT <= 1'b0;
  else
    TX_OUT <= TX_OUT;
end
  
  
always @(*)
begin
  case(mux_sel)
    2'b00:TX_OUT = 1'b0;
    2'b01:TX_OUT = ser_data;
    2'b10:TX_OUT = par_bit;
    2'b11:TX_OUT = 1'b1;
  endcase
end

  
  
endmodule
