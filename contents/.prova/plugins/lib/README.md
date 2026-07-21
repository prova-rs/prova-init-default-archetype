# `lib` — the project's shared library plugin

Shared code for your proof suites: helpers, fixtures, and topologies that more than one suite needs.
`require("lib")` reaches it from any proof (the directory name here is the `require()` name).

- `init.lua` — the module. `lib.greeting(name)` is a starter helper; `lib.counter` is a starter
  shared fixture (`t:use(lib.counter)`). Replace them with your own.
- `prova.toml` — the plugin's `[plugin]` section (name, and private `[plugins]` deps). It's the same
  manifest a project uses: a plugin is a package, so `lib/` can grow its own `proofs/` to prove
  itself.

A multi-file library can `require("lib.<sub>")` its own siblings placed next to `init.lua`.
