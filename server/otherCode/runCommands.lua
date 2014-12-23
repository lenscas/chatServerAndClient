-- some functions needed to use commands
function checkForCommand(text)
	--set all variables to local that this function will need also give them the correct value if it is possible	
	local hasCommand=false
	local command=nil
	local start=string.find(text,"/")
	local firstWord=nil
	local times=0
	local sentence=""
	console(3,start)
	--check if there is an command as the first word
	if start==1 then
		for words in string.gmatch(text, "%a+") do
			times=times+1
			--if there is remake the text so that the first word is split from the rest of the sentence
			if times==1 then
				console(3,words)
				firstWord=words
				console(3,firstWord)
			else
				sentence=sentence.." "..word
			end
		end
		console(3,firstWord)
		--check if the first word is a command
		for key,value in pairs(commands) do
			if firstWord==key then
				hasCommand=true
				console(3,value)
				command=value
			end
		end
	end
	if hasCommand then
		return hasCommand,command,sentence
	else
		return HasCommand
	end
end
commands={}
--use this if you want to load a command not finnished
function loadCommand(useName,realName,code)
	commands[useName]=code
end
