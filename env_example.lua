local env = {}

-- imagine this is your Haxe output as a string
local code = [[
Main = {}
function Main.main()
    print("Hello from Haxe!")
end
]]

-- load the code with a custom environment
local f = assert(load(code, "haxe_chunk", "t", env))
f()

-- now all globals from that code are in `env`, not _G
env.Main.main()
