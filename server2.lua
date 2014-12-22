-- some server spefific functions
console= function(level,text)
	local printLevel=3
	if printLevel>=level then
		print(text)
	end
end
-- some functions needed to use commands
function checkForCommand(text)
	local hasCommand=false
	local command=nil
	local start=string.find(text,"/")
	local firstWord=nil
	local times=0
	console(3,start)
	--check if there is an command as the first word
	if start==1 then
		for words in string.gmatch(text, "%a+") do
			times=times+1
			if times==1 then
				console(3,words)
				firstWord=words
				console(3,firstWord)
			end
		end
		console(3,firstWord)
		for key,value in pairs(commands) do
			if firstWord==key then
				hasCommand=true
				console(3,value)
				command=value
			end
		end
	end
	if hasCommand then
		return hasCommand,command
	else
		return HasCommand
	end
end

--table with all the commands and the code for thos commands these are ONLY SERVER SIDE!!
commands={}
function commands.test()
	print("lolz")
	return "sender","test"
end
function commands.test2()
	print("test2")
	console(3,"ja")
	return "sender","test2"
end
--some commands that will be written here are /ban /kick /leave

--prepare server
local socket = require("socket")
local server=socket:tcp()
server:listen(10)
local server = socket.bind('*',51423)
local ip, port = server:getsockname()
print("Please telnet to localhost on port " .. port)
print("After connecting, you have 10s to enter a line to be echoed")
--run server
while true do
	-- wait for a connection from any client
	local client = server:accept()
	-- make sure we don't block waiting for this client's line
	client:settimeout(10)
	-- receive the line
	local line, err = client:receive()
	-- if there was no error, send it back to the client
	if not err then
		console(3,line)
		--check if there is an command as the first word
		local hasCommand,command=checkForCommand(line)
		if hasCommand then
			console(3,command)
			local sendOutputTo,outPut=command(input)
			if sendOutputTo=="all" then
				--code to send it to all clients here
			elseif sendOutputTo=="sender" then
				client:send(outPut.."\n")
			elseif sendOutputTo=="nobody" then
				--just here to create error messages may find other uses to
			else
				console(2,"sendOutputTo has false values use sender all or nobody instead")
			end
		else
			client:send(line.."/n")
		end
	end
	client:close()
end
