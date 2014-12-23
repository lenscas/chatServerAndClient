local function testClient(when,text)
	print("test worked")
	debug("text "..text.." when "..when)
	return false,text
end
loadCommand("testC","testClient",testClient)
