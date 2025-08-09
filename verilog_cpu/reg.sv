module Reg (
  output reg [3:0] d_out,
  input wire [3:0] data,
  input wire clk,
  input wire rst
);

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      d_out <= 4'b0000;
    end
    else begin
      d_out <= data;
    end


  end

endmodule