pub const Chunk = struct {
    tiles: [16][16]u8,
    pub fn init() @This() {
        var c: [16][16]u8 = undefined;
        for (&c) |*row| {
            @memset(row, 0);
        }
        return .{ .tiles = c };
    }
    pub fn setTile(self: *@This(), x: u4, y: u4, tile: u8) void {
        self.tiles[y][x] = tile;
    }
    pub fn getTile(self: *@This(), x: u4, y: u4) u8 {
        return self.tiles[y][x];
    }
};

pub fn chunkCoordsToKey(cx: i32, cy: i32) u64 {
    const x: u32 = @bitCast(cx);
    const y: u32 = @bitCast(cy);
    return @as(u64, @intCast(x)) | (@as(u64, @intCast(y)) << 32);
}

pub fn keyToChunkCoords(key: u64) [2]i32 {
    const cx: u32 = @truncate(key);
    const cy: u32 = @truncate(key >> 32);
    return .{ @bitCast(cx), @bitCast(cy) };
}
