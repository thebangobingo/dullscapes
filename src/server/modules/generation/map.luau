local Types = require("@server/modules/tiles/types")
local TileValidator = require("@server/modules/tiles/validator")
local TileConfig = require("@server/modules/tiles/config")

local _Tiles: { [Types.TileId]: Types.PlacedTile } = {}
local _Connections: { [Types.ConnectionId]: Types.Connection } = {}
local _Zones: { [Types.ZoneId]: Types.Zone } = {}
local _Endpoints: { Types.ConnectionId } = {}

local function GenerateTile(name: Types.TileName, connectedTo: Types.ConnectionId?)
	local model = TileValidator.LoadTile(TileConfig[name].AssetId)

	if not connectedTo then
		model:PivotTo(CFrame.new(Vector3.zero))
	end

	model.Parent = workspace
end

local function InitializeMap()
	GenerateTile("Square")
end

return {
	InitializeMap = InitializeMap,
}
