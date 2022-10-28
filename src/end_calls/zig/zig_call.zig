const print = @import("std").debug.print;

pub export fn call_zig(x: [*c]const u8) callconv(.C) void {
    print("{s}\n", .{x});
}