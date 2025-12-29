(** 32-bit word - the fundamental unit in RV32.
      We use int32 because OCaml's int is 63-bit on 64-bit systems,
      and we need exact 32-bit wraparound semantics for arithmetic. *)
type word = int32

(** Memory address - same as word, but semantically distinct *)
type address = int32

(** Program counter *)
type pc = int32
