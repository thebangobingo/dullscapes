const Players = game:GetService("Players")

local Leaderstats = require("@server/modules/player/leaderstats")

local function OnPlayerAdded(player: Player)
	Leaderstats.SetupLeaderstats(player)
end

local function OnStart()
end

local function Init()
	for _, player in Players:GetPlayers() do
		OnPlayerAdded(player)
	end

	Players.PlayerAdded:Connect(OnPlayerAdded)

	OnStart()
end

Init()
