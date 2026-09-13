const Players = game:GetService("Players")

local Leaderstats = require("@server/modules/player/leaderstats")
local Log = require("@shared/log")

local Tiles = require("@server/modules/tiles")
local Generation = require("@server/modules/generation")

local function OnPlayerAdded(player: Player)
	Leaderstats.SetupLeaderstats(player)
end

local function OnStart()
	local validated = Tiles.Validator.ValidateAllTiles()

	if not validated then
		Log.warn("Game cannot run unless tiles are validated")
		return
	end

	Generation.Map.InitializeMap()
end

local function Init()
	for _, player in Players:GetPlayers() do
		OnPlayerAdded(player)
	end

	Players.PlayerAdded:Connect(OnPlayerAdded)

	OnStart()
end

Init()
