package gui

import rl "vendor:raylib"
import "core:os"
import "core:strings"
import "core:strconv"
import "core:fmt"

SCREEN_WIDTH, SCREEN_HEIGHT :: 600, 600;

ROW, COL :: 16, 16;

PIXEL_SIZE :: 37;

/* Buttons

  bits -> 00000000
  each bit represent a button state

*/

Buttons :: enum{
  RIGHT_ARROW  = 1,
  LEFT_ARROW   = 2,
  UP_ARROW     = 3,
  DOWN_ARROW   = 4,
  A_BUTTON     = 5,
  B_BUTTON     = 6,
}

BTNS_TO_DATA :: proc(btns: [Buttons]bool) -> string {
  data: [Buttons]u8
  
  for b, i in btns {
    if (b) {
      data[i] = 1;
    }
  }

  builder := strings.builder_make();
  defer strings.builder_destroy(&builder);

  for d in data {
    strings.write_int(&builder, int(d));
  }

  res := strings.to_string(builder);

  return res;
}

Write_BTNS_Data :: proc(btns: [Buttons]bool) {
  buttons_data := BTNS_TO_DATA(btns);

  os.write_entire_file("./src/buttons_state.bin", transmute([]byte)buttons_data);
}

main :: proc() {
  // Initialization
  rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Virtual IO");
  rl.SetTargetFPS(60);

  screen: [ROW][COL]bool;

  last_mod_time: i64;

  buttons: [Buttons]bool;

  Write_BTNS_Data(buttons);

  for (!rl.WindowShouldClose()) {
    Update: {

      info, ok := os.stat("./src/screen_data.bin");
      
      if (ok != nil) {
        fmt.println("Failed to get file info");
        return;
      }


      if (info.modification_time._nsec > last_mod_time) {      
        data, ready_ok := os.read_entire_file_from_filename("./src/screen_data.bin");
        if (!ready_ok) {
          fmt.println("Failed to open the file");
          return;
        }

        pixels := make([]u8, len(data) * 8);

        for i in 0..<len(data) {
          byte_ := data[i];
          for bit in 0..<8 {
            pixels[i*8 + bit] = (byte_ >> (7-uint(bit))) & 1;
          }
        }
        for row in 0..<i32(len(screen)) {
          for col in 0..<i32(len(screen[row])) {
            screen[row][col] = pixels[row * 16 + col] == 1;
          }
        }

        last_mod_time = info.modification_time._nsec;
      }
    }

    Draw: {   
      rl.BeginDrawing();
        rl.ClearBackground(rl.Color{40,40,40,255});
        for row in 0..<i32(len(screen)) {
          for col in 0..<i32(len(screen[row])) {
            if (screen[row][col]) {
              rl.DrawRectangle(3 + row * PIXEL_SIZE, 3 + col * PIXEL_SIZE, PIXEL_SIZE, PIXEL_SIZE, rl.PURPLE);
            }
            rl.DrawRectangleLines(3 + row * PIXEL_SIZE, 3 + col * PIXEL_SIZE, PIXEL_SIZE, PIXEL_SIZE, rl.WHITE);
          }
        }
      rl.EndDrawing();
    }
  }

  // Close the window
  rl.CloseWindow();
}