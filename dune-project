(lang dune 3.20)

(name rv32emu)

(generate_opam_files true)

(package
 (name rv32emu)
 (synopsis "A RISC-V RV32I emulator from scratch")
 (description
  "Educational RISC-V emulator implementing the full RV32I base integer instruction set in OCaml")
 (license MIT))

(formatting
 (enabled_for ocaml))
