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

(** Zero-extend a value (just mask off upper bits).
    Example: zero_extend 0xFFFFFFFFl ~bits:8 returns 0xFFl *)
let zero_extend word ~bits =
  let mask = Int32.pred (Int32.shift_left 1l bits) in
  Int32.logand word mask
;;
