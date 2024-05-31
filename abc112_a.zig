abc112_a.zig
#######################################
出力
try stdout.writer().print("{s}\n", .{ ans }); 
try stdout.writer().print("{d}\n", .{ ans });  
#######################################
#######################################
#######################################
#######################################
#######################################
#######################################
#######################################
#######################################
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
    const n = getu();
    if (n==1) {
      var ans = "Hello Wolrd";
      try stdout.writer().print("{s}\n", .{ ans }); 
    }
    else {
      const a = getu();
      const b = getu();
      var ans = a+b;
      try stdout.writer().print("{d}\n", .{ ans });   
    }
}
#######################################
[python]
N=int(input())
if N==1:
    print("Hello World")
else:
    a=int(input())
    b=int(input())
    print(a+b)
    
#######################################
