local Types = require("@server/modules/tiles/types")
local TileValidator = require("@server/modules/tiles/validator")

local Tiles: { [Types.TileId]: Types.PlacedTile } = {}
local Connections: { [Types.ConnectionId]: Types.Connection } = {}
local Zones: { [Types.ZoneId]: Types.Zone } = {}
local Endpoints: { [Types.ConnectionId]: boolean? } = {}

local function CreateZone(tileId: Types.TileId, zonePart: Part): Types.ZoneId
	local zone: Types.Zone = {
		Cf = zonePart.CFrame,
		TileId = tileId,
	}
	local zoneId = #Zones + 1
	Zones[zoneId] = zone

	return zoneId
end

local function CreateConnection(tileId: Types.TileId, connectionPart: Part): Types.ConnectionId
	local connection: Types.Connection = {
		Cf = connectionPart.CFrame,
		TileId = tileId,
		Pair = nil,
	}
	local connectionId = #Connections + 1
	Connections[connectionId] = connection

	return connectionId
end

local function CreateTile(name: Types.TileName, connectedTo: Types.ConnectionId?): Types.TileId
	local model = TileValidator.LoadTile(name)
	local tileId = #Tiles + 1

	local connectionIds: { Types.ConnectionId } = {}
	for _, connectionPart in model.Connections:GetChildren() do
		local connectionId = CreateConnection(tileId, connectionPart)
		table.insert(connectionIds, connectionId)
	end

	if connectedTo then
		local connectedFrom = connectionIds[1]
		Endpoints[connectedTo] = nil

		Connections[connectedTo].Pair = connectedFrom
		Connections[connectedFrom].Pair = connectedTo
	else
		model:PivotTo(CFrame.new(Vector3.zero))
	end

	-- Adds the rest of connections to the endpoints that weren't paired
	for _, connectionId in connectionIds do
		if not Connections[connectionId].Pair then
			Endpoints[connectionId] = true
		end
	end

	local zoneIds: { number } = {}
	for _, zonePart in model.Zones:GetChildren() do
		local zoneId = CreateZone(tileId, zonePart)
		table.insert(zoneIds, zoneId)
	end

	local placedTile: Types.PlacedTile = {
		Instance = model,
		Connections = {},
		Zones = zoneIds,
	}

	Tiles[tileId] = placedTile

	model.Parent = workspace

	return tileId
end

local function InitializeMap()
	CreateTile("Square")
end

return {
	InitializeMap = InitializeMap,
}
