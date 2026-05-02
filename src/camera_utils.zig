const rl = @import("raylib");
pub fn makeWorldCam() rl.Camera2D {
    return .{
        .offset = .{
            .x = @as(f32, @floatFromInt(rl.getScreenWidth())) / 2,
            .y = @as(f32, @floatFromInt(rl.getScreenHeight())) / 2,
        },
        .rotation = 0,
        .target = .zero(),
        .zoom = 1,
    };
}

pub fn adjustCam(cam: *rl.Camera2D) void {
    cam.offset = .{
        .x = @as(f32, @floatFromInt(rl.getScreenWidth())) / 2,
        .y = @as(f32, @floatFromInt(rl.getScreenHeight())) / 2,
    };
}
