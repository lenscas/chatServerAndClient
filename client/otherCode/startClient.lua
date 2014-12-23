--starup code for the client
--if true then print text (just for debugging)
function debug(text)
	local isOn=true
	if isOn then
		print(text)
	end
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
