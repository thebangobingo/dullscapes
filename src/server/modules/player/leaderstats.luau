local Data = require("@shared/data").Server

local function SetupLeaderstats(player: Player)
	local data, _ = Data.WaitForData(player)
	if not data then
		return
	end

	local folder = Instance.new("Folder")
	folder.Name = "leaderstats"
	folder.Parent = player

	local level = Instance.new("IntValue")
	level.Name = "Level"
	level.Parent = folder

	data.Level.Observe(function(value)
		level.Value = value
	end)
end

return {
	SetupLeaderstats = SetupLeaderstats,
}
