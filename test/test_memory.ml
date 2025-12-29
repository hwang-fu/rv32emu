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

let test_hword_ops () =
  print_endline "Testing half-word operations (little-endian):";
  let mem = Memory.create ~size:1024 in
  (* Store half-word 0x1234 at address 0 *)
  Memory.store_hword mem 0x00l 0x1234;
  test "load_hword reads stored value" (Memory.load_hword mem 0x00l = 0x1234);
  (* Verify little-endian: byte 0 = 0x34, byte 1 = 0x12 *)
  test "little-endian byte 0" (Memory.load_byte mem 0x00l = 0x34);
  test "little-endian byte 1" (Memory.load_byte mem 0x01l = 0x12)
;;
