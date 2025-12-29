(* lib/memory.mli
   Public interface for the memory subsystem *)

(** Memory type *)
type t

(** Create memory of given size in bytes, initialized to zero *)
val create : size:int -> t

(** Load a single byte (unsigned, returns 0-255) *)
val load_byte : t -> int32 -> int

(** Store a single byte *)
val store_byte : t -> int32 -> int -> unit

(** Load half-word (16 bits, little-endian, unsigned) *)
val load_hword : t -> int32 -> int

(** Store half-word (16 bits, little-endian) *)
val store_hword : t -> int32 -> int -> unit

(** Load word (32 bits, little-endian) *)
val load_word : t -> int32 -> int32

(** Store word (32 bits, little-endian) *)
val store_word : t -> int32 -> int32 -> unit

(** Load raw bytes into memory starting at address *)
val load_bytes : t -> int32 -> bytes -> unit
