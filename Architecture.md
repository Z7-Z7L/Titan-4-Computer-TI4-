# <center>Titan-4

### <center>Max Code Instructions is 32.

### <center>Screen: 16x16 Pixel.

### <center>Screen Color: <span style="color:rgb(147, 52, 235)"> rgb(147, 52, 235) </span>

________________________________

# <center>Lables

### <center>Example

```js
// to create a label you add a dot (.) before the label name

.START:
  CMP R1 R2
  BRH EQ .skip
  ADI R3 1
  .skip:
    HLT

// and labels can be used as functions like this

.START:
  LDI R1 3  
  LDI R2 4        
  JMP .Add_Nums    
  ADD R5 R3 R0    
  HLT

.Add_Nums:
  ADD R3 R1 R2
  JMP .START 
```

________________________________

# <center>Instructions

  ________________________________

#### HLT `0000`:

> Stop the computer <br>

#### ADD `0001`:

> C = A + B (Reg C = Reg A + Reg B) <br>

#### SUB `0010`:

> C = A - B (Reg C = Reg A +-Reg B) <br>

#### AND `0011`:

> Bitwise AND (C = A & B) <br>

#### ORR `0100`:

> Bitwise OR (C = (A | B)) <br>

#### NOR `0101`:

> Bitwise NOR (C = !(A | B)) <br>

#### XOR `0110`:
> Bitwise XOR (C = A ⊕ B) <br>

#### RSH `0111`:

> Right Logical Shift (C = A >> 1) <br>
> Example: RSH R1 R2 (Shift R1 by one and load the data in R2) <br>

#### LSH `1000`:

> Left Logical Shift (C = A << 1) <br>

#### LDI `1001`:

> Load Immediate (A = Immediate) <br>

#### ADI `1010`:

> Add Immediate (A = A + Immediate) <br>

#### JMP `1011`:

> Jump (PC = Address) Address: (Immediate) <br>

#### BRH `1100`:

> Branch (PC = Cond(Flag) ? Address) PC + 1 , Address: (Immediate) <br>

#### CMP `1101`:

> Compare (CMP A B) (Compare A with B and set the flags) <br>
> Then after that you can use `BRH` and check if the flag is on and then branch <br>

#### LOD `1110`:

> Memory Load (AR = immediate value) <br>
> Address Register | AR will load the value as a memory address <br>

#### STR `1111`:

> Memory Store (Mem[AR] = A[Reg])  <br>
> Address Register | AR, Mem[AR] data will be stored to A[Register] <br>

  ________________________________

# <center>Flags

  ________________________________

#### Zero `0100` : `Z`          <br>

#### Carry `0101` : `C`         <br>

#### Negative `0110` : `N`      <br>

#### Overflow `0111` : `V`      <br>

#### Equal `1000` : `EQ`        <br>

#### Not Equal `1001` : `NE`    <br>

#### Greater Than `1010` : `GT` <br>

#### Less Than `1011` : `LT`    <br>

  ________________________________

# <center>Memory:

  ________________________________

#### 20 Addresses, Last 12 Addresses for I/O Ports. <br>

#### Total 32 Addresses. <br>

#### 4-Bit data. <br>

#### 5-Bit Bus. <br>

  ________________________________

# <center>Memory Mapped I/O Ports

________________________________

### Note:

> When you want to use the store only I/O Ports you must store it in reg0 or it won't work

## <center>Controls:

#### A Button    `10100` : `A_B` (**load from only**) <br>

#### B Button    `10101` : `B_B` (**load from only**) <br>

#### Arrow UP    `10110` : `ARROW_UP` (**load from only**) <br>

#### Arrow DOWN  `10111` : `ARROW_DOWN` (**load from only**) <br>

#### Arrow RIGHT `11000` : `ARROW_RIGHT` (**load from only**) <br>

#### Arrow LEFT  `11001` : `ARROW_LEFT` (**load from only**) <br>

## <center>Screen:

#### Pixel X `11010` : `PIXEL_X` (***load into only***) <br>

#### Pixel Y `11011` : `PIXEL_Y` (***load into only***) <br>

#### Draw pixel `11100` : `DRAW_PIXEL` (***store to active only***)

> (draw a pixel in the {pixel_x, pixel_y} cords)

#### Clear pixel `11101` : `CLEAR_PIXEL` (***store to active only***)

> (clear the pixel in the {pixel_x, pixel_y} cords)

#### Push screen frame `11110` : `PUSH_FRAME` (***store to active only***)

> (Push the buffer to show drawn pixel)

#### Clear screen frame `11111` : `CLEAR_FRAME` (***store to active only***)

> clear the buffer (set all pixels in screen to 0), then when you push the buffer it clears the screen.

________________________________

# <center>Registers

  ________________________________

#### General Purpose Registers:

> `R0` : `0000` *Always Zero, for I/O ports use* <br> `R1` : `0001`<br> `R2` : `0010`<br> `R3` : `0011`<br> `R4` : `0100`<br> `R5` : `0101`<br> `R6` : `0110`<br> `R7` : `0111`<br> `R8` : `1000`<br> `R9` : `1001`<br> `R10` : `1010`<br> `R11` : `1011`<br> `R12` : `1100`<br> `R13` : `1101`<br> `R14` : `1110`<br> `R15` : `1111` <br>

### Address Registers: AR

> `AR0` : `000` <br> `AR1` : `001`<br> `AR2` : `010`<br> `AR3` : `011`<br> `AR4` : `100`<br> `AR5` : `101`<br> `AR6` : `110`<br> `AR7` : `111`

#### Program Counter: PC <br>

#### Instruction Register: IR

> Temporarily holds the instruction that is currently being executed

#### Flag Register: FR
> `NOTE: FR data will be set after the CMP, NOT after the ALU operation` <br>
> (Stores status flags  after the ALU operation) <br>
```js
So it will be like [Z, C, N, V, EQ, NE , GT, LT]
                   [0, 0, 0, 0,  0,  0 ,  0 , 0]
```
# <center>Each registers data size

```js
General Purpose Registers: 4bit data
Address Registers | AR : 5bit data, 3bit address (5bit data -> holds the memory address)
Program Counter | PC: 5bit [32 Instructions]
Instruction Register | IR: 16bit data [opcode: 4, operand0: 4, operand1: 4, operand2: 4]
Flag Register| FR: 1byte (8bit)
```

```js
 The R0 is always zero you can't write or load a value on it .
 the purpose of it is to store in it when you want to use any of the I/O.

 Example:
  LDI AR0 PIXEL_X
  LDI AR1 PIXEL_Y
  LDI AR2 DRAW_PIXEL
  LDI AR3 PUSH_FRAME

  LDI R1 5 // x_pos
  LDI R2 2 // y_pos

  STR AR0 R1 // Store x_pos to pixel_x
  STR AR1 R2 // Store y_pos to pixel_y

  STR AR2 R0 // Enable draw_pixel I/O
  STR AR3 R0 // Enable push_frame I/O 
```

  ________________________________

# <center>ALU

> 4bit data | `A,B, opcode` <br>
> 4bit output | `data_out`<br>
> [8]1bit output | `Flag Register | FR`