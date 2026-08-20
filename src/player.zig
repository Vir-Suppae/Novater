const rl = @import("raylib");
const cam_utils = @import("camera_utils.zig");

pub const Player = struct {
    pos: rl.Vector2,
    cam: rl.Camera2D,

    pub fn init(pos: rl.Vector2, cam: rl.Camera2D) @This() {
        return .{
            .pos = pos,
            .cam = cam,
        };
    }

    pub fn update(this: *@This()) void {
        this.pos.x += 1;
        cam_utils.adjustCam(&this.cam);
        this.cam.target = this.pos;
    }
};
