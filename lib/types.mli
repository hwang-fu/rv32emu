(* lib/types.mli
   Public interface for basic types *)

(** Byte (8 bits) *)
type byte = int

(** Half-word (16 bits) *)
type hword = int

(** 32-bit word *)
type word = int32

(** Memory address *)
type address = int32

(** Program counter *)
type pc = int32

(** Register index (0-31) *)
type register_idx = int
