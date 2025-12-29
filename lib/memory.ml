(* lib/memory.ml
   Byte-addressable memory subsystem for the RV32I emulator.
   RISC-V uses little-endian byte ordering. *)

(** Memory type: a contiguous block of bytes *)
type t =
  { data : bytes
  ; size : int
  }

(** Create memory of given size (in bytes), initialized to zero *)
let create ~size = { data = Bytes.make size '\x00'; size }

(** Check if address is within bounds *)
let is_within_bounds mem addr32 =
  let addr = Int32.to_int addr32 in
  if addr < 0 || addr >= mem.size
  then failwith (Printf.sprintf "Memory access out of bounds: 0x%08lx" addr32)
;;

(** Load a single byte (unsigned, 0-255) *)
let load_byte mem addr32 =
  is_within_bounds mem addr32;
  Char.code (Bytes.get mem.data (Int32.to_int addr32))
;;

(** Store a single byte *)
let store_byte mem addr32 b =
  is_within_bounds mem addr32;
  Bytes.set mem.data (Int32.to_int addr32) (Char.chr (b land 0xFF))
;;

(** Load half-word (16 bits, little-endian, unsigned) *)
let load_hword mem addr32 =
  let bl = load_byte mem addr32 in
  let bh = load_byte mem (Int32.add addr32 1l) in
  bl lor (bh lsl 8)
;;

(** Store half-word (16 bits, little-endian) *)
let store_hword mem addr32 hw =
  store_byte mem addr32 (hw land 0xFF);
  store_byte mem (Int32.add addr32 1l) ((hw lsr 8) land 0xFF)
;;

(** Load word (32 bits, little-endian) *)
let load_word mem addr32 =
  let b0 = load_byte mem addr32 in
  let b1 = load_byte mem (Int32.add addr32 1l) in
  let b2 = load_byte mem (Int32.add addr32 2l) in
  let b3 = load_byte mem (Int32.add addr32 3l) in
  Int32.logor
    (Int32.logor (Int32.of_int b0) (Int32.shift_left (Int32.of_int b1) 8))
    (Int32.logor
       (Int32.shift_left (Int32.of_int b2) 16)
       (Int32.shift_left (Int32.of_int b3) 24))
;;

(** Store word (32 bits, little-endian) *)
let store_word mem addr32 w32 =
  let w = Int32.to_int w32 in
  store_byte mem addr32 (w land 0xFF);
  store_byte mem (Int32.add addr32 1l) ((w lsr 8) land 0xFF);
  store_byte mem (Int32.add addr32 2l) ((w lsr 16) land 0xFF);
  store_byte mem (Int32.add addr32 3l) ((w lsr 24) land 0xFF)
;;

(** Load raw bytes into memory starting at address *)
let load_bytes mem addr32 data =
  let addr = Int32.to_int addr32 in
  Bytes.blit data 0 mem.data addr (Bytes.length data)
;;
