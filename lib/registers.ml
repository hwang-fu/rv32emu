(* lib/reg.ml
   RISC-V register file: 32 integer registers (x0-x31) *)

(** The register file type.
    Contains an array of 32 registers, each 32 bits wide. *)
type t = { regs : int32 array }

(** Create a new register file with all registers initialized to 0. *)
let create () = { regs = Array.make 32 0l }

(** Read a register value.
    x0 always returns 0 regardless of what was written (RISC-V standard). *)
let read register_file idx = if idx = 0 then 0l else register_file.regs.(idx)

(** Write a value to a register.
    Writes to x0 are silently ignored (RISC-V standard). *)
let write register_file idx value = if idx <> 0 then register_file.regs.(idx) <- value

(** ABI register names for pretty printing. *)
let abi_name idx =
  match idx with
  | 0 -> "zero"
  | 1 -> "ra"
  | 2 -> "sp"
  | 3 -> "gp"
  | 4 -> "tp"
  | 5 -> "t0"
  | 6 -> "t1"
  | 7 -> "t2"
  | 8 -> "s0"
  | 9 -> "s1"
  | 10 -> "a0"
  | 11 -> "a1"
  | 12 -> "a2"
  | 13 -> "a3"
  | 14 -> "a4"
  | 15 -> "a5"
  | 16 -> "a6"
  | 17 -> "a7"
  | 18 -> "s2"
  | 19 -> "s3"
  | 20 -> "s4"
  | 21 -> "s5"
  | 22 -> "s6"
  | 23 -> "s7"
  | 24 -> "s8"
  | 25 -> "s9"
  | 26 -> "s10"
  | 27 -> "s11"
  | 28 -> "t3"
  | 29 -> "t4"
  | 30 -> "t5"
  | 31 -> "t6"
  | _ -> "???"
;;

(** Dump all registers to stdout for debugging. *)
let dump register_file =
  for i = 0 to 31 do
    Printf.printf "x%02d (%4s) = 0x%08lx\n" i (abi_name i) (read register_file i)
  done
;;
