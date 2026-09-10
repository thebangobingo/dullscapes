local Scribe = require("@packages/scribe")

local function levelForXp(xp: number): number
	return xp // 100
end

local template = {
	Coins = Scribe.Int(0, { Min = 0 }),
	Xp = Scribe.Int(0, { Min = 0 }),
	Level = Scribe.Derived(Scribe.Int(0), { "Xp" }, levelForXp),
}

local server = {
	Stage = Scribe.Int(1),
}

return Scribe.new({
	Template = template,
	ProfileStoreIndex = "PlayerData",
	ProfileKeyPrefix = "Player_",
	ServerStore = server,
	Mode = "Mock",
})
