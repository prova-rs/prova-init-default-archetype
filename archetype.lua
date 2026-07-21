local context = Context.new()

-- ── Render ──────────────────────────────────────────────────────────────
-- Promptless by design: the default package is one fixed, full shape — a .prova/ nook (manifest,
-- config, a shared `lib` plugin) plus a starter proofs/ suite. Nothing to ask; just announce.
directory.render("contents", context)

output.print("")
output.print("Prova package created:")
output.print("  .prova/               manifest, runtime config, and the project's plugins")
output.print("  .prova/plugins/lib/   the shared library — require(\"lib\") from any proof")
output.print("  proofs/               starter suite — replace with your own proofs")
output.print("")
output.print("Run `prova` from the project root to execute it.")
