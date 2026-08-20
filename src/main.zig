const std = @import("std");
const rl = @import("raylib");
const rg = @import("raygui");
const cam_utils = @import("camera_utils.zig");
// const chunk_utils = @import("chunk.zig");
const Player = @import("player.zig").Player;

const GameState = struct {
    player: Player,
    pub fn update(this: *@This()) void {
        this.player.update();
    }
};

pub fn main(_: std.process.Init) !void {
    // const alloc = init.gpa;

    // Raylib setip
    rl.setConfigFlags(.{ .window_resizable = true });
    rl.initWindow(640, 480, "Novater");
    defer rl.closeWindow();
    rl.setWindowMinSize(480, 360);
    rl.setTargetFPS(30);

    var game_state = GameState{
        .player = Player.init(
            .init(0, 0),
            cam_utils.makeWorldCam(),
        ),
    };

    while (!rl.windowShouldClose()) {
        // const ft = rl.getFrameTime();

        game_state.update();

        rl.beginDrawing();
        defer rl.endDrawing();

        game_state.player.cam.begin();
        defer game_state.player.cam.end();

        rl.clearBackground(.sky_blue);

        rl.drawRectangleV(.zero(), .init(32, 32), .black);
        rl.drawRectangleV(game_state.player.pos, .init(32, 32), .pink);
    }
}

// test "check chunk utils" {
//     try std.testing.expectEqual(chunk_utils.chunkCoordsToKey(2_107_231_143, -1_388_289_902), 12484084349359737767);
//     try std.testing.expectEqual(chunk_utils.keyToChunkCoords(12484084349359737767), [2]i32{ 2_107_231_143, -1_388_289_902 });
// }
