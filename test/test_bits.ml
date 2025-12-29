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

(** Test sign_extend *)
let test_sign_extend () =
  print_endline "Testing sign_extend:";
  (* Positive 8-bit value stays positive *)
  test "sign_extend 0x7F from 8 bits" (Bits.sign_extend 0x7Fl ~bits:8 = 0x7Fl);
  (* Negative 8-bit value (0x80 = -128) extends to 0xFFFFFF80 *)
  test "sign_extend 0x80 from 8 bits" (Bits.sign_extend 0x80l ~bits:8 = 0xFFFFFF80l);
  (* 0xFF as 8-bit = -1, extends to 0xFFFFFFFF *)
  test "sign_extend 0xFF from 8 bits" (Bits.sign_extend 0xFFl ~bits:8 = 0xFFFFFFFFl);
  (* 16-bit positive *)
  test "sign_extend 0x7FFF from 16 bits" (Bits.sign_extend 0x7FFFl ~bits:16 = 0x7FFFl);
  (* 16-bit negative *)
  test "sign_extend 0x8000 from 16 bits" (Bits.sign_extend 0x8000l ~bits:16 = 0xFFFF8000l)
;;
