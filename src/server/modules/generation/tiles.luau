const InsertService = game:GetService("InsertService")

local Assets = require("@shared/assets")
local Log = require("@shared/log")

export type TileData = { Instance: Model, Connections: { Part }, Zones: { Part } }
export type TileEntry = { Data: TileData, Weight: number }

local function ValidateTileData(assetId: string): TileData
	local asset = InsertService:LoadAsset(assetId)

	if not asset:IsA("Model") then
		Log.error(`{assetId} is not a model`)
	end

	local connections: Folder = asset:FindFirstChild("Connections")
	local zones: Folder = asset:FindFirstChild("Zones")

	if not connections or not zones then
		Log.error(`{assetId} does not include the correct folders`)
	end

	for _, connection in connections:GetChildren() do
		if not connection:IsA("Part") then
			Log.error(`{assetId} includes a connection that is not a Part`)
		end
	end

	for _, zone in zones:GetChildren() do
		if not zone:IsA("Part") then
			Log.error(`{assetId} includes a zone that is not a Part`)
		end
	end

	return {
		Instance = asset,
		Connections = connections:GetChildren(),
		Zones = zones:GetChildren(),
	}
end

const Tiles: { TileEntry } = {
	[1] = {
		Data = ValidateTileData(Assets["models/square"]),
		Weight = 5,
	},
}

return Tiles
