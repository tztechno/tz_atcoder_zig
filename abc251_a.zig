const std = @import("std");
const stdout = std.io.getStdOut().writer();
const stdin = std.io.getStdIn().reader();

fn Pair (comptime A: type, comptime B: type) type {
  return struct {
    a: A,
    b: B,
  };
}

fn T (comptime A: type, comptime B: type, comptime C: type) type {
  return struct {
    a: A,
    b: B,
    c: C,
  };
}

const List = std.ArrayList(u64);
const FList = std.ArrayList(f128);
const StringList = std.ArrayList([]u8);
const String = std.ArrayList(u8);
const List2d = std.ArrayList(List);
const I32I32 = Pair(i32, i32);
const U32U32 = Pair(u32, u32);
const U64U64 = Pair(u64, u64);
const I64I64 = Pair(i64, i64);
const StrU32 = Pair([]const u8, u32);
const ListI32I32 = std.ArrayList(I32I32);
const ListU32U32 = std.ArrayList(U32U32);
const ListU64U64 = std.ArrayList(U64U64);
const ListStrU32 = std.ArrayList(StrU32);
const AutoHashMap = std.AutoHashMap(i32, i32);
const ListP = std.ArrayList(U32U32);
const List2dP = std.ArrayList(ListP);
const TU32 = T(u32, u32, u32);
const TU64 = T(u64, u64, u64);

fn read(allocator: std.mem.Allocator) !U64U64 {
  const line = if (try stdin.readUntilDelimiterOrEofAlloc(allocator, '\n', 80)) |str| str else "0 0";
  const index = std.mem.indexOfScalar(u8, line, ' ').?;
  const w = try std.fmt.parseInt(u64, line[0..index], 10);
  const x = try std.fmt.parseInt(u64, line[index + 1..], 10);
  allocator.free(line);
  
  return U64U64{.a = w, .b = x};
}

fn read_i(allocator: std.mem.Allocator) !I64I64 {
  const line = if (try stdin.readUntilDelimiterOrEofAlloc(allocator, '\n', 80)) |str| str else "0 0";
  const index = std.mem.indexOfScalar(u8, line, ' ').?;
  const w = try std.fmt.parseInt(i64, line[0..index], 10);
  const x = try std.fmt.parseInt(i64, line[index + 1..], 10);
  allocator.free(line);
  
  return I64I64{.a = w, .b = x};
}

fn read_t (allocator: std.mem.Allocator) !TU64 {
  const input = if (try stdin.readUntilDelimiterOrEofAlloc(allocator, '\n', 101)) |str| str else "";
  const index = std.mem.indexOfScalar(u8, input, ' ').?;
  const n = try std.fmt.parseInt(u64, input[0..index], 10);
  const index2 = std.mem.indexOfScalar(u8, input[index + 1..], ' ').?;
  const d = try std.fmt.parseInt(u64, input[index + 1..index2 + index + 1], 10);
  const p = try std.fmt.parseInt(u64, input[index2 + 1 + index + 1..], 10);
  
  return TU64{.a = n, .b = d, .c = p};
}

fn cmpByValue(_: void, a: u64, b: u64) bool {
  return a < b;
}

fn cmpByValuePair(_: void, a: U64U64, b: U64U64) bool {
  if (a.a != b.a) {
    return a.a < b.a;
  }
  
  return a.b < b.b;
}

fn startsWith(a: []const u8, b: []const u8) bool {
  var i: u32 = 0;
  
  while (i < a.len) : (i += 1) {
    if (a[i] != b[i]) {
      return false;
    }
  }
  
  return true;
}

fn endsWith(a: []const u8, b: []const u8) bool {
  var i: usize = b.len - a.len;
  var j: u32 = 0;
  
  while (i < b.len) : (i += 1) {
    if (a[j] != b[i]) {
      return false;
    }
    
    j += 1;
  }
  
  return true;
}

fn power(a: u32, b: u32) u32 {
  var i: u32 = 0;
  var result: u32 = 1;
  
  while (i < b) : (i += 1) {
    result *= a;
  }
  
  return result;
}

fn isValid (n: u32, m: u32, list: std.ArrayList([]const u8), tak_code: [9][]const u8) bool {
  var i: u32 = 0;
  
  while (i < 9) : (i += 1) {
    var j: u32 = 0;
    const idx = i + n;
    const item = list.items[idx];
    
    while (j < 9) : (j += 1) {
      if (tak_code[i][j] != '?' and item[m + j] != tak_code[i][j]) {
        return false;
      }
    }
  }
  
  return true;
}

fn validate (list: List, mid: u64, tar: u64) bool {
  var ctr: u64 = 1;
  var len: u64 = 0;
  
  for (list.items) |item| {
    len += item;
    
    if (len > mid) {
      ctr += 1;
      len = item;
    }
  }
  
  return ctr > tar;
}

fn search (list: []u64, l: u64, r: u64, tar: u64) u64 {
  var upper = r;
  var lower = l;
  
  while (lower < upper) {
    const mid = lower + (upper - lower) / 2;
    
    if (list[mid] <= tar) {
      lower = mid + 1;
    } else {
      upper = mid;
    }
  }
  
  return lower;
}

fn search2 (list: []u64, l: u64, r: u64, tar: u64) u64 {
  var upper = r;
  var lower = l;
  
  while (lower < upper) {
    const mid = lower + (upper - lower) / 2;
    
    if (list[mid] < tar) {
      lower = mid + 1;
    } else {
      upper = mid;
    }
  }
  
  return r - lower;
}

fn solve1(list: []u64, list2: []u64, l: u64, r: u64) !u64 {
  var upper = r;
  var lower = l;
  
  while (lower < upper) {
    const mid = lower + (upper - lower) / 2;
    const result = search(list, 0, list.len, mid);
    const result2 = search2(list2, 0, list2.len, mid);
    //try stdout.print("{} {} {}\n", .{mid, result, result2});
    
    if (result >= result2) {
      upper = mid;
    } else {
      lower = mid + 1;
    }
  }
  
  return lower;
}

fn solveA (l: u64, r: u64, a: u64, b: u64, x: u64) u64 {
  var lower = l;
  var upper = r;
  
  while (lower < upper) {
    const mid = lower + (upper - lower) / 2;
    const cost = a * mid + b * dd(mid);
    
    if (cost <= x) {
      lower = mid + 1;
    } else {
      upper = mid;
    }
  }
  
  return lower - 1;
}

fn dd(num: u64) u64 {
  var x = num;
  var result: u64 = 0;
  
  while (x > 0) : (result += 1) {
    x /= 10;
  }
  
  return result;
}

fn solveX (list: []u64, l: u64, r: u64, tar: u64) !u64 {
  var upper = r;
  var lower = l;
  
  while (lower < upper) {
    const mid = lower + (upper - lower) / 2;
    //try stdout.print("{} {} {}\n", .{mid, result, result2});
    
    if (list[mid] > tar) {
      upper = mid;
    } else {
      lower = mid + 1;
    }
  }
  
  return upper;
}

fn searchForL(list: []U64U64, tar: u64) u64 {
  var lower: u32 = 0;
  var upper: u32 = @intCast(u32, list.len);
  
  while (lower < upper) {
    const mid = lower + (upper - lower) / 2;
    
    if (list[mid].a < tar) {
      lower = mid + 1;
    } else {
      upper = mid;
    }
  }
  
  return upper;
}

fn searchForR(list: []U64U64, tar: u64) u64 {
  var lower: u32 = 0;
  var upper: u32 = @intCast(u32, list.len);
  
  while (lower < upper) {
    const mid = lower + (upper - lower) / 2;
    
    if (list[mid].a <= tar) {
      lower = mid + 1;
    } else {
      upper = mid;
    }
  }
  
  return upper - 1;
}

fn searchForS(list: []U64U64, l: u64, r: u64, tar: u64) u64 {
  var lower: u64 = l;
  var upper: u64 = r + 1;
  
  while (lower < upper) {
    const mid = lower + (upper - lower) / 2;
    
    if (list[mid].b < tar) {
      lower = mid + 1;
    } else {
      upper = mid;
    }
  }
  
  return upper;
}

fn searchForE(list: []U64U64, l: u64, r: u64, tar: u64) u64 {
  var lower: u64 = l;
  var upper: u64 = r + 1;
  
  while (lower < upper) {
    const mid = lower + (upper - lower) / 2;
    
    if (list[mid].b <= tar) {
      lower = mid + 1;
    } else {
      upper = mid;
    }
  }
  
  return upper - 1;
}

fn solve(list: []U64U64, il: u64, ir: u64, tar: u64) !u64 {
  const l = searchForL(list, tar);
  var r = searchForR(list, tar);
  
  if (list[l].a != tar) {
    return 0;
  }
  
  const s = searchForS(list, l, r, il);
  var e = searchForE(list, l, r, ir);
  
  //try stdout.print("{} {} {} {}\n", .{list[l].a, list[l].b, list[r].a, list[r].b});
  //try stdout.print("{} {} {} {}\n", .{list[s].a, list[s].b, list[e].a, list[e].b});
  
  if (list[s].b < il) {
    return 0;
  }
  
  return e - s + 1;
}

fn findMaxRes(a_items: []u64, b_items: []u64, t: u64) !u64 {
  const m = b_items.len;
  
  if (search(a_items, 0, a_items.len, t)) |idx| {
    var rem = t - a_items[idx];
    var rem_idx = if (search(b_items, 0, m, rem)) |res| res else 0;
    var result = idx + rem_idx;
    var i = idx;
    
    
    while (i > 0) : (i -= 1) {
      rem = t - a_items[i - 1];
      rem_idx = if (search(b_items, 0, m, rem)) |res| res else 0;
      const temp = i + rem_idx - 1;
      
      result = if (result < temp) temp else result;
    }
    
    return result;
  } else {
    return if (search(b_items, 0, b_items.len, t)) |res| res else 0;
  }
}

fn rep(num: u32) u32 {
  var d: u32 = num % 10;
  var n = num;
  
  while (n > 0) {
    const d2 = n % 10;
    
    if (d2 != d) {
      return 0;
    }
    
    n /= 10;
  }
  
  return d;
}

fn expected_value(list: []f128, x: f128) f128 {
  var acc: f128 = 0;
  
  for (list) |item| {
    acc += x + item - if (item < 2 * x) item else 2 * x;
  }
  
  return acc / @intToFloat(f128, list.len);
}

fn abs(num: f128) f128 {
  if (num < 0) {
    return -num;
  }
  
  return num;
}

fn f_search(list: []f128) f128 {
  var l: f128 = 0;
  var r: f128 = 1e9 + 10;
  
  while (abs(l - r) >= 1e-6) {
    const mid1 = l + (r - l) / 3;
    const mid2 = r - (r - l) / 3;
    const e1 = expected_value(list, mid1);
    const e2 = expected_value(list, mid2);
    
    if (e1 < e2) {
      r = mid2;
    } else {
      l = mid1;
    }
  }
  
  return l;
}

pub fn main() !void {
  @setRuntimeSafety(false);
  var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
  defer arena.deinit();
  const allocator = arena.allocator();
  //const StringMap = std.StringHashMap(u32);
  //const Map = std.AutoHashMap(U64U64, u32);
  //const P = Pair(u32, List);
  //const Type = std.ArrayList(P);
  //const ResultType = std.ArrayList(u8);
  //const str = try stdin.readUntilDelimiterAlloc(allocator, '\n', 3);
  //std.sort.sort(u64, list.items, {}, cmpByValue);
  
  var result = [_]u8{0, 0, 0, 0, 0, 0};
  const str = try stdin.readUntilDelimiterAlloc(allocator, '\n', 5);
  var i: u32 = 0;
  
  while (i < result.len) : (i += 1) {
    const idx = i % str.len;
    result[i] = str[idx];
  }

  try stdout.print("{s}\n", .{result});
}
