const AssetService = game:GetService("AssetService")

local Types = require("./types")
local Config = require("./config")
local Log = require("@shared/log")

local TILES_ARE_VALIDATED = false
local ValidatedTiles: { [Types.TileName]: Types.TileModel } = {}

local function GetValidatedTile(tileName: string, tileData: Types.TileData): Types.TileModel?
	local instance = AssetService:LoadAssetAsync(tileData.AssetId):GetChildren()[1]

	if not instance:IsA("Model") then
		Log.warn(`Tile '{tileName}' is not a model.`)
		return
	end

	local connections = instance:FindFirstChild("Connections")
	local zones = instance:FindFirstChild("Zones")

	if not connections then
		Log.warn(`Tile '{tileName}' does not include a holder named 'Connections'.`)
		return
	end

	if not zones then
		Log.warn(`Tile '{tileName}' does not include a holder named 'Zones'.`)
		return
	end

	for _, connection in connections:GetChildren() do
		if connection:IsA("Part") then
			connection.Transparency = 1
		end
	end

	for _, zone in zones:GetChildren() do
		if zone:IsA("Part") then
			zone.Transparency = 1
		end
	end

	for _, part in instance:GetDescendants() do
		if part:IsA("BasePart") then
			part.CastShadow = false
			part.Anchored = true
		end
	end

	return instance :: Types.TileModel
end

local function ValidateAllTiles(): boolean
	for tileName, tileData in Config do
		local validatedTile = GetValidatedTile(tileName, tileData)

		if not validatedTile then
			return false
		end

		ValidatedTiles[tileName] = validatedTile
	end

	TILES_ARE_VALIDATED = true
	return true
end

local function LoadTile(name: Types.TileName): Types.TileModel?
	if not TILES_ARE_VALIDATED then
		Log.warn("Tiles should be validated before use. Please confirm 'ValidateAlTiles' is being called and no errors exist.")
		return
	end

	return ValidatedTiles[name]
end

return {
	ValidateAllTiles = ValidateAllTiles,
	LoadTile = LoadTile,
}
