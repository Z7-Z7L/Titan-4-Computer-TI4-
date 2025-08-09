module Reg_tb();
  // Inputs
  reg [3:0] data;
  reg clk;
  reg rst;

  // Outputs
  wire [3:0] d_out;

  Reg _reg (
    .d_out(d_out),
    .data(data),
    .clk(clk),
    .rst(rst)
  );

  initial begin
    $dumpfile("reg_test.vcd");
    $dumpvars(0, Reg_tb);
  end

  // Clock generation
  initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 1'b1;
    data = 4'b0000;

    #10;
    rst = 1'b0;

    #10;
    data = 4'b1010;
    
    #10;
    data = 4'b1100;

    #10;
    data = 4'b0011;

    #10;
    rst = 1'b1;

    #10;
    rst = 1'b0;

    #20;
    $finish;
  end

endmodule