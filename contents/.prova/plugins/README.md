# Project plugins

Each top-level directory here is a project-local plugin. They're discovered because the manifest
declares this directory as the plugin root (`plugin_root = ".prova/plugins"` in `.prova.toml`) — a
proof then reaches one with `require("<dir-name>")`, no per-plugin entry needed.

This scaffold ships one: [`lib/`](lib/), your project's shared library. Add more as your suites grow
(e.g. a `fixtures/` plugin, or a wrapper around a service you drive). To pull in a *published* plugin
instead, declare it under `[plugins]` in the manifest (a local path or a pinned git source).
