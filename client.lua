colors = require 'ansicolors'
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
			local canSend==false			
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
				return string
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
function checkForCommand(string)
	local hasCommand=true
	local command=nil
	local start=string.find(line,"/"..key)
	--check if there is an command as the first word
	if start==1 then		
		firstWord=string.gmatch(string, "%a+")
		for key,value in pairs(commands) do
			if FirstWord==value then
				hasCommand==false
				Command==value
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
	local input==io.read()
	tcp:send(io.read().."\n");
	--check if input has an command and if it needs to be send to the server
	while true do
		local noCommand=false
		local s, status, partial = tcp:receive()
		if s then		
			if string.gmatch(s, "%a+")=="true" then
				local command,string=separateCommandAndText(s)
			end
		elseif partial then		
			if string.gmatch(partial, "%a+") then
				local command,string=separateCommandAndText(partial)
			end
		else 
			local noCommand=true
		end
		if noCommand=="false" then
			commands[command](string)
		else
			print(s or partial)
		end
		if status == "closed" then break end
	end
	tcp:close()
end
