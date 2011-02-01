-------------------------------------------------------------------------------
-- LoveLetter project
-- Handlers for several tags
-------------------------------------------------------------------------------

local luadoc = require "luadoc"
local util = require "luadoc.util"
local string = require "string"
local table = require "table"
local assert, type, tostring = assert, type, tostring
local print, setmetatable = print, setmetatable

module "luadoc.taglet.LoveLetter.tags"

-------------------------------------------------------------------------------
-- Parses a variable entry (function param/ table field)
-- @return : string Variable name
-- @return : string Datatype, or "" if undefined.
-- @return : string Description, or "" if undefined.

local function parse_variable (text, ll_taglet)
	--print("DBG tags.parse_variable() =========================== text:"..text);
	-- Pattern with datatype and description
	local pattern_t_d = "^([_%w%.]+)%s*:%s*([_%w.]+)%s+(.*)%s*"
	-- Pattern with datatype, without description
	local pattern_t   = "^([_%w%.]+)%s*:%s*([_%w.]+)%s*"
	-- Without datatype, with description
	local pattern_d   = "^([_%w%.]+)%s+(.*)%s*"
	-- Without datatype and description
	local pattern_    = "^([_%w%.]+)%s*"

	local desc = ""
	local match, _, name, datatype, desc = string.find(text, pattern_t_d)
	--print("DBG t_d match:"..tostring(match))
	if match == nil then
		match, _, name, datatype = string.find(text, pattern_t)
		--print("DBG t match:"..tostring(match))
		if match == nil then
			match, _, name, desc = string.find(text, pattern_d)
			--print("DBG d match:"..tostring(match))
			if match == nil then
				match, _, name = string.find(text, pattern_)
				--print("DBG _ match:"..tostring(match))
				if match == nil then
					ll_taglet:error("field/attr declaration invalid")
				end
			end
		end
	end

	return name, datatype or "", desc or ""
end

-------------------------------------------------------------------------------

local function author (tag, block, text)
	block[tag] = block[tag] or {}
	if not text then
		luadoc.logger:warn("author `name' not defined [["..text.."]]: skipping")
		return
	end
	table.insert (block[tag], text)
end

-------------------------------------------------------------------------------
-- Set the class of a comment block. Classes can be "module", "function",
-- "table", "class" (object-oriented programming).
-- The first two classes are automatic, extracted from the source code

local function class (tag, block, text)
	block[tag] = text
end

-------------------------------------------------------------------------------

local function copyright (tag, block, text)
	block[tag] = text
end

-------------------------------------------------------------------------------

local function description (tag, block, text)
	block[tag] = text
end

-------------------------------------------------------------------------------

local function field (tag, block, text, ll_taglet)
	if block["class"] ~= "table" then
		luadoc.logger:warn("documenting `field' for block that is not a `table'")
	end
	block["field"] = block["field"] or {}

	local name, datatype, desc = parse_variable(text, ll_taglet);

	table.insert(block["field"], name);
	-- The concat metamethod is for compatibility with standart doclet.
	--print(string.format("DBG tags.field() datatype:%s \ndesc:%s, ", datatype, desc));
	block["field"][name] = setmetatable({
		description = desc,
		datatype = datatype
	}, {
		__concat = function(t)
			return t.desc
		end
	})

end

-------------------------------------------------------------------------------
-- Set the name of the comment block. If the block already has a name, issue
-- an error and do not change the previous value

local function name (tag, block, text)
	if block[tag] and block[tag] ~= text then
		luadoc.logger:error(string.format("block name conflict: `%s' -> `%s'", block[tag], text))
	end

	block[tag] = text
end

-------------------------------------------------------------------------------
-- Processes a parameter documentation.
-- @param tag String with the name of the tag (it must be "param" always).
-- @param block Table with previous information about the block.
-- @param text String with the current line beeing processed.

local function param (tag, block, text, ll_taglet)
	block[tag] = block[tag] or {}
	-- TODO: make this pattern more flexible, accepting empty descriptions
	--local _, _, name, desc = string.find(text, "^([_%w%.]+)%s+(.*)")
	local name, datatype, desc = parse_variable(text, ll_taglet)
	if not name then
		luadoc.logger:warn("parameter `name' not defined [["..text.."]]: skipping")
		return
	end
	local i = table.foreachi(block[tag], function (i, v)
		if v == name then
			return i
		end
	end)
	if i == nil then
		luadoc.logger:warn(string.format("documenting undefined parameter `%s'", name))
		table.insert(block[tag], name)
	end
	-- The concat metamethod is for compatibility with standart doclet.
	block[tag][name] = setmetatable({
		description = desc,
		datatype = datatype
	}, {
		__concat = function(t)
			return t.desc
		end
	})
end

-------------------------------------------------------------------------------

local function release (tag, block, text)
	block[tag] = text
end

-------------------------------------------------------------------------------

local function ret (tag, block, text)
	tag = "ret"
	if type(block[tag]) == "string" then
		block[tag] = { block[tag], text }
	elseif type(block[tag]) == "table" then
		table.insert(block[tag], text)
	else
		block[tag] = text
	end
end

-------------------------------------------------------------------------------
-- @see ret

local function see (tag, block, text)
	-- see is always an array
	block[tag] = block[tag] or {}

	-- remove trailing "."
	text = string.gsub(text, "(.*)%.$", "%1")

	local s = util.split("%s*,%s*", text)

	table.foreachi(s, function (_, v)
		table.insert(block[tag], v)
	end)
end

-------------------------------------------------------------------------------
-- @param block string/table
-- @see ret

local function usage (tag, block, text)
	if type(block[tag]) == "string" then
		block[tag] = { block[tag], text }
	elseif type(block[tag]) == "table" then
		table.insert(block[tag], text)
	else
		block[tag] = text
	end
end

-------------------------------------------------------------------------------

local handlers = {}
handlers["author"] = author
handlers["class"] = class
handlers["type"] = class -- 'type' tag is an alias for 'class'
handlers["copyright"] = copyright
handlers["description"] = description
handlers["field"] = field
handlers["attr"] = field -- 'attr' is an alias of 'field'
handlers["name"] = name
handlers["param"] = param
handlers["release"] = release
handlers["return"] = ret
handlers["see"] = see
handlers["usage"] = usage


-------------------------------------------------------------------------------

function handle (tag, block, text, ll_taglet)
	if tag == "package" then return end
	if not handlers[tag] then
		luadoc.logger:error(string.format("undefined handler for tag `%s'", tag))
		print(string.format("Undefined tag '%s'", tag));
		return
	end
	return handlers[tag](tag, block, text, ll_taglet)
end
