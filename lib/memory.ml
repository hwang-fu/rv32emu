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

(** Store half-word (16 bits, little-endian) *)
let store_hword memory address hw =
  store_byte memory address (hw land 0xFF);
  store_byte memory (Int32.add address 1l) ((hw lsr 8) land 0xFF)
;;

(** Load word (32 bits, little-endian) *)
let load_word memory address =
  let b0 = load_byte memory address in
  let b1 = load_byte memory (Int32.add address 1l) in
  let b2 = load_byte memory (Int32.add address 2l) in
  let b3 = load_byte memory (Int32.add address 3l) in
  Int32.logor
    (Int32.logor (Int32.of_int b0) (Int32.shift_left (Int32.of_int b1) 8))
    (Int32.logor
       (Int32.shift_left (Int32.of_int b2) 16)
       (Int32.shift_left (Int32.of_int b3) 24))
;;

(** Store word (32 bits, little-endian) *)
let store_word memory address w =
  let word = Int32.to_int w in
  store_byte memory address (word land 0xFF);
  store_byte memory (Int32.add address 1l) ((word lsr 8) land 0xFF);
  store_byte memory (Int32.add address 2l) ((word lsr 16) land 0xFF);
  store_byte memory (Int32.add address 3l) ((word lsr 24) land 0xFF)
;;
