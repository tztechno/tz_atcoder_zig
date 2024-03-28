abc097_a.zig
#########################################
#########################################
#########################################
#########################################
#########################################
#########################################
#########################################
#########################################
#########################################
const std = @import("std");
const stdout = std.io.getStdOut();
var buffer: [1000000]u8 = undefined;
const stdin = std.io.getStdIn();
var buf = std.io.bufferedReader(stdin.reader());
var stdin_reader = buf.reader();
var allocator: std.mem.Allocator = undefined;

fn gets() []const u8 {
    const line = stdin_reader.readUntilDelimiterOrEof(&buffer, '\n') catch unreachable;
    return allocator.dupe(u8, line.?) catch unreachable;
}

fn geti() i64 {
    return std.fmt.parseInt(i64, gets(), 10) catch unreachable;
}

fn getu() u64 {
    return std.fmt.parseInt(u64, gets(), 10) catch unreachable;
}

fn getvecu() []const u64 {
    var vecu = std.ArrayList(u64).init(allocator);
    var it = std.mem.split(u8, gets(), " ");
    var v = it.next();
    while (v != null) : (v = it.next()) {
        const val = std.fmt.parseInt(u64, v.?, 10) catch unreachable;
        vecu.append(val) catch unreachable;
    }
    return vecu.items;
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    allocator = arena.allocator();

    const E = getvecu();
    const a: u64 = E[0];
    const b: u64 = E[1];
    const c: u64 = E[2];
    const d: u64 = E[3];

    var ans: []const u8 = ""; 

    const abs_a_b = std.math.absInt(@intCast(i64, a) - @intCast(i64, b)) catch unreachable;
    const abs_b_c = std.math.absInt(@intCast(i64, b) - @intCast(i64, c)) catch unreachable;
    const abs_c_a = std.math.absInt(@intCast(i64, c) - @intCast(i64, a)) catch unreachable;

    if (abs_c_a <= d) {
        ans = "Yes";
    } else if (abs_a_b > d) {
        ans = "No";
    } else if (abs_b_c > d) {
        ans = "No";
    } else {
        ans = "Yes";
    }

    try stdout.writer().print("{s}\n", .{ans});
}
#########################################
