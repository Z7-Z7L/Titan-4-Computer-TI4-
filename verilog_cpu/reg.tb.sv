module Reg_tb();
    logic clk;
  logic rst;
  logic we;
  logic [3:0] data;
  wire [3:0] d_out;

  // DUT instance
  Reg #(4) dut (
    .d_out(d_out),
    .data(data),
    .clk(clk),
    .we(we),
    .rst(rst)
  );

  // Clock generator (10ns period)
  always #5 clk = ~clk;

  initial begin
    $dumpfile("reg_test.vcd");
    $dumpvars(0, Reg_tb);

    // Initialize
    clk = 0;
    rst = 1;
    we  = 0;
    data = 4'b0000;

    // Reset pulse
    #10 rst = 0;

    // Write 1010
    #10 data = 4'b1010; we = 1;
    #10 we = 0;

    // Wait a bit
    #20;

    // Write 1111
    data = 4'b1111; we = 1;
    #10 we = 0;

    // Reset again
    #10 rst = 1;
    #10 rst = 0;

    #20 $finish;
  end

endmodule