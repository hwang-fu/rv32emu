(** Memory type: a contiguous block of bytes *)
type t =
  { data : bytes
  ; size : int
  }
