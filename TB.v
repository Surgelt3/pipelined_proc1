`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/04/2025 05:47:46 PM
// Design Name: 
// Module Name: TB
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


module TB(

    );
    
    reg clk;
    reg reset;
    wire [31:0] PCF, InstrF;
    
    
    TOP proc(.clk(clk), .reset(reset), .PCF(PCF), .InstrF(InstrF));
    
    initial begin
        reset <= 1; # 22; reset <= 0;
    end
    
     // generate clock to sequence tests
     always
     begin
        clk <= 1; # 5; clk <= 0; # 5;
     end
     // check results
     always @(negedge clk)
     begin
        if(PCF == 160) begin
            $display("Simulation succeeded");
            $stop;
         end
     end

endmodule
