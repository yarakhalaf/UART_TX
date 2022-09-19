module FSM(
input            Data_Valid,
input            PAR_EN,
input            ser_done,
input      [3:0] counter,
input            clk,
input            rst,
output reg       Ser_en,
output reg [1:0] Mux_sel,
output reg       Busy
);
localparam IDLE_State = 2'b00,
           Data_Valid_State=2'b01,
           Parity_State=2'b10,
           stop_State=2'b11;
          
reg [1:0] current_state,next_state,mux_sel; 
reg       ser_en,busy; 

always @(posedge clk or negedge rst)
 begin
   if(!rst)
   begin  
     current_state<=IDLE_State;
     Ser_en <= 1'b0;
     Mux_sel<= 2'b0;
     Busy   <= 1'b0;
   end
   else
   begin  
     current_state<=next_state;
     Ser_en <= ser_en;
     Mux_sel<= mux_sel;
     Busy   <= busy;
   end
 end  

always @(*)
begin
  case(current_state)
   IDLE_State:begin
     if(Data_Valid)
     begin
       next_state=Data_Valid_State;
       busy=1'b1;
       mux_sel=2'b00;
       ser_en=1'b1;
     end
     else
     begin
       next_state=IDLE_State;
       busy=1'b0;
       mux_sel=2'b01;
       ser_en=1'b0;
     end
   end
   Data_Valid_State:begin
     if(counter < 4'b1000)
     begin
       next_state=Data_Valid_State;
       busy=1'b1;
       mux_sel=2'b01;
       ser_en=1'b1;
     end
     else if(ser_done)
     begin
       next_state=Parity_State;
       busy=1'b1;
       mux_sel=2'b01;
       ser_en=1'b0;
     end
     else
     begin
       next_state=IDLE_State;
       busy=1'b1;
       mux_sel=2'b01;
       ser_en=1'b0;
     end 
   end
   Parity_State:begin
     if(PAR_EN)
     begin
       next_state=stop_State;
       busy=1'b1;
       mux_sel=2'b10;
       ser_en=1'b0;
     end
     else
     begin
       next_state=IDLE_State;
       busy=1'b1;
       mux_sel=2'b11;
       ser_en=1'b0;
     end
   end
   stop_State:begin
      next_state=IDLE_State;
      busy=1'b1;
      mux_sel=2'b11;
      ser_en=1'b0;
   end
   
 endcase
end






        

endmodule