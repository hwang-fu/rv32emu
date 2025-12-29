(* lib/types.ml
   Basic type definitions for the RV32I emulator *)

(** Byte (8 bits) - used for memory operations.
    Stored as int for convenience, only lower 8 bits are meaningful. *)
type byte = int

(** Half-word (16 bits) - used for LH/SH instructions.
    Stored as int, only lower 16 bits are meaningful. *)
type hword = int

(** 32-bit word - the fundamental unit in RV32.
    We use int32 because OCaml's int is 63-bit on 64-bit systems,
    and we need exact 32-bit wraparound semantics for arithmetic. *)
type word = int32

(** Memory address - same as word, but semantically distinct *)
type address = int32

(** Program counter *)
type pc = int32

(** Register index (0-31).
    We use int here because it's just an index, not a value that
    needs 32-bit semantics. Valid range: 0-31. *)
type register_idx = int
