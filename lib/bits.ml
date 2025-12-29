(** Set a specific bit to 1. *)
let set_bit word position = Int32.logor word (Int32.shift_left 1l position)

(** Clear a specific bit to 0. *)
let clr_bit word position =
  Int32.logand word (Int32.lognot (Int32.shift_left 1l position))
;;

(** Test if a specific bit is set (1).
    Bit positions are 0-indexed from the right. *)
let is_bit_set word position =
  Int32.logand (Int32.shift_right_logical word position) 1l = 1l
;;

(** Test if a specific bit is cleared (0).
    Bit positions are 0-indexed from the right. *)
let is_bit_clr word position = not (is_bit_set word position)

(** Zero-extend: keep only the lower [bits], clear upper bits to zero.
    Examples:
    - zero_extend 0xFFFF_FFFFl ~bits:8  -> 0x0000_00FFl
    - zero_extend 0xABCD_1234l ~bits:16 -> 0x0000_1234l
    l is just a symbol indicating this is an `int32` not an `int` *)
let zero_extend value ~bits =
  let mask = Int32.pred (Int32.shift_left 1l bits) in
  Int32.logand value mask
;;

(** Sign-extend: treat the lower [bits] as a signed value,
    extending the sign bit to fill upper bits.
    Examples:
    - sign_extend 0x0000_007Fl ~bits:8  -> 0x0000_007Fl  (positive, upper bits filled with 0)
    - sign_extend 0x0000_0080l ~bits:8  -> 0xFFFF_FF80l  (negative, upper bits filled with 1)
    - sign_extend 0x0000_7FFFl ~bits:16 -> 0x0000_7FFFl  (positive)
    - sign_extend 0x0000_8000l ~bits:16 -> 0xFFFF_8000l  (negative) *)
let sign_extend value ~bits =
  let shift = 32 - bits in
  Int32.shift_right (Int32.shift_left value shift) shift
;;

(** Extract bits [hi:lo] from a word (inclusive).
    Example: extract_bits 0xDEADBEEFl ~hi:15 ~lo:8 returns 0xBEl

    How it works:
      1. Shift right by 'lo' to move target bits to position 0
      2. Create a mask of (hi - lo + 1) ones
      3. AND with mask to keep only the bits we want *)
let extract_bits w ~hi ~lo =
  let width = hi - lo + 1 in
  let mask = Int32.pred (Int32.shift_left 1l width) in
  Int32.logand (Int32.shift_right_logical w lo) mask
;;
