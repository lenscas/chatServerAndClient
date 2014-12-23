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
		--checks if there is a command
		local hasCommand,command,input=checkForCommand(line)
		if hasCommand then
			--run command
			local sendOutputTo,outPut=command(input)
			-- check to see where the output neets to go
			if sendOutputTo=="all" then
				--code to send it to all clients here
			elseif sendOutputTo=="sender" then
				client:send(outPut.."\n")
			elseif sendOutputTo=="nobody" then
				--just here to create error messages may find other uses tho
			else
				console(2,"sendOutputTo has false values use sender all or nobody instead")
			end
		else
			--if there is no command just send the plain text 
			--note that if it is a client side command and it got send to the server the client will recieve the command 
			client:send(line.."\n")
		end
	end
	--close connection needs to be removed later
	client:close()
end
