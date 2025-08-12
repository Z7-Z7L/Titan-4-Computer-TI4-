module Mem #(
  parameter ADDR_WIDTH = 5, // 5-bit address
  parameter DATA_WIDTH = 4, // 4-bit data
  parameter MEM_SIZE = 1 << ADDR_WIDTH
) (
  output reg [DATA_WIDTH-1:0] data_out,

  input wire clk,
  input wire we, // write enable
  input wire [ADDR_WIDTH-1:0] addr, // address
  input wire [DATA_WIDTH-1:0] data_in  
);

  // memory array
  reg [DATA_WIDTH-1:0] memory [0:MEM_SIZE-1];

  always @(posedge clk) begin
    if (we) begin
      memory[addr] <= data_in; // Write
    end
    data_out <= memory[addr];    // Read
  end

  
endmodule