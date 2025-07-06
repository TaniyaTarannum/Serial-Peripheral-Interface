# Serial-Peripheral-Interface 
## Abstract
This project presents the design and implementation of a customized SPI interface, developed from RTL to GDSII. The Serial Peripheral Interface (SPI) is a high-speed, synchronous communication protocol that supports full-duplex data transfer between a master and multiple slave devices. In this work, the SPI interface is employed to enable communication between a microcontroller and two Digital-to-Analog Converters (DACs). Data is received serially from the microcontroller and subsequently distributed in parallel to the DACs. The design was implemented using 65nm CMOS technology with a 9-metal-layer process, encompassing all stages from behavioral modeling to physical layout.
## Tools and Technologies
- Verilog HDL.
- Xilinx Vivado.
- Cadence Genus.
- Cadence Conformal.
- CMOS 65nm Technology.
## Overview
### Specifications
The interface is customized and designed to connect two DACs with a microcontroller. Each slave is integrated with a register bank consisting of eight 8-bit registers. Four signals, clock, chip select, reset, and MOSI (Master Out Slave In), are used to establish communication and meet the system requirements.
#### clock (sclk)
The clock signal is used to synchronize data transfer, and the frequency of the clock used in the design is 50 MHz.
#### chip select (cs)
If active high, then input is disabled.
#### reset (rst)
If active high, then the output is disabled.
#### mosi 
Serially inputs data.  
**The interface is as shown:**
![image](https://github.com/user-attachments/assets/9d0abdd0-d1f9-4551-9096-3f2fc8f73a83)
