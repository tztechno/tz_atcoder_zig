//alg_a.zig
################################
################################
################################
################################
################################
const std = @import("std");

fn nextToken(reader: anytype, buffer: []u8) []const u8 {
    return reader.readUntilDelimiter(
        buffer,
        ' ',
    ) catch unreachable;
}

fn nextLine(reader: anytype, buffer: []u8) []const u8 {
    const line = reader.readUntilDelimiterOrEof(
        buffer,
        '\n',
    ) catch unreachable;

    if (@import("builtin").os.tag == .windows) {
        return std.mem.trimRight(u8, line.?, "\r");
    } else {
        return line.?;
    }
}

fn parseUsize(buf: []const u8) usize {
    return std.fmt.parseInt(usize, buf, 10) catch unreachable;
}

pub fn main() !void {
    const stdin = std.io.getStdIn();
    var buffer: [1024]u8 = undefined;

    const l = parseUsize(nextToken(stdin.reader(), &buffer));
    const r = parseUsize(nextLine(stdin.reader(), &buffer));

    const result = "atcoder"[(l - 1)..r];

    const stdout = std.io.getStdOut();
    try stdout.writer().print("{s}", .{result});
}

################################
const std = @import("std");

pub fn main() !void {
    var buffer: [1000000]u8 = undefined;
    const stdin = std.io.getStdIn();
    const reader = stdin.reader();
    const stdout = std.io.getStdOut();
    const L_ = try reader.readUntilDelimiter(&buffer, ' ');
    const L = try std.fmt.parseInt(usize, L_, 10);
    const R_ = try reader.readUntilDelimiterOrEof(&buffer, '\n');
    const R = try std.fmt.parseInt(usize, R_.?, 10);

    try stdout.writer().print("{s}\n", .{"atcoder"[L - 1 .. R]});
}

################################
