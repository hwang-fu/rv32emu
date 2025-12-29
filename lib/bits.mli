(* lib/bits.mli
   Public interface for bit manipulation utilities *)

(** Set a specific bit to 1 *)
val set_bit : int32 -> int -> int32

(** Clear a specific bit to 0 *)
val clr_bit : int32 -> int -> int32

(** Test if a specific bit is set (1) *)
val is_bit_set : int32 -> int -> bool

(** Test if a specific bit is cleared (0) *)
val is_bit_clr : int32 -> int -> bool

(** Zero-extend: keep only the lower [bits], clear upper bits *)
val zero_extend : int32 -> bits:int -> int32

(** Sign-extend: extend sign bit from position [bits-1] to bit 31 *)
val sign_extend : int32 -> bits:int -> int32

(** Extract bits [hi:lo] from a word (inclusive) *)
val extract_bits : int32 -> hi:int -> lo:int -> int32
