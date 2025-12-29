(** Set a specific bit to 1. *)
let set_bit word position = Int32.logor word (Int32.shift_left 1l position)
