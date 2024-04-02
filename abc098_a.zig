###############################################
符号あり整数型を使う場合は、オーバーフローによる動作が異なります。

Zigには以下の符号あり整数型があります。

i8: 8ビットの符号あり整数型
i16: 16ビットの符号あり整数型
i32: 32ビットの符号あり整数型
i64: 64ビットの符号あり整数型
i128: 128ビットの符号あり整数型
符号あり整数型でオーバーフローが発生した場合、値は循環します。つまり、最大値を超えると最小値に、最小値を下回ると最大値になります。

例えば、i8型の範囲は-128〜127です。もし127に1を加算すると、結果は-128になります。
###############################################
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

fn getvecu() []const i64 {
    var vecu = std.ArrayList(i64).init(allocator);
    var it = std.mem.split(u8, gets(), " ");
    var v = it.next();
    while (v != null) : (v = it.next()) {
        const val = std.fmt.parseInt(i64, v.?, 10) catch unreachable;
        vecu.append(val) catch unreachable;
    }
    return vecu.items;
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    allocator = arena.allocator();
    const ab = getvecu();
    const a = ab[0];
    const b = ab[1];
    const S = &[3]i64{ a + b, a - b, a * b };
    std.sort.sort(i64, S, {}, comptime std.sort.asc(i64));
    const ans = S[S.len - 1];

    try stdout.writer().print("{d}\n", .{ ans });
}
###############################################
