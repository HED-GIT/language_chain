const io = @import("std").io;

pub export fn call_zig(x: [*c]const u8) callconv(.C) void {
    const stdout = io.getStdOut().writer();
    nosuspend stdout.print("{s}\n", .{x}) catch return;
}