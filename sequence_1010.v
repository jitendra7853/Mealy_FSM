`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.05.2025 12:36:06
// Design Name: 
// Module Name: sequence_1010
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


module sequence_1010(
  input clk, rst_n,d_in,
  output seq_det);
  
  reg[1:0] ps,ns;
  
  parameter S0= 2'b00;
  parameter S1= 2'b01;
  parameter S2 = 2'b10;
  parameter S3= 2'b11;
  
  always@(posedge clk,negedge rst_n) 
     begin
      if(!rst_n)
         ps<=0;
       else ps<=ns;
    end 
      
      
  always@(ps, d_in)
    begin
    case(ps)
    S0: ns= d_in? S1:S0;
    S1: ns= d_in? S1:S2; 
    S2: ns= d_in? S3:S0;
    S3: ns= d_in? S1:S0;
    endcase
    end
    assign seq_det= (ps==S3&& d_in==0)?1'b1:1'b0;
  
  
endmodule
