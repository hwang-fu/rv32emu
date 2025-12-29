(** Memory type: a contiguous block of bytes *)
type t =
  { data : bytes
  ; size : int
  }

(** Create memory of given size (in bytes), initialized to zero *)
let create ~size = { data = Bytes.make size '\x00'; size }
