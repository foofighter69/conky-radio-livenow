--  Anima Sound System - Tedd a napfényt a számba --
--  Gabriella Cilmi - Heart's don't lie --

-- Event based parsing - eseményalapú beolvasás --
-- http://www.tuxradar.com/practicalphp/12/2/0

-- Doc: http://asbradbury.org/projects/lua-xmlreader/doc/ --

require 'xmlreader'

socket = require 'socket.http'
ltn12 = require 'ltn12'
url = require 'socket.url'
iconv = require 'iconv'

r = {}

USERAGENT = 'Mozilla'

socket.request{ 
	url = 'http://stream1.classfm.hu:9216/index.html',
	sink =  ltn12.sink.table(r),
	headers = {
		["user-agent"] = 'Mozilla clone (for conky)'  
	} 
}

response = table.concat(r)

coll = {}



function latin2_to_utf8(input)

	return iconv.new("UTF8", "latin2"):iconv(input)
end

_,_,  response= response:find("Current Song: </font></td><td><font class=default><b>([^<]+)</b></td>")

print(latin2_to_utf8(response))

--print((coll["artist"].." - "..coll["songtitle"]))

