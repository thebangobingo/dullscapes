export type TileName = "Square"
export type TileData = { AssetId: number }
export type TileConfig = { [TileName]: TileData }
export type TileId = number

export type ConnectionId = number
export type Connection = { TileId: number, Cf: CFrame, Pair: ConnectionId? }

export type ZoneId = number
export type Zone = { TileId: TileId, Cf: CFrame }

export type TileModel = Model & { Connections: Folder, Zones: Folder }

export type PlacedTile = {
	Instance: TileModel,
	Connections: { ConnectionId },
	Zones: { ZoneId },
}

return "Types"
