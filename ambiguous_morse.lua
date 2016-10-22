#!/usr/bin/lua

local copy = function(tab)
	local new_tab = {}

	for _,v in ipairs(tab) do
		table.insert(new_tab, v)
	end

	return new_tab
end

local greedy_take = function(stack, length, max_take)
	local s = stack or {}

	while length > max_take do
		table.insert(s, max_take)
		length = length - max_take
	end
	table.insert(s, length)

	return s
end

local parse = function(signal, spacing)
	local output = {}
	local cursor = 1
	for _,v in ipairs(spacing) do
		table.insert(output, string.sub(signal, cursor, cursor + v - 1))
		cursor = cursor + v
	end

	return output
end

local int_morse = {}

int_morse["._"] = "a"
int_morse["_..."] = "b"
int_morse["_._."] = "c"
int_morse["_.."] = "d"
int_morse["."] = "e"
int_morse[".._."] = "f"
int_morse["__."] = "g"
int_morse["...."] = "h"
int_morse[".."] = "i"
int_morse[".___"] = "j"
int_morse["_._"] = "k"
int_morse["._.."] = "l"
int_morse["__"] = "m"
int_morse["_."] = "n"
int_morse["___"] = "o"
int_morse[".__."] = "p"
int_morse["__._"] = "q"
int_morse["._."] = "r"
int_morse["..."] = "s"
int_morse["_"] = "t"
int_morse[".._"] = "u"
int_morse["..._"] = "v"
int_morse[".__"] = "w"
int_morse["_.._"] = "x"
int_morse["_.__"] = "y"
int_morse["__.."] = "z"
int_morse["_____"] = "0"
int_morse[".____"] = "1"
int_morse["..___"] = "2"
int_morse["...__"] = "3"
int_morse["...._"] = "4"
int_morse["....."] = "5"
int_morse["_...."] = "6"
int_morse["__..."] = "7"
int_morse["___.."] = "8"
int_morse["____."] = "9"
int_morse["._._._"] = "."
int_morse["__..__"] = ","
int_morse["..__.."] = "?"
int_morse[".____."] = "'"
int_morse["_._.__"] = "!"
int_morse["_.._."] = "/"
int_morse["_.__."] = "("
int_morse["_.__._"] = ")"
int_morse["._..."] = "&"
int_morse["___..."] = ":"
int_morse["_._._."] = ";"
int_morse["_..._"] = "="
int_morse["._._."] = "+"
int_morse["_...._"] = "-"
int_morse["..__._"] = "_"
int_morse["._.._."] = "\""
int_morse["..._.._"] = "$"
int_morse[".__._."] = "@"

local signal = arg[1]
local segment_max = tonumber(arg[2])
local stack = greedy_take(_, #signal, segment_max)
local accum = 0
local spacing_list = {}

print(arg[1])
table.insert(spacing_list, copy(stack))

while #stack > 0 do
	local tail = table.remove(stack)
	if tail == 1 then
		accum = accum + 1
	else
		tail = tail - 1
		table.insert(stack, tail)
		accum = accum + 1
		greedy_take(stack, accum, segment_max)
		table.insert(spacing_list, copy(stack))
		accum = 0
	end
end

-- TODO: Set up the morse alphabet hash table

local parse_output = {}

for _,spacing in ipairs(spacing_list) do
	table.insert(parse_output, parse(signal, spacing))
end

local translation = {}

for _,a in ipairs(parse_output) do
	local temp = {}

	for _,b in ipairs(a) do
		if int_morse[b] then
			table.insert(temp, int_morse[b])
		else
			goto br
		end
	end
	table.insert(translation, temp)
	::br::
end

for _,v in ipairs(translation) do
	print(table.concat(v))
	--os.execute("sleep 0.05")
end
print("Output Size: ", #translation)






