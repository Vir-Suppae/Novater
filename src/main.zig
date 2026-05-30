const std = @import("std");
const rl = @import("raylib");
const rg = @import("raygui");
const cam_utils = @import("camera_utils.zig");
const chunk_utils = @import("chunk.zig");

const IVec = struct {
    x: i32,
    y: i32,
    pub fn init(x: i32, y: i32) @This() {
        return .{
            .x = x,
            .y = y,
        };
    }
};

pub fn main(init: std.process.Init) !void {
    const alloc = init.gpa;
    rl.setConfigFlags(.{ .window_resizable = true });
    rl.initWindow(640, 480, "Novater");
    defer rl.closeWindow();
    rl.setWindowMinSize(480, 360);

    var cam = cam_utils.makeWorldCam();

    var map = std.AutoHashMap(u64, chunk_utils.Chunk).init(alloc);
    defer map.deinit();

    var cpos: rl.Vector2 = .zero();
    var bpos: rl.Vector2 = .zero();
    var ppos: rl.Vector2 = .zero();

    for (0..255) |cy| {
        for (0..255) |cx| {
            const x: i32 = @intCast(cx);
            const y: i32 = @intCast(cy);
            try map.put(chunk_utils.chunkCoordsToKey(x - 64, y - 64), .init());
        }
    }

    while (!rl.windowShouldClose()) {
        const ft = rl.getFrameTime();
        cam_utils.adjustCam(&cam);
        if (rl.isKeyDown(.w)) {
            ppos.y -= 100 * ft;
        } else if (rl.isKeyDown(.s)) {
            ppos.y += 100 * ft;
        }
        if (rl.isKeyDown(.a)) {
            ppos.x -= 100 * ft;
        } else if (rl.isKeyDown(.d)) {
            ppos.x += 100 * ft;
        }
        bpos.x += @divFloor(ppos.x, 16);
        ppos.x = @mod(ppos.x, 16);
        bpos.y += @divFloor(ppos.y, 16);
        ppos.y = @mod(ppos.y, 16);
        cpos.x += @divFloor(bpos.x, 16);
        bpos.x = @mod(bpos.x, 16);
        cpos.y += @divFloor(bpos.y, 16);
        bpos.y = @mod(bpos.y, 16);
        const wpos = cpos.multiply(.init(256, 256)).add(bpos.multiply(.init(16, 16)).add(ppos));
        cam.target = wpos;
        rl.beginDrawing();
        defer rl.endDrawing();

        cam.begin();
        defer cam.end();

        rl.clearBackground(.sky_blue);
        rl.drawRectangleV(.zero(), .init(32, 32), .black);
        rl.drawRectangleV(wpos, .init(32, 32), .pink);
    }
}

test "check chunk utils" {
    std.log.info("key of 2_107_231_143, -1_388_289_902: {}", .{chunk_utils.chunkCoordsToKey(2_107_231_143, -1_388_289_902)});
    std.log.info("chunk coords of 12484084349359737767: {any}", .{chunk_utils.keyToChunkCoords(12484084349359737767)});
    try std.testing.expectEqual(chunk_utils.chunkCoordsToKey(2_107_231_143, -1_388_289_902), 12484084349359737767);
    try std.testing.expectEqual(chunk_utils.keyToChunkCoords(12484084349359737767), [2]i32{ 2_107_231_143, -1_388_289_902 });
}
