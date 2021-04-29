`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2021 19:14:04
// Design Name: 
// Module Name: HDMI_test_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module HDMI_test_TB(

    );
    
    reg sys_clk;  // 40MHz SVGA
    wire [2:0] TMDSp, TMDSn;
	wire TMDSp_clock, TMDSn_clock, hsync, vsync, pixclk;
	wire [7:0] red, green, blue;
	
	integer write_data;
	integer i;
	
	 // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;  
	
	HDMI_test uut(
	  .sys_clk(sys_clk),
	  //.TMDSp(TMDSp), 
	  //.TMDSn(TMDSn),
	  //.TMDSp_clock(TMDSp_clock), 
	  //.TMDSn_clock(TMDSn_clock)
	  .pixclk_s(pixclk),
	  .hSync_s(hsync),
	  .vSync_s(vsync),
	  .r_s(red),
	  .g_s(green),
	  .b_s(blue)
	  
	);
	
	initial 
	   begin
	// write data : provide full path or create project as above
         write_data = $fopen("frame_data.txt");
	   
	 for (i=0; i<100000000; i=i+1) 
        begin
            // values for a and b
            sys_clk = 1;
            #period; // wait for period 
            sys_clk = 0;
            #period; // wait for period 
            
                // write data to file using 'fdisplay'
           $fdisplay(write_data, "%b,%b,%b,%b,%b,%b", pixclk, hsync, vsync, red, green, blue);
    //$fdisplay(write_data, "test ");
         
        end
        
         $fclose(write_data);  // close the file
     end


	
endmodule
