module Parity_Calc(
input       clk,
input       rst,  
input [7:0] P_DATA,
input       Data_Valid,
input       PAR_TYP,
output reg  Par_bit
);
integer n;
reg [3:0] counter;
reg       par_bit;

always  @(posedge clk or negedge rst)
begin
  if(!rst)
    begin
      Par_bit <=1'b0;
      counter <=4'b0;
    end
  else if(Data_Valid)
    Par_bit <=par_bit;
  else
    counter <=4'b0;
end

always @(*)
begin
 
  for(n=0;n<8;n=n+1)
  begin
    if(P_DATA[n])
      counter=counter+1;
    else
      counter=counter;
  end
end

always @(*)
begin
  if(PAR_TYP)
    begin
       if(counter[0]==1)
        par_bit=1'b0;
       else
        par_bit=1'b1;
    end
  else
    begin
       if(counter[0]==1)
        par_bit=1'b1;
       else
        par_bit=1'b0;
    end
end

endmodule