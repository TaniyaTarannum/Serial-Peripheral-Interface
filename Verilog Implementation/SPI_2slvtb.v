module SPI_2slvtb();
reg sclk, cs, mosi,rst;
wire [7:0] dac_op1, dac_op2;
SPI_2smain S1 (.sclk(sclk),.cs(cs),.mosi(mosi),.reset(rst),.sl1(dac_op1),.sl2(dac_op2));
initial begin
sclk = 1'b0;
forever #10 sclk = ~sclk;
end
initial 
begin
$monitor ($time,"sclk=%b,cs=%b,mosi=%b,rst=%b,dac_op1=%b,dac_op2=%b",sclk,cs,mosi,rst,dac_op1,dac_op2);
#5 cs = 1'b1;
//writing the data 
#20 cs = 1'b0; mosi = 1;      //first bit of mosi = 1 i.e write operation
#20 mosi = 1'b0;              //slave address of the first slave
#20 mosi = 1'b0;              //MSB of Register address
#20 mosi = 1'b1; 
#20 mosi = 1'b0;              //LSB of Register address
#20 mosi = 1'b0;              //data[7]
#20 mosi = 1'b1;              //data[6]
#20 mosi = 1'b1;              //data[5]
#20 mosi = 1'b1;              //data[4]
#20 mosi = 1'b1;              //data[3]
#20 mosi = 1'b0;              //data[2]
#20 mosi = 1'b0;              //data[1]
#20 mosi = 1'b1;              //data[0]
//register 010 is updated by the value 79 - slave 1
//next operation 
#20 mosi = 1'b0;              //reading
#20 mosi = 1'b1;              //slave address of the second slave
#20 mosi = 1'b0;              //MSB of reg
#20 mosi = 1'b0;
#20 mosi = 1'b1;              //LSB of reg
//the value inside register 001 is 11 - slave 2
//the register data is given at the output
#20 mosi = 1'b1;              //writing operation
#20 mosi = 1'b0;              //slave address of the first slave
#20 mosi = 1'b1;              //MSB of reg
#20 mosi = 1'b0;
#20 mosi = 1'b1;              //LSB of register
#20 mosi = 1'b1;              //data[7]
#20 mosi = 1'b1;
#20 mosi = 1'b1;
#20 mosi = 1'b1;
#20 mosi = 1'b1;
#20 mosi = 1'b1; 
#20 mosi = 1'b1;
#20 mosi = 1'b0;             //data[0]
//the register 101 is updated by the value fe - slave 1
#20 mosi = 1'b0;             //reading operation
#20 mosi = 1'b1;             //slave address of the second slave
#20 mosi = 1'b1;             //MSB of reg address
#20 mosi = 1'b0;
#20 mosi = 1'b1;             //LSB of register address
//the value of register 101 is 15 - slave 2
//output is updated by the data of the register of given register address
#20 mosi = 1'b0; cs = 1'b1; //input is disabled and data on the output will remain same until cs is enabled
#20 mosi = 1'b1;
#20 mosi = 1'b1;
#20 mosi = 1'b0; cs = 1'b0; //cs enabled and read operation is carried out
#20 mosi = 1'b0;            //address of slave 1
#20 mosi = 1'b0;            //MSB of Register address
#20 mosi = 1'b1; 
#20 mosi = 1'b0;            //LSB of Register address
//010 register's data is read - slave 1
#20 mosi = 1'b1;            //data[7]
#20 mosi = 1'b1;            //data[6]
#20 mosi = 1'b0; rst = 1'b1;//data[5]
#20 mosi = 1'b1;  cs = 1'b1;//data[4]
#20 mosi = 1'b0;            //data[3]
#20 mosi = 1'b1;            //data[2]
#20 mosi = 1'b1;            //data[1]
#20 mosi = 1'b1;            //data[0]
//#40 cs = 1'b1; 
//#20 cs = 1'b0; mosi = 1'b0; //read operation
#20 mosi = 1'b0;
#20 mosi = 1'b1;
#20 mosi = 1'b0;
#20 mosi = 1'b0;
#20 mosi = 1'b0;
#20 mosi = 1'b0;
#20 mosi = 1'b1;
#20 mosi = 1'b0;
#20 mosi = 1'b0;
#20 $finish;
end
endmodule
