colors = require 'ansicolors'
--table with commdands and their code

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
commands={
	printColor=
		function(string)
			--set atword to 0 to use later		
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
			if checkValidColor(inColor) then		
				print(colors("%{"..inColor.."}"..sentence))
			else
				print(inColor.." is not a valid color")		
			end
		end,
	help=
		function()
			for key,value in pairs(commands) do
				print(key)
			end
		end	
}
--makes sure program loops forever and ever and ever and ever....
while true do
	--get input from user
	containsCommand=false	
	local input=io.read()
	--go though table of commands
	for key,value in pairs(commands) do
		local start=string.find(input,"/"..key)
			--check if there is an command as the first word
			if start==1 then
				containsCommand=true
				-- if there is command run it 
				input=commands[key](input)
			end
	end
	--if none found just print it
	if not containsCommand then
		print(input)
	end
end
