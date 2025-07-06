module SPI_2slv #(parameter addr=1'b0)(
    input sclk,
    input cs,
    input mosi,
    input reset,
    output reg [7:0] DAC_in
    );
    reg [7:0] Register [7:0];                    //A register bank with 8 registers, each of 8-bits
    reg slvaddr;
    reg [2:0] Reg_Addr;                          // A register to extract and store the address of the register from the mosi pin
    reg wr;                                      // A register to store the bit for read/write operation
    reg [3:0] counter;
    //allocating default values to the registers
    initial begin
    Register[0] = 8'h10;
    Register[1] = 8'h11;
    Register[2] = 8'h12;
    Register[3] = 8'h13;
    Register[4] = 8'h14;
    Register[5] = 8'h15;
    Register[6] = 8'h16;
    Register[7] = 8'h17;
    end
    always @(posedge sclk)
    begin
      if(reset)                                     //active high reset to disable the output 
       begin 
       DAC_in = 8'bZZZZZZZZ;
       counter =  4'b1111;                          //counter reset
       end
    else
      begin
        if(cs)                                      //active low chip select to enable the inputs
         begin
         counter = 4'b1111;                         //counter reset
         end
      else
         begin
         case(counter)
         4'b1111: wr = mosi;                        //storing the mosi input in write register
         4'b1110: slvaddr = mosi;                   //storing the mosi input in slave address register
         4'b1101: Reg_Addr[2] = mosi;
         4'b1100: Reg_Addr[1] = mosi;
         4'b1011: Reg_Addr[0] = mosi;
         4'b1010,4'b1001,4'b1000,4'b0111,4'b0110,4'b0101,4'b0100,4'b0011: 
         if (slvaddr != addr)
             begin
             DAC_in = DAC_in;                       //output remains same if slave address doesn't match
             if (wr == 0)            
             begin
             counter = 4'b1111;                     //to synchronize the counter with the counter of slave in action
             wr = mosi;
             end
             end 
         else
             begin
               if(wr)                                //if wr=1 then write operation
                begin
                Register[Reg_Addr][counter - 4'b0011] = mosi; 
                end
             else
                begin                                //read operation
                counter = 4'b1111;               
                wr = mosi;
                DAC_in = Register[Reg_Addr];
                end
         end
        4'b0010: begin 
                 counter = 4'b1111; 
                 wr = mosi;                         //reading mosi input for next operation 
                 if (slvaddr != addr)
                     begin
                     DAC_in = DAC_in;
                     end 
                 else 
                     begin
                     DAC_in = Register[Reg_Addr];   //updates the output of slave in action during write operation                
                     end                   
                 end                              
        endcase
        counter = counter - 4'b0001;                //decrementing counter by 1

      end
    end
    end
endmodule
