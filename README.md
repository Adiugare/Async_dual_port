# Async_dual_port

This project implements an 8x16 Asynchronous Dual-Port RAM in Verilog HDL.
It allows simultaneous read/write operations from two independent ports (Port A and Port B) without requiring a clock signal, making it suitable for small memory modules in digital designs.

📌 Features

Memory Size: 8 locations × 16-bit word width.

Dual-Port Access:

Port A and Port B operate independently.

Supports simultaneous read/write operations.

Asynchronous Operation:
Read data is always available immediately after an address is applied.

Write occurs whenever we_a or we_b is asserted.

Conflict Handling:

If both ports write to the same address at the same time, the last assignment takes effect (simulation-dependent).

📂 Module I/O
Inputs

we_a : Write enable for Port A
addr_a[2:0] : 3-bit address for Port A
din_a[15:0] : 16-bit input data for Port A
we_b : Write enable for Port B
addr_b[2:0] : 3-bit address for Port B
din_b[15:0] : 16-bit input data for Port B

Outputs

dout_a[15:0] : 16-bit data output from Port A
dout_b[15:0] : 16-bit data output from Port B

⚙️ Usage

Write Operation:
If we_x = 1, the input data din_x is written into memory at location addr_x.

Read Operation:
Output dout_x continuously reflects the data stored at addr_x.

📷 Block Diagram
          +-----------------------------+
          |   8 x 16 Dual-Port RAM      |
          |                             |
 Port A -> | Addr_A ----->|             |
           | Din_A  ----->|   Memory    |-----> Dout_A
           | WE_A   ----->|             |
          |                             |
 Port B -> | Addr_B ----->|             |
           | Din_B  ----->|             |-----> Dout_B
           | WE_B   ----->|             |
          +-----------------------------+

🔧 Applications

Multi-port memory systems
FIFO/Buffer implementations

Register file in processors

Communication between asynchronous modules
