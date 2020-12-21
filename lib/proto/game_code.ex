defmodule Drip.Protocol.GameCode do
  use Bitwise

  use Zigler

  ~Z"""
  fn do_the_thing(inp: u8) u8 {
    return switch(inp) {
      0 => 0x19,
      1 => 0x15,
      2 => 0x13,
      3 => 0x0A,
      4 => 0x08,
      5 => 0x0B,
      6 => 0x0C,
      7 => 0x0D,
      8 => 0x16,
      9 => 0x0F,
      10 => 0x10,
      11 => 0x06,
      12 => 0x18,
      13 => 0x17,
      14 => 0x12,
      15 => 0x07,
      16 => 0x00,
      17 => 0x03,
      18 => 0x09,
      19 => 0x04,
      20 => 0x0E,
      21 => 0x14,
      22 => 0x01,
      23 => 0x02,
      24 => 0x05,
      25 => 0x11,
    };
  }

  /// nif: string_code_to_int/1
  fn string_code_to_int(string_code: []u8) i32 {
    const a = do_the_thing(string_code[0]);
    const b = do_the_thing(string_code[1]);
    const c = do_the_thing(string_code[2]);
    const d = do_the_thing(string_code[3]);
    const e = do_the_thing(string_code[4]);
    const f = do_the_thing(string_code[5]);


    const one = a + 26 * b && 0x3FF
    const two = c + 26 * (d + 26 * (e + 26 * f))

    return one ||| (v &&& 0x3FFFFC00) ||| 0x80000000;
  }
  """
end
