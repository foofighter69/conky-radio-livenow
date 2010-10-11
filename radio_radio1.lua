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

socket.request{ 
	url = 'http://www.radio1.hu/mosthallhatoNew.xml' ,
	sink =  ltn12.sink.table(r)
}

response = table.concat(r)

local r = xmlreader.from_string(response)
coll = {}

function artist(r, coll)

	
	name = r:name()
	r:read()
	-- print(r:value())
	coll[name] = r:value()
end

function songtitle(r, coll)

	name = r:name()
	r:read()
	-- print(r:value())
	coll[name] = r:value()
end

callback_table = {
	artistelement = artist,
	songtitleelement = songtitle
}

function parse_xml_rec(reader)
	
	if reader:read() then
	
		cb = callback_table[reader:name()..reader:node_type()]
		if cb then cb(reader, coll) end
		
		parse_xml_rec(reader) 
		end	


end


parse_xml_rec(r)

function latin2_to_utf8(input)

	return iconv.new("UTF8", "latin2"):iconv(input)
end

print((coll["artist"].." - "..coll["songtitle"]))

