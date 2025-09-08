`timescale 1ns / 1ps

module async_dual_port(
// 8x16 Asynchronous Dual-Port RAM

    // Port A
    input we_a,
    input [2:0] addr_a,
    input [15:0] din_a,
    output  [15:0] dout_a,
    // Port B
    input we_b,
    input [2:0] addr_b,
    input [15:0] din_b,
    output  [15:0] dout_b);

    // Memory declaration: 8 locations, each 16 bits wide
    reg [15:0] mem [7:0];

    // Port A operation
    always @(*) begin
        if (we_a)
            mem[addr_a] <= din_a; 
        end          // Write
 
    // Port B operation
    always @(*) begin
        if (we_b)
            mem[addr_b] <= din_b;       // Write
        end
        
       //Asynchronous read
       assign  dout_a = mem[addr_a];
       assign  dout_b = mem[addr_b];          // Read
    

endmodule
 
