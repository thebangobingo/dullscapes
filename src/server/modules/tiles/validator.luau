const AssetService = game:GetService("AssetService")

local Types = require("./types")
local Config = require("./config")
local Log = require("@shared/log")

local TILES_ARE_VALIDATED = false

local function ValidateTile(tileName: string, tileData: Types.TileData): boolean
	local instance = AssetService:LoadAssetAsync(tileData.AssetId):GetChildren()[1]

	if not instance:IsA("Model") then
		Log.warn(`Tile '{tileName}' is not a model.`)
		return false
	end

	local connections = instance:FindFirstChild("Connections")
	local zones = instance:FindFirstChild("Zones")

	print(instance.Name)
	print(instance:GetChildren())

	if not connections then
		Log.warn(`Tile '{tileName}' does not include a holder named 'Connections'.`)
		return false
	end

	if not zones then
		Log.warn(`Tile '{tileName}' does not include a holder named 'Zones'.`)
		return false
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

	return true
end

local function ValidateAllTiles(): boolean
	for tileName, tileData in Config do
		local validated = ValidateTile(tileName, tileData)

		if not validated then
			return false
		end
	end

	TILES_ARE_VALIDATED = true
	return true
end

local function LoadTile(assetId: string): Types.TileModel
	if not TILES_ARE_VALIDATED then
		Log.warn("Tiles should be validated before use. Please confirm 'ValidateAlTiles' is being called and handled properly.")
	end

	return AssetService:LoadAssetAsync(assetId):GetChildren()[1] :: Types.TileModel
end

return {
	ValidateAllTiles = ValidateAllTiles,
	LoadTile = LoadTile,
}
