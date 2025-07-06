module SPI_2smain(
       input sclk,cs,mosi,reset,
       output reg [7:0] sl1,sl2
       );
wire [7:0] op_mid1, op_mid2;
//Instantiating slave modules
SPI_2slv #(.addr(1'b0)) Slave1 (.sclk(sclk),.cs(cs),.mosi(mosi),.reset(reset),.DAC_in(op_mid1));
SPI_2slv #(.addr(1'b1)) Slave2 (.sclk(sclk),.cs(cs),.mosi(mosi),.reset(reset),.DAC_in(op_mid2));
always @(*)
begin
sl1 <= op_mid1;
sl2 <= op_mid2;
end
endmodule
