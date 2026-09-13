--!strict

local Types = require("./types")
local Assets = require("@shared/assets")

local function ConvertId(id: string): number
	return tonumber(id:sub(14)) :: number
end

local Config: Types.TileConfig = {
	Square = { AssetId = ConvertId(Assets["models/tiles/square"]) },
}

return Config
