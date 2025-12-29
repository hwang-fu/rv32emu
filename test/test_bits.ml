open Rv32emu

let test_count = ref 0
let pass_count = ref 0

(** Simple test helper *)
let test name condition =
  incr test_count;
  if condition
  then (
    incr pass_count;
    Printf.printf "  ✓ %s\n" name)
  else Printf.printf "  ✗ %s (FAILED)\n" name
;;

(** Test extract_bits *)
let test_extract_bits () =
  print_endline "Testing extract_bits:";
  (* Extract bits [15:8] from 0xDEADBEEF should give 0xBE *)
  test
    "extract [15:8] from 0xDEADBEEF"
    (Bits.extract_bits 0xDEADBEEFl ~hi:15 ~lo:8 = 0xBEl);
  (* Extract bits [7:0] from 0xDEADBEEF should give 0xEF *)
  test "extract [7:0] from 0xDEADBEEF" (Bits.extract_bits 0xDEADBEEFl ~hi:7 ~lo:0 = 0xEFl);
  (* Extract bits [31:24] from 0xDEADBEEF should give 0xDE *)
  test
    "extract [31:24] from 0xDEADBEEF"
    (Bits.extract_bits 0xDEADBEEFl ~hi:31 ~lo:24 = 0xDEl);
  (* Extract single bit *)
  test "extract [0:0] from 0x01" (Bits.extract_bits 0x01l ~hi:0 ~lo:0 = 1l);
  test "extract [0:0] from 0x00" (Bits.extract_bits 0x00l ~hi:0 ~lo:0 = 0l)
;;
