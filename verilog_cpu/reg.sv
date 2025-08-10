module Reg #(parameter WIDTH = 4) (
  output [WIDTH-1:0] d_out,
  input wire [WIDTH-1:0] data,
  input wire clk,
  input wire we, // Write enable
  input wire rst
);

  reg [WIDTH-1:0] stored_data;

  always @(posedge clk) begin
    if (rst) begin
      stored_data <= 4'b0000;
    end
    else if (we) begin
      stored_data <= data;
    end
  end

  assign d_out = stored_data;

endmodule