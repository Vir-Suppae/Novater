const std = @import("std");
const rl = @import("raylib");
const rg = @import("raygui");
const cam_utils = @import("camera_utils.zig");
const chunk_utils = @import("chunk.zig");

pub fn main(init: std.process.Init) !void {
    const alloc = init.gpa;
    rl.setConfigFlags(.{ .window_resizable = true });
    rl.initWindow(640, 480, "Novater");
    defer rl.closeWindow();
    rl.setWindowMinSize(480, 360);

    var cam = cam_utils.makeWorldCam();

    var map = std.AutoHashMap(u64, chunk_utils.Chunk).init(alloc);
    defer map.deinit();

    std.log.info("key of 2_107_231_143, -1_388_289_902: {}", .{chunk_utils.chunkCoordsToKey(2_107_231_143, -1_388_289_902)});
    std.log.info("chunk coords of 12484084349359737767: {any}", .{chunk_utils.keyToChunkCoords(12484084349359737767)});

    while (!rl.windowShouldClose()) {
        cam_utils.adjustCam(&cam);
        rl.beginDrawing();
        defer rl.endDrawing();

        cam.begin();
        defer cam.end();

        rl.clearBackground(.sky_blue);

        rl.drawRectangle(10, 10, 10, 10, .black);
    }
}
