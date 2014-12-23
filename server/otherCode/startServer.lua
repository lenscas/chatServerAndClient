-- some server specific functions
--the console function is a function used for debugging and will be used for logging
console= function(level,text)
	--printLevel describes what to show 
	--use 1,2 or 3
	--1 means print output important for normal use
	--2 give code warnings
	--3 used for debug-in
	local printLevel=3
	if printLevel>=level then
		print(text)
	end
end
server=socket:tcp()
server:listen(10)
server = socket.bind('*',51423)
local ip, port = server:getsockname()
--print where to connect to
console(1,"Please telnet to localhost on port " .. port)
--the server right now only sends it back this line will be removed when it really works
console(2,"After connecting, you have 10s to enter a line to be echoed")
