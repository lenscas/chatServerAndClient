--list of all the colors and check if the given color is in this list
function checkValidColor(needCheck)
	--table with all the avaiable strings for ansii colors
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
	--check if provided color matches one of the strings in the table
	local valid=false
	for key,value in pairs(allColors) do
		if value==needCheck then
			valid=true
		end
	end
	return valid
end
