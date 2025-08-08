// ALU
module ALU(
  output reg [3:0] o,
  output reg [7:0] flags,
  input [3:0] opcode,
  input [3:0] a,
  input [3:0] b
);

  localparam FLAG_Z  = 0;// 4'b0100 // Zero
  localparam FLAG_C  = 1;// 4'b0101 // Carry
  localparam FLAG_N  = 2;// 4'b0110 // Negative
  localparam FLAG_V  = 3;// 4'b0111 // Overflow
  localparam FLAG_EQ = 4;// 4'b1000 // Equal
  localparam FLAG_NE = 5;// 4'b1001 // Not Equal
  localparam FLAG_GT = 6;// 4'b1010 // Greater Than
  localparam FLAG_LT = 7;// 4'b1011 // Less Than

  wire [4:0] sub_result = {1'b0, a} - {1'b0, b};

  always @(*) begin
    // Default Outputs
    o = 4'b0000;
    flags = 8'b00000000;
  
    flags[FLAG_EQ] = (a == b);
    flags[FLAG_NE] = (a != b);
    flags[FLAG_GT] = (a > b);   // Unsigned comparison
    flags[FLAG_LT] = (a < b);   // Unsigned comparison

    case(opcode)
      4'b0001: begin
        o = a + b;
        flags[FLAG_Z] = (o == 4'b0000);
        flags[FLAG_C] = (a + b > 15); // Carry out
        flags[FLAG_N] = o[3];         // Negative flag
        // Overflow for signed addition
        flags[FLAG_V] = (a[3] == b[3]) && (o[3] != a[3]);
      end    // ADD

      4'b0010: begin
        o = a - b;
        flags[FLAG_Z] = (o == 4'b0000);
        flags[FLAG_C] = ~sub_result[4];  // No borrow means carry
        flags[FLAG_N] = o[3];            // Negative flag
        // Overflow for signed subtraction
        flags[FLAG_V] = (a[3] != b[3]) && (o[3] != a[3]);
        // Update comparison flags based on subtraction
        flags[FLAG_EQ] = flags[FLAG_Z];
        flags[FLAG_NE] = ~flags[FLAG_Z];
        flags[FLAG_GT] = ~flags[FLAG_Z] & ~flags[FLAG_C];
        flags[FLAG_LT] = flags[FLAG_C];
      end    // SUB

      4'b0011: begin 
        o = a & b;
        flags[FLAG_Z] = (o == 4'b0000);
        flags[FLAG_N] = o[3];
      end    // AND 

      4'b0100: begin 
        o = a | b;
        flags[FLAG_Z] = (o == 4'b0000);
        flags[FLAG_N] = o[3];
      end    // ORR

      4'b0101: begin 
        o = ~(a | b);
        flags[FLAG_Z] = (o == 4'b0000);
        flags[FLAG_N] = o[3];
      end // NOR

      4'b0110: begin 
        o = a ^ b;
        flags[FLAG_Z] = (o == 4'b0000);
        flags[FLAG_N] = o[3];
      end    // XOR

      4'b0111: begin
        o = a >> 1;
        flags[FLAG_Z] = (o == 4'b0000);
        flags[FLAG_N] = o[3];
        flags[FLAG_C] = a[0];  // Carry is the shifted-out bit
      end   // RSH

      4'b1000: begin
        o = a << 1;
        flags[FLAG_Z] = (o == 4'b0000);
        flags[FLAG_N] = o[3];
        flags[FLAG_C] = a[3];  // Carry is the shifted-out bit
      end   // LSH

      4'b1001: o = b;  // LDI, after the command set reg a value to `o`

      4'b1010: begin
        o = a + b;
        flags[FLAG_Z] = (o == 4'b0000);
        flags[FLAG_C] = (a + b > 15); // Carry out
        flags[FLAG_N] = o[3];         // Negative flag
        // Overflow for signed addition
        flags[FLAG_V] = (a[3] == b[3]) && (o[3] != a[3]);
      end    // ADI, after the command set reg a value to `o`
      
      4'b1101: begin
        o = 4'b0000;
        
        flags[FLAG_Z] = (sub_result[3:0] == 4'b0000);
        flags[FLAG_N] = sub_result[3];
        flags[FLAG_V] = (a[3] != b[3]) && (sub_result[3] != a[3]);

        flags[FLAG_C] = ~sub_result[4];

        flags[FLAG_LT] = sub_result[4];
        flags[FLAG_GT] = ~flags[FLAG_Z] & ~sub_result[4];

        flags[FLAG_EQ] = flags[FLAG_Z];
        flags[FLAG_NE] = ~flags[FLAG_Z];
        
      end // CMP
      default: o = 4'b0000;
    endcase
  end

endmodule
