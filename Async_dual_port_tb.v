`timescale 1ns / 1ps

module async_dual_port_tb();
    reg we_a, we_b;
    reg [2:0] addr_a, addr_b;
    reg [15:0] din_a, din_b;
    wire [15:0] dout_a, dout_b;

    // Instantiate DUT
    async_dual_port uut (
        .we_a(we_a),
        .addr_a(addr_a),
        .din_a(din_a),
        .dout_a(dout_a),
        .we_b(we_b),
        .addr_b(addr_b),
        .din_b(din_b),
        .dout_b(dout_b)
    );
    
    task initialize();
     begin
        // Initialize
        we_a = 0; we_b = 0;
        addr_a = 0; addr_b = 0;
        din_a = 0; din_b = 0;
     end
    endtask
    
     task delay();
    begin
    #10;
    end
    endtask

    // Task to write data on Port A
    task write_a(input [2:0] addr, input [15:0] data);
    begin
    delay;
        we_a = 1;
        addr_a = addr;
        din_a  = data;
        delay;
        we_a = 0;
    end
    endtask

    // Task to write data on Port B
    task write_b(input [2:0] addr, input [15:0] data);
    begin
    delay;
        we_b = 1;
        addr_b = addr;
        din_b  = data;
        delay;
        we_b = 0;
    end
    endtask

    // Task to read data from Port A
    task read_a(input [2:0] addr);
    begin
    delay;
        addr_a = addr;
    end
    endtask

    // Task to read data from Port B
    task read_b(input [2:0] addr);
    begin
    delay;
        addr_b = addr;
    end
    endtask

    // Stimulus
    initial begin
        initialize;
        // Write & Read operations
        delay;
        write_a(3'b100, 16'b1011);
        read_a(3'b100);
        
        delay;
        write_b(3'b110, 16'b0101);
        read_b(3'b110);

        // Simultaneous write
        fork
            write_a(3'b011, 16'b0011);
            write_b(3'b001, 16'b0010);
        join

        // Read both
        read_a(3'b011);
        read_b(3'b001);

        #20 $finish;
    end

    // Monitor
    initial begin
        $monitor("Time=%0t | A: we=%b addr=%h din=%h dout=%h || B: we=%b addr=%h din=%h dout=%h",
                  $time, we_a, addr_a, din_a, dout_a, we_b, addr_b, din_b, dout_b);
    end

endmodule
