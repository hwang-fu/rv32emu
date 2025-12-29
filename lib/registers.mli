(* lib/registers.mli
     Public interface for the register file *)

(** The register file type *)
type t

(** Create a new register file with all registers set to 0 *)
val create : unit -> t

(** Read a register (x0 always returns 0) *)
val read : t -> int -> int32

(** Write a register (writes to x0 are ignored) *)
val write : t -> int -> int32 -> unit

(** Get the ABI name for a register index *)
val abi_name : int -> string

(** Dump all registers to stdout *)
val dump : t -> unit
