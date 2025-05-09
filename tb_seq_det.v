`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.05.2025 13:04:42
// Design Name: 
// Module Name: tb_seq_det
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


`timescale 1ns / 1ps

module tb_sequence_1010;

    // Testbench signals
    reg clk;
    reg rst_n;
    reg d_in;
    wire seq_det;

    // Instantiate the sequence detector
    sequence_1010 uut (
        .clk(clk),
        .rst_n(rst_n),
        .d_in(d_in),
        .seq_det(seq_det)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    // Test sequence
    reg [15:0] input_stream = 16'b1101010101011000;
    integer i;

    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;
        d_in = 1'bx;

        // Reset the FSM
        #15 rst_n = 1;

        // Apply input stream serially
        for (i = 0; i < 16; i = i + 1) begin
            d_in = input_stream[i];
          @(posedge clk); // Wait for rising edge
        end

        #50 $finish;
    end

    // Monitor output
    initial begin
        $display("Time\tclk\trst_n\td_in\tseq_det");
        $monitor("%0t\t%b\t%b\t%b\t%b", $time, clk, rst_n, d_in, seq_det);
    end

endmodule

