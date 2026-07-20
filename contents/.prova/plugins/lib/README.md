# `lib` — the project's shared library plugin

Shared code for your proof suites: helpers, fixtures, and topologies that more than one suite needs.
`require("lib")` reaches it from any proof (the directory name here is the `require()` name).

- `init.lua` — the module. `lib.greeting(name)` is a starter helper; `lib.counter` is a starter
  shared fixture (`t:use(lib.counter)`). Replace them with your own.
- `prova-plugin.toml` — the plugin manifest; declare private dependencies under `[plugins]`.

A multi-file library can `require("lib.<sub>")` its own siblings placed next to `init.lua`.
