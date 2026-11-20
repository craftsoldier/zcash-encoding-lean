/-!
# CompactSize format

CompactSize: the byte format Zcash uses to write a number, usually a count or a length.
`protocol.tex` uses it without defining it; source: ZIP 204 (Draft).
-/

namespace ZcashEncoding.CompactSize

/-- Why decoding a CompactSize failed. Not stated in the specification: the two kinds every
node-side implementation (librustzcash, Zebra, Zakura) distinguishes.

No claim is made about the input left after an error, since `zcash_encoding`'s `std` and
`no_std` builds differ. -/
inductive DecodeError where
  /-- The input ended mid-number, as in `[253, 44]`. -/
  | truncated
  /-- Complete but not allowed: non-canonical (more bytes than needed, as in `[253, 5, 0]` for
  `5`), or above the reader's limit (`0x02000000` for `zcash_encoding` 0.5.1's
  `CompactSize::read`). -/
  | invalid
  deriving Repr

/-- `n` is written as the single byte `n` exactly when `n < 253`; `253`–`255` mark longer forms. -/
def fitsInOneByte (n : Nat) : Bool := n < 253

example : fitsInOneByte 0 = true := rfl
example : fitsInOneByte 252 = true := rfl
example : fitsInOneByte 253 = false := rfl
example : fitsInOneByte 255 = false := rfl

end ZcashEncoding.CompactSize
