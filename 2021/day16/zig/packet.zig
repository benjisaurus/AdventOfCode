const std = @import("std");

fn hexToBin() ![]const u8 {
    const len = input.len * 4;
    var binStr: [len]u8 = undefined;
    var idx: u8 = 0;
    var b: [4]u8 = undefined;
    for (input) |ch| {
        var num = std.fmt.charToDigit(ch, 16);
        _ = try std.fmt.bufPrint(&b, "{b:0>4}", .{num});
        var i: u8 = 0;
        while (i < 4) : (i += 1) {
            binStr[idx + i] = b[i];
        }
        idx += 4;
    }
    return &binStr;
}

fn packetVersion(packet: []const u8) u8 {
    var verStr: []const u8 = packet[0..3];
    var typeStr: []const u8 = packet[3..6];
    var ver: u8 = std.fmt.parseInt(u8, verStr, 2) catch 0;
    var pType: u8 = std.fmt.parseInt(u8, typeStr, 2) catch 0;
    _ = pType;
    return ver;
}

const input: []const u8 = "D2FE28";

pub fn main() void {
    var binStr = hexToBin() catch "0";
    std.debug.print("{s}\n", .{binStr});
    var v = packetVersion(binStr);
    std.debug.print("{any}\n", .{v});
}