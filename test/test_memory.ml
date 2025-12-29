open Rv32emu

let test_count = ref 0
let pass_count = ref 0

let test name condition =
  incr test_count;
  if condition
  then (
    incr pass_count;
    Printf.printf "  ✓ %s\n" name)
  else Printf.printf "  ✗ %s (FAILED)\n" name
;;

let test_byte_ops () =
  print_endline "Testing byte operations:";
  let mem = Memory.create ~size:1024 in
  (* Store and load byte *)
  Memory.store_byte mem 0x00l 0xAB;
  test "load_byte reads stored value" (Memory.load_byte mem 0x00l = 0xAB);
  (* Byte should be masked to 8 bits *)
  Memory.store_byte mem 0x01l 0x1FF;
  test "store_byte masks to 8 bits" (Memory.load_byte mem 0x01l = 0xFF)
;;
