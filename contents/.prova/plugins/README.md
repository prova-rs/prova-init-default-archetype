# Project plugins

Each top-level directory here is a project-local plugin, discovered automatically — no manifest entry
needed. A proof reaches one with `require("<dir-name>")`.

This scaffold ships one: [`lib/`](lib/), your project's shared library. Add more as your suites grow
(e.g. a `fixtures/` plugin, or a wrapper around a service you drive). To pull in a *published* plugin
instead, declare it under `[plugins]` in the manifest.
