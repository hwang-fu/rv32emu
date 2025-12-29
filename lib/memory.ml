(** Memory type: a contiguous block of bytes *)
type t =
  { data : bytes
  ; size : int
  }

(** Create memory of given size (in bytes), initialized to zero *)
let create ~size = { data = Bytes.make size '\x00'; size }

let is_within_bounds memory address =
  let addr_start = Int32.to_int address in
  if addr_start < 0 || addr_start >= memory.size
  then failwith (Printf.sprintf "Memory access out of bounds: 0x%08lx" address)
;;
