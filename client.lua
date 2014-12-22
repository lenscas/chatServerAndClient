colors = require 'ansicolors'
--if true then print text (just for debugging)
function debug(string)
	local isOn=false
	if isOn then
		print(string)
	end
end
--list of all the colors and check if the given color is in this list
function checkValidColor(needCheck)
	local allColors={
		"black",
		"red",
		"green",
		"yellow",
		"blue",
		"magenta",
		"cyan",
		"white",
		"blackbg",
		"redbg",
		"greenbg",
		"yellowbg",
		"bluebg",
		"magentabg",
		"cyanbg",
		"whitebg"
	}
	local valid=false
	for key,value in pairs(allColors) do
		if value==needCheck then
			valid=true
		end
	end
	return valid
end
-- these commands are CLIENT SIDE ONLY!! for server side commands edit server code
commands={
	--used if you want to print text in color use /printColor {your color} {your text}
	printColor=
		function(when,string)
			--set atword to 0 to use later
			local canSend=false
			local atword=0
			local sentence=nill
			local inColor=nill
			--go over string and get the desired color
			for word in string.gmatch(string, "%a+") do
				--tracks at wich word we are currently
				atword=atword+1
				--second word has te color the text needs to be in
				if atword==2 then
					inColor=word
				--needed to prevent an extra space at start of the senetence
				elseif atword==3 then
					sentence=word

				--take earlyer words and current word and stick them together
				elseif atword>3 then
					sentence=sentence.." "..word
				end
			end
			--print the current sentence in desired color
			local valid=checkValidColor(inColor)
			if valid==true and when=="got" then
				print(colors("%{"..inColor.."}"..sentence))
			elseif valid==true and when=="send" then
				canSend=true
			elseif valid==false and when==send then
				print("the color "..inColor.." is not a valid color your message is has not been send to the server")
			end
			if canSend then
				return canSend,string
			end
		end,
	--prints all the client side commands use /help need to edit so that it also checks the server for commands
	help=
		function()
			for key,value in pairs(commands) do
				print(key)
			end
		end
}
local function separateCommandAndText(string)
			local atword=0
			local sentence=nill
			local command=nill
	for word in string.gmatch(string, "%a+") do
		--tracks at wich word we are currently
		atword=atword+1
		--second word has te command that needs to be runned
		if atword==1 then
			command=word
		--needed to prevent an extra space at start of the senetence
		elseif atword==2 then
			sentence=word

		--take earlier words and current word and stick them together
		elseif atword>2 then
			sentence=sentence.." "..word
		end
	end
	return command,sentence
end
--connect to the server and set some variables that will be needed
function start()
	print("what is the server ip?")
	local host=io.read()
	print("what is the server port?")
	local port=io.read()
	socket = require("socket")
	tcp = assert(socket.tcp())
	tcp:connect(host, port);
end
function checkForCommand(text)
	local hasCommand=false
	local command=nil
	local start=string.find(text,"/")
	debug(start)
	--check if there is an command as the first word
	if start==1 then
		local firstWord=nil
		local times=0
		for words in string.gmatch(text, "%a+") do
			times=times+1
			if times==1 thenlo
				debug(words)
				firstWord=words
				debug(firstWord)
			end
		end
		debug(firstWord)
		for key,value in pairs(commands) do
			if firstWord==key then
				hasCommand=true
				Command=value
			end
		end
	end
	if hasCommand then
		return hasCommand,command
	else
		return HasCommand
	end
end

--start up and send messages
while true do
	start()
	debug("test")
	local input=io.read()
	--check if input has an command and if it needs to be send to the server
	local hasCommand,command=nil
	hasCommand,command=checkForCommand(input)
	local canSend=true
	if hasCommand==true then
		debug(hasComand)
		debug(command)
		local otherStuff=nil
		debug(command)
		local canSend,otherStuff=commands[command]("send",input)
	end
	debug(canSend)
	if canSend then
		tcp:send(input.."\n");
	end
	while true do
		local s, status, partial = tcp:receive()
		local message=nil
		if s then
			message=s
			hasCommand,Command=checkForCommand(s)
		elseif partial then
			message=partial
			hasCommand,Command=checkForCommand(partial)
		elseif status == "closed" then
			break
		end
		if hasCommand then
			canSend,otherStuff=commands[command]("got",message)
		end
	end
	tcp:close()
end
