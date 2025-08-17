module Mem #(
    parameter ADDR_WIDTH = 5,   // 5 bits → 32 locations
    parameter DATA_WIDTH = 4    // 4-bit data
)(
    input  logic clk,
    input  logic we,                        // write enable
    input  logic [ADDR_WIDTH-1:0] addr,     // 5-bit address
    input  logic [DATA_WIDTH-1:0] data_in,  // data to write
    output logic [DATA_WIDTH-1:0] data_out  // data read
);

    // Memory array: 32 x 4 bits
    logic [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];

    // Write logic (synchronous)
    always_ff @(posedge clk) begin
        if (we) begin
            mem[addr] <= data_in;
        end
    end

    // Read logic (combinational, like your Odin Read_Memory)
    assign data_out = mem[addr];

endmodule
