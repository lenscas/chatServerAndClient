while true do
	--let you connect to a server
	start()
	debug("test")
	--let you make a message
	local input=io.read()
	local hasSend=false
	--check if input has an command and if it needs to be send to the server
	local hasCommand,command=nil
	hasCommand,command=checkForCommand(input)
	local canSend=true
	if hasCommand==true then
		--run the command
		local otherStuff=nil
		canSend,otherStuff=command("send",input)
		debug(canSend)
		--check if there is output that needs to be send to the server
		if canSend then
			debug("has send")
			tcp:send(input.."\n")
			hasSend=true
		end
	--if there is no command just send the message
	debug(hasCommand)
	elseif hasCommand==false then
		debug("has send")
		tcp:send(input.."\n")
		hasSend=true
	end
	--if something was send then wait for response
	if hasSend then
		local connected=true
		while connected do
			--get message and see what it got
			local s, status, partial = tcp:receive()
			local message=nil
			if s then
				message=s
			elseif partial then
				message=partial
			--check if the server closed the connection
			end
			if status == "closed" then
				connected=false
				debug("notConnected")
			end
			--check if we have recieved a command
			local hasCommand,command=nil
			hasCommand,command,input=checkForCommand(message)
			if hasCommand==true then
				--run the command and see check if we have output that need to be shown
				local showOutput,outPut=command("got",input)
				if showOutput then
					--print(outPut)
				end
			-- if there is no command then just show the message
			elseif hasCommand==false then
				print(message)
			end
		end
		--close the connection only runs if the server closed the connection first
		tcp:close()
	end
end
