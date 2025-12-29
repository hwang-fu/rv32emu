(* test/test_registers.ml
   Unit tests for register file *)

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

let test_x0_hardwired () =
  print_endline "Testing x0 hardwired to zero:";
  let rf = Registers.create () in
  (* x0 should always read 0 *)
  test "x0 reads 0 initially" (Registers.read rf 0 = 0l);
  (* Writing to x0 should be ignored *)
  Registers.write rf 0 0x12345678l;
  test "x0 still reads 0 after write" (Registers.read rf 0 = 0l)
;;

let test_read_write () =
  print_endline "Testing read/write:";
  let rf = Registers.create () in
  (* Write and read back *)
  Registers.write rf 1 0xDEADBEEFl;
  test "x1 reads written value" (Registers.read rf 1 = 0xDEADBEEFl);
  (* Write to another register *)
  Registers.write rf 31 0xCAFEBABEl;
  test "x31 reads written value" (Registers.read rf 31 = 0xCAFEBABEl);
  (* Overwrite *)
  Registers.write rf 1 0x11111111l;
  test "x1 reads new value after overwrite" (Registers.read rf 1 = 0x11111111l)
;;

let test_abi_names () =
  print_endline "Testing ABI names:";
  test "x0 is zero" (Registers.abi_name 0 = "zero");
  test "x1 is ra" (Registers.abi_name 1 = "ra");
  test "x2 is sp" (Registers.abi_name 2 = "sp");
  test "x10 is a0" (Registers.abi_name 10 = "a0");
  test "x31 is t6" (Registers.abi_name 31 = "t6")
;;

let () =
  print_endline "\n=== Registers Module Tests ===\n";
  test_x0_hardwired ();
  test_read_write ();
  test_abi_names ();
  Printf.printf "\n=== Results: %d/%d passed ===\n" !pass_count !test_count;
  if !pass_count < !test_count then exit 1
;;
