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
