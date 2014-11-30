-- some functios needed to use commands
--table with all the commands and the code for thos commands these are only server side!!
commands={
	--some commands that will be written here are /ban /kick /leave
}


--run server
local socket = require("socket")
local server=socket:tcp()
server:listen(10)
local ip, port = server:getsockname()
print("Please telnet to localhost on port " .. port)
print("After connecting, you have 10s to enter a line to be echoed")
while true do
	-- wait for a connection from any client
	local client = server:accept()
	-- make sure we don't block waiting for this client's line
	client:settimeout(10)
	-- receive the line
	local line, err = client:receive()
	-- if there was no error, send it back to the client
	if not err then 
		for key,value in pairs(commands) do
			local start=string.find(line,"/"..key)
				--check if there is an command as the first word
				if start==1 then
					containsCommand=true
					-- if there is command run it 
					local command,string=commands[key](input)
					client:send("true".." "..command.." "..string.."\n")
				else 
					client:send("false"..line.."\n")
				end

			end
		end
	client:close()
end
