module Serializer(
input      [7:0] P_DATA,
input            Data_Valid,
input            Ser_en,
input            busy,
input            clk,
input            rst,
output reg       Ser_data,
output wire      Ser_done,
output reg [3:0] counter
);
reg [7:0] ser_data_seq;
 
always @(posedge clk or negedge rst)
begin
  if(!rst)
    begin
      Ser_data<=1'b0;
      counter<=4'b0;
    end
  else if(Data_Valid ||(Ser_en && busy))
    begin
      Ser_data<=ser_data_seq[counter-1];
      counter<=counter+1;
    end
  else
    begin
    Ser_data<=1'b1;
     counter<=4'b0;
    end
end

  assign Ser_done=(counter == 4'b1000)? 1'b1 : 1'b0 ;
  
always @(*)
  begin
    ser_data_seq=P_DATA;
  end

endmodule