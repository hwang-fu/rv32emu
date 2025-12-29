(** Set a specific bit to 1. *)
let set_bit word position = Int32.logor word (Int32.shift_left 1l position)

(** Clear a specific bit to 0. *)
let clr_bit word position =
  Int32.logand word (Int32.lognot (Int32.shift_left 1l position))
;;
