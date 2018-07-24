local P = {}


local Str = ""
local function TableToXML_(Tab, Key2, Depth, Attributes2)
	for Key, Value in pairs(Tab) do
		if type(Key) == "string" and type(Value) == "table" then
			if Key ~= "_attr" then
				if Value[1] then
					local Attributes = ""
					
					if Value._attr then
						Attributes = " "
						for Key, Value in pairs(Value._attr) do
							Attributes = Attributes .. tostring(Key) .. "=\"" .. tostring(Value) .. "\" "
						end
					end
					
					Attributes = Attributes:sub(1, #Attributes - 1)
					
					TableToXML_(Value, Key, Depth, Attributes)
				else
					local Attributes = ""
					
					if Value._attr then
						Attributes = " "
						for Key, Value in pairs(Value._attr) do
							Attributes = Attributes .. tostring(Key) .. "=\"" .. tostring(Value) .. "\" "
						end
					end
					
					Attributes = Attributes:sub(1, #Attributes - 1)
					
					if Attributes:match("xsi:nil=\"true\"") then
						Str = Str .. string.rep("\t", Depth) .. "<" .. tostring(Key) .. Attributes .. " />\n"
					else
						Str = Str .. string.rep("\t", Depth) .. "<" .. tostring(Key) .. Attributes .. ">\n"
					end
					
					TableToXML_(Value, Key, Depth + 1, Attributes)
					
					if not Attributes:match("xsi:nil=\"true\"") then
						Str = Str .. string.rep("\t", Depth) ..  "</" .. tostring(Key) .. ">\n"
					end
				end
			end
		elseif type(Key) == "number" and type(Value) == "table" then
			local Attributes = ""
				
			if Value._attr then
				Attributes = " "
				for Key, Value in pairs(Value._attr) do
					Attributes = Attributes .. tostring(Key) .. "=\"" .. tostring(Value) .. "\" "
				end
			end
			
			Attributes = Attributes:sub(1, #Attributes - 1)
			if Attributes:match("xsi:nil=\"true\"") then
				Str = Str .. string.rep("\t", Depth) ..  "<" .. tostring(Key2) .. Attributes .. " />\n"
			else
				Str = Str .. string.rep("\t", Depth) ..  "<" .. tostring(Key2) .. Attributes .. ">\n"
			end
			
			TableToXML_(Value, Key, Depth + 1, Attributes)
			if not Attributes:match("xsi:nil=\"true\"") then
				Str = Str .. string.rep("\t", Depth) ..  "</" .. tostring(Key2) .. ">\n"
			end
		
		elseif type(Key) == "string" then
			Str = Str .. string.rep("\t", Depth) ..  "<" .. tostring(Key) .. ">" .. tostring(Value) .. "</" .. tostring(Key) .. ">\n"
		else
			Attributes2 = Attributes2 or ""
			Str = Str .. string.rep("\t", Depth) ..  "<" .. tostring(Key2) .. Attributes2 .. ">" .. tostring(Value) .. "</" .. tostring(Key2) .. ">\n"
		end
	end
end 

function P.TableToXML(Tab)
	Str = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
	
	TableToXML_(Tab, "", 0)
	
	return Str
end

return P