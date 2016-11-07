--[[
  This is a utility class
  It contains utility functions which are used by other classes
--]]

utl = {}
utl.math = {}
utl.table = {}

----MATH UTILITIES
--rounds an integer up if it is >= .5 otherwise rounds down.
function utl.math.round(num)
	local rnd

	if num-math.floor(num) >=.5 then
		rnd = math.ceil(num)
	else
		rnd = math.floor(num)
	end

	return rnd	
end

--converts a decimal number into a hex number
function utl.math.dec2hex(nValue)
	if type(nValue) == "string" then
		nValue = String.ToNumber(nValue);
	end
	nHexVal = string.format("%X", nValue);  -- %X returns uppercase hex, %x gives lowercase letters
	sHexVal = nHexVal.."";
	return sHexVal;
end

--checks if a number is Not a Number
function utl.math.isNaN(value)
  return value ~= value
end

----TABLE UTILITIES
-- returns random key from a table, optionally you can also specify the type of the value of the key.
function utl.table.getRandomKey(tbl, tblType)
  local keyset = {}
  --print(tblType)
  if tblType == nil then
    -- iterate over whole table to get all keys
    for k in pairs(tbl) do
        table.insert(keyset, k)
        --print (k)
    end
  else
    keyset = utl.table.getAllKeysOfType(tbl, tbltype)
  end
  -- now you can reliably return a random key
  --random_elem = tbl[keyset[math.random(#keyset)]]
  return keyset[math.random(#keyset)]
  --print (random_elem)
end

--returns all keys in a table
function utl.table.getAllKeys(tbl)
  local keyset = {}
  -- iterate over whole table to get all keys
  for k in pairs(tbl) do
      table.insert(keyset, k)
      --print (k)
  end
  return keyset
end

--returns all keys in a table, whose value is of a certian type
function utl.table.getAllKeysOfType(tbl, tbltype)
  local keyset = {}
  for k in pairs(tbl) do
    if type(tbl[k]) == 'table' then
      table.insert(keyset, k)
      --print (type(tbl[k]) .. ":" .. k)
    end
  end
  return keyset
end

--returns a table where all the keys are the previous values and vice-versa
function utl.table.switchKeysAndValues(tbl)
  local t = {}
  for k,v in pairs(tbl) do
    t[v]=k
  end
  return t
end

--finds and returns the first key in a table which matches the given value
function utl.table.getKeyFromValue(tbl, val)
  local key
  --print(val)
  for k,v in pairs(tbl) do
    --print(k .. ": " v)
    if v == val then
      key = k
      break
    end
  end
  return key
end

--returns the index(curPos) plus 1, unless the new value is too large, in which it returns 1
function utl.table.cycleUp(tbl, curPos)
  curPos = curPos + 1
  if curPos > #tbl then curPos = 1 end
  return curPos
end

--returns the index(curPos) minus 1, unless the new value is too small, in which it returns the length of the table
function utl.table.cycleDown(tbl, curPos)
  curPos = curPos - 1
  if curPos < 1 then curPos = #tbl end
  return curPos
end

function utl.table.copy(obj, seen)
  if type(obj) ~= 'table' then return obj end
  if seen and seen[obj] then return seen[obj] end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do res[copy(k, s)] = utl.table.copy(v, s) end
  return res
end


return utl