//abc091_a.zig
################################
################################
################################
################################
################################
################################
################################
################################
################################
const std = @import("std");

fn read(allocator: std.mem.Allocator) ?[]const u8 {
    const stdin = std.io.getStdIn();
    return stdin.reader().readUntilDelimiterOrEofAlloc(allocator, '\n', 80) catch null;
}

pub fn main() !void {
    @setRuntimeSafety(false);
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const h = read(allocator) orelse return error.EndOfStream;
    const stdout = std.io.getStdOut();

    var iter = std.mem.split(u8, h, " ");
    const a = iter.next() orelse return error.InvalidInput;
    const b = iter.next() orelse return error.InvalidInput;
    const c = iter.next() orelse return error.InvalidInput;

    const x = std.fmt.parseInt(u64, a, 10) catch return error.InvalidInput;
    const y = std.fmt.parseInt(u64, b, 10) catch return error.InvalidInput;
    const z = std.fmt.parseInt(u64, c, 10) catch return error.InvalidInput;

    //stdout.writer().print("{} {} {}\n", .{ x, y, z }) catch return error.OutputWriteFailed;
    
    if (x + y >= z) {
        try stdout.writer().writeAll("Yes\n");
    } else {
        try stdout.writer().writeAll("No\n");
    }
}

################################
