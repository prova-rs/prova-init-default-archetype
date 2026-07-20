-- The project's shared library plugin. Anything reused across proof suites — helpers, shared
-- fixtures, topologies — lives here, and `require("lib")` reaches it from any proof. This starter
-- shows both shapes; grow it into your project's real shared surface (and rename it if you like:
-- the directory name under .prova/plugins/ is the require() name).

local lib = {}

--- A pure helper — the smallest thing that proves the shared plugin is wired.
---@param name string
---@return string
function lib.greeting(name)
	return "hello, " .. name
end

--- A shared fixture: define it once here, reuse it from any suite via `t:use(lib.counter)`. Fixtures
--- are lazy and scoped, so this costs nothing until a test asks for it.
lib.counter = prova.fixture("lib.counter", Scope.Test, function(ctx)
	local n = { value = 0 }
	ctx:defer(function()
		n.value = nil
	end) -- teardown, LIFO within the scope
	return n
end)

return lib
