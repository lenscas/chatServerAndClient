--declare table with all the commands
commands={}
-- some functions needed to use commands
function checkForCommand(text)
	--set all variables to local that this function will need also give them the correct value if it is possible	
	local hasCommand=false
	local command=nil
	local start=string.find(text,"/")
	local firstWord=nil
	local times=0
	local sentence=""
	debug(start)
	--check if there is an command as the first word
	if start==1 then
		for words in string.gmatch(text, "%a+") do
			times=times+1
			--if there is remake the text so that the first word is split from the rest of the sentence
			if times==1 then
				debug(words)
				firstWord=words
				debug(firstWord)
			else 
				sentence=sentence.." "..words
			end
		end
		debug(firstWord)
		--check if the first word is a command
		for key,value in pairs(commands) do
			if firstWord==key then
				hasCommand=true
				debug(value)
				command=value
			end
		end
	end
	if hasCommand then
		return hasCommand,command
	else
		return hasCommand
	end
end
--use this if you want to load a command not finnished
function loadCommand(useName,realName,code)
	--first check if useName is already in use
	local duplicate=false
	for key,value in pairs(commands) do
		debug(key)
		if useName==key then
			duplicate=true
			break
		end
	end
	--if there is then check if realName is already in use and let the user know
	if duplicate then
		
		print("there is a duplication in the commands")
		duplicate=false
		for key,value in pairs(commands) do
			if key==realName then
				duplicate=true
				break
			end
		end
		if duplicate==false then
			--insert the new command either with realName if useName is already in use and give warning
			print(useName.." is already in use will use "..realName)
			commands[realName]=code
		else
			--give warning that the realName is also already in use and that because of it it will not get loaded
			print(useName.." and "..realName.." are already in use wil not load "..useName)
		end
	else
		--if there where no duplicates don't give warnings and load the command
		commands[useName]=code
	end
end
