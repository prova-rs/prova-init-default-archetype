-- A capability rather than a tag because this is what capabilities already mean: `requires` skips
-- gracefully where something is unavailable, which is the wanted behaviour, and needs no new
-- selection flags at the call site.
runtime.capability("soak", function()
	return os.getenv("PROVA_SOAK") ~= nil
end)
