module Mem_tb();
  logic clk = 0;
  logic we;
  logic [4:0] addr;
  logic [3:0] data_in;
  logic [3:0] data_out;

  // Instantiate memory
  Mem uut (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
  );

  always #5 clk = ~clk; // Clock = 10ns period

  initial begin
    // Setup VCD dump for GTKWave
    $dumpfile("mem_tb.vcd");   // output file name
    $dumpvars(0, Mem_tb);      // dump all variables in this module

    // Test sequence
    // Write 1 at address 0
    we = 1; addr = 5'b00000; data_in = 4'b0001; #10;

    // Write 2 at address 1
    addr = 5'b00001; data_in = 4'b0010; #10;

    // Write 3 at address 2
    addr = 5'b00010; data_in = 4'b0011; #10;

    // Now disable writes
    we = 0;

    // Read values
    addr = 5'b00000; #10;
    $display("Read addr 0 = %0d", data_out);

    addr = 5'b00001; #10;
    $display("Read addr 1 = %0d", data_out);

    addr = 5'b00010; #10;
    $display("Read addr 2 = %0d", data_out);

    $stop;
  end
endmodule
