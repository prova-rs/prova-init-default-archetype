-- The proof that `prova init default` produces a *working* prova project — not just files on disk,
-- but a project whose own proof suite runs green, with the shared `lib` plugin wired and the `soak`
-- capability actually gating a test. Black-box throughout: render into a tempdir, then drive the
-- rendered project's `prova` and read its report. No white-box peeking at the archetype internals.
--
-- The nested run uses `$PROVA_BIN` if set (so a dev can pin the binary under test), else `prova` on
-- PATH — the version a real user would have installed.

local ARCHETYPE = prova.root -- this repo *is* the archetype under test
local PROVA = os.getenv("PROVA_BIN") or "prova"

-- One render, shared by every check below. The archetype is promptless — a headless render with no
-- answers is the whole interface, and this proof holds it to that.
local rendered = prova.fixture("rendered", Scope.File, function(ctx)
	return archetect.render({
		source = ARCHETYPE,
		destination = ctx:tempdir(),
	})
end)

-- Layout + no un-rendered `{{ }}` markers, via the declarative harness on the existing render.
archetect.verify(rendered, {
	name = "prova-init-default",
	expected_files = {
		".prova/prova.toml",
		".prova/config.lua",
		".prova/plugins/lib/init.lua",
		".prova/plugins/lib/prova.toml",
		"proofs/example_test.lua",
		".gitignore",
	},
})

--- Run `prova --format json` in `dir` and return the `run_finished` summary event (or nil).
local function run_suite(dir, env)
	local r = shell.run(PROVA .. " --format json", { cwd = dir, env = env })
	local summary
	for line in r.stdout:gmatch("[^\n]+") do
		local ok, ev = pcall(prova.parse.json, line)
		if ok and type(ev) == "table" and ev.type == "run_finished" then
			summary = ev
		end
	end
	return r, summary
end

prova.describe("the rendered project", function()
	-- The load-bearing proof: the scaffolded suite passes on its own, and the soak gate skips (not
	-- fails) the one capability-gated proof when PROVA_SOAK is absent. That transitively proves the
	-- `lib` plugin loads (the shared-library proof requires it) and that config.lua registered `soak`.
	prova.test("runs green, with the soak proof skipped", function(t)
		local tree = t:use(rendered)
		local r, summary = run_suite(tree.path, nil)
		t:expect(r.code, "prova exited non-zero:\n" .. r.stderr):equals(0)
		t:expect(summary ~= nil, "no run_finished event in prova output"):equals(true)
		t:expect(summary.failed, "the scaffolded suite had failures"):equals(0)
		t:expect(summary.passed >= 2, "expected at least two starter proofs to pass"):equals(true)
		t:expect(summary.skipped, "exactly the soak proof should skip"):equals(1)
	end)

	-- The other half of the gate: with the capability present, the soak proof runs rather than skips.
	prova.test("runs the soak proof when PROVA_SOAK is set", function(t)
		local tree = t:use(rendered)
		local r, summary = run_suite(tree.path, { PROVA_SOAK = "1" })
		t:expect(r.code, "prova exited non-zero:\n" .. r.stderr):equals(0)
		t:expect(summary.skipped, "nothing should skip once soak is available"):equals(0)
		t:expect(summary.failed, "the soak run had failures"):equals(0)
	end)
end)
