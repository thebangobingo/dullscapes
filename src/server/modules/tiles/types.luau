export type TileName = "Square"
export type TileData = { AssetId: number }
export type TileConfig = { [TileName]: TileData }

export type ConnectionId = number
export type Connection = { TileId: number, Cf: CFrame }

export type ZoneId = number
export type Zone = { TileId: number, Cf: CFrame }

export type TileModel = Model & { Connections: Folder, Zones: Folder }

export type TileId = number
export type PlacedTile = {
	Instance: TileModel,
	Connections: { ConnectionId },
	Zones: { ZoneId },
}

return "Types"
