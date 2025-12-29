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
