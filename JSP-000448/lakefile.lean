import Lake
open Lake DSL

package "jsp000448" where
  version := v!"0.1.0"

require "mathlib" from git
  "https://github.com/leanprover-community/mathlib4.git" @ "44ba35c6daa9d69aff8fed9fff9bbde17ded774d"

@[default_target]
lean_lib «Erdos548_192usd_21h» where

@[default_target]
lean_lib «JSP000448» where
