abc070_b.zig
##############################
[create original func]

fn max(a: u64, b: u64) u64 {
    if (a > b) {
        return a;
    } else {
        return b;
    }
}

fn min(a: u64, b: u64) u64 {
    if (a > b) {
        return b;
    } else {
        return a;
    }
}
##############################
##############################
##############################
##############################
##############################
##############################
##############################
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


fn max(a: u64, b: u64) u64 {
    if (a > b) {
        return a;
    } else {
        return b;
    }
}

fn min(a: u64, b: u64) u64 {
    if (a > b) {
        return b;
    } else {
        return a;
    }
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    allocator = arena.allocator();
    const A = getvecu();
    const a = A[0];
    const b = A[1];
    const c = A[2];
    const d = A[3];
    var t=max(min(b,d)-max(a,c),0);
    try stdout.writer().print("{d}\n", .{ t});
}
##############################
