-- Starter proofs — delete them once your own exist; they're here to show the shape of a suite and
-- that the scaffold works end to end. Run `prova` from the project root.

local lib = require("lib") -- the project's shared library plugin (.prova/plugins/lib)

prova.test("the shared library plugin is wired", function(t)
	t:expect(lib.greeting("prova")):equals("hello, prova")
end)

prova.test("shared fixtures come from the library", function(t)
	-- `lib.counter` is defined once in the library and reused here.
	t:expect(t:use(lib.counter).value):equals(0)
end)

-- A capability-gated proof. `soak` is registered in .prova/config.lua and is present only when
-- PROVA_SOAK is set, so this skips gracefully in a normal run and executes under `PROVA_SOAK=1` —
-- no new flags at the call site, just `requires`.
prova.test("soak: the suite holds up under an extended run", { requires = { "soak" } }, function(t)
	t:expect(1 + 1):equals(2)
end)
