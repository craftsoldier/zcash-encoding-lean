import Lake
open Lake DSL

package «zcashEncoding» where
  leanOptions := #[
    ⟨`autoImplicit, false⟩,
    ⟨`relaxedAutoImplicit, false⟩
  ]

@[default_target] lean_lib «ZcashEncoding» {}
