--load needed modules
socket = require("socket")
--after that load all the files that are needed to run the server
serverStart = assert(loadfile("otherCode/startServer.lua"))
serverStart()
runCommands=assert(loadfile("otherCode/runCommands.lua"))
runCommands()
--here wil come the code to load all commands
test=assert(loadfile("commands/test.lua"))
test()
--load the last files
send=assert(loadfile("otherCode/send.lua"))
send()

