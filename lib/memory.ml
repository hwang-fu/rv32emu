(** Memory type: a contiguous block of bytes *)
type t =
  { data : bytes
  ; size : int
  }

(** Create memory of given size (in bytes), initialized to zero *)
let create ~size = { data = Bytes.make size '\x00'; size }

(** Check if address is within bounds *)
let is_within_bounds memory address =
  let addr_start = Int32.to_int address in
  if addr_start < 0 || addr_start >= memory.size
  then failwith (Printf.sprintf "Memory access out of bounds: 0x%08lx" address)
;;

(** Load a single byte (unsigned, 0-255) *)
let load_byte memory address =
  is_within_bounds memory address;
  Char.code (Bytes.get memory.data (Int32.to_int address))
;;

(** Store a single byte *)
let store_byte memory address b =
  is_within_bounds memory address;
  Bytes.set memory.data (Int32.to_int address) (Char.chr (b land 0xFF))
;;

(** Load half-word (16 bits, little-endian, unsigned) *)
let load_hword memory address =
  let bl = load_byte memory address in
  let bh = load_byte memory (Int32.add address 1l) in
  bl lor (bh lsl 8)
;;
