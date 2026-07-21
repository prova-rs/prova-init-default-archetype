local context = Context.new()
local gitignore = require("gitignore")

-- ── Prompts ─────────────────────────────────────────────────────────────
context:prompt_text("Project Name:", "project_name", {
    cases = Cases.programming(),
    help = "The project's canonical name.",
})

gitignore.prompt(context)

-- ── Render ──────────────────────────────────────────────────────────────
directory.render("contents", context)

-- ── Finalize ────────────────────────────────────────────────────────────
gitignore.finalize(context)
