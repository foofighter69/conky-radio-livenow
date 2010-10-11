require "curl"
require "iconv"

function write_callback(t)
	return function(s, len)
		table.insert(t,s)
		return len, nil

	end
end
-- BEGIN http://tassi.web.cs.unibo.it/lua/curl_lua_luadoc.html --


response_t = {}

c = curl.easy_init()
c:setopt(curl.OPT_URL, "http://stream001.radio.hu/xml/mr2.php")
c:setopt(curl.OPT_COOKIE, "WACIDX=efwkopEWFWFWsdwQ")
c:setopt(curl.OPT_WRITEFUNCTION, write_callback(response_t))

c:perform()



-- END --

-- BEGIN from: http://www.lua.org/pil/20.3.html --
function unescape (s)
	s = string.gsub(s, "+", " ")
	s = string.gsub(s, "%%(%x%x)", function (h)
			return string.char(tonumber(h, 16))
	end)
	return s
end
-- END --

resp = response_t[1]


--[[ From: latin2 to utf-8 ----
Example in lua-iconv README or
http://code.google.com/p/scite-ru/source/browse/trunk/lualib/lua-iconv/README?spec=svn854&r=854
--]]

-- Tesztek BEGIN --

test = false

if test == true then

resp = "Corrine+Bailey+Rae+-+I%27d+Like+To"
resp = "mcim=MR2-Pet%F5fi+R%E1di%F3+%96+Nagyon+zene"

end
-- Tesztek END --

if resp~=nil then

	resp = string.gsub(resp, "^mcim=", "")
	resp = unescape(resp)
	cd = iconv.new("UTF8", "latin2")
	resp = cd:iconv(resp)

else
	
	resp="<<< MR2 site is unreachable >>>"

end	

print(resp)



