--load all the needed modules
colors = require 'ansicolors'
socket = require("socket")
lfs = require"lfs"

--load other pieces code for the client
clientStart=assert(loadfile("otherCode/startClient.lua"))
clientStart()
runCommands=assert(loadfile("otherCode/runCommands.lua"))
runCommands()
--code to load all commands
for file in lfs.dir("commands") do
	debug(file)
	if file ~=".." and file ~= "." then
		command=assert(loadfile("commands/"..file))
		command()
	end
end

--load the last piece of code and let the client send and recieve messages
send=assert(loadfile("otherCode/messages.lua"))
send()

