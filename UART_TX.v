module UART_TX (
input [7:0 ] P_DATA,
input        DATA_Valid,
input        CLK,
input        RST,
input        PAR_TYP,
input        PAR_EN,
output       TX_OUT,
output       Busy 
);
wire Ser_en;
wire Ser_data;
wire Ser_done;
wire Par_bit;
wire [3:0] counter;
wire [1:0] mux_sel;

Serializer serializer(
 .P_DATA(P_DATA),     
 .Data_Valid(DATA_Valid), 
 .Ser_en(Ser_en),
 .counter(counter),
 .busy(Busy),     
 .clk(CLK),        
 .rst(RST),        
 .Ser_data(Ser_data),   
 .Ser_done(Ser_done)    
 );
 
Parity_Calc parity_calc(  
.clk(CLK),     
.rst(RST),   
.P_DATA(P_DATA),    
.Data_Valid(DATA_Valid),
.PAR_TYP(PAR_TYP),   
.Par_bit(Par_bit)
);    

FSM fsm (
.Data_Valid(DATA_Valid),
.PAR_EN(PAR_EN),    
.ser_done(Ser_done), 
.counter(counter), 
.clk(CLK),       
.rst(RST),       
.Ser_en(Ser_en),    
.Mux_sel(mux_sel),   
.Busy(Busy)       
);

MUX mux(
.clk(CLK),     
.rst(RST),     
.ser_data(Ser_data),
.par_bit(Par_bit), 
.mux_sel(mux_sel), 
.TX_OUT(TX_OUT)   

);


endmodule