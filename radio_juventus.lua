socket = require 'socket.http'
ltn12 = require 'ltn12'
url = require 'socket.url'
iconv = require 'iconv'

r = {}

socket.request{ 
	url = 'http://juventus.hu/show_it.php' ,
	sink =  ltn12.sink.table(r),
	headers = { ["Cookie"] = 'PHPSESSID=0d9420c14e194c9b8ac327e7f338f8df' }
}


response = table.concat(r)
-- print(response)	



function split(s)
	local t={}
	s:gsub("[^&]+", function (word) 
		local kv={}
		word:gsub("[^=]+", function(input)
			
			table.insert(kv, input)
			end
		)
		key = kv[1]
		value = kv[2] or "" 
		
		t[key] = value
	end )
	return t
end

coll = split(response)

if dbg then
	for k,v in pairs(coll) do
	print(k,v)
	end
end
function latin2_to_utf8(input)

	return iconv.new("UTF8", "latin2"):iconv(input)
end

print((coll["artist"].." - "..coll["title"]))

