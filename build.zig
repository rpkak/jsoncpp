const std = @import("std");

pub fn build(b: *std.Build) void {
    const upstream = b.dependency("jsoncpp", .{});

    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "jsoncpp",
        .target = target,
        .optimize = optimize,
    });

    lib.installHeadersDirectory(upstream.path("include/json"), "json", .{});
    lib.addIncludePath(upstream.path("include"));
    lib.addCSourceFiles(.{
        .root = upstream.path("src/lib_json"),
        .files = &.{ "json_reader.cpp", "json_value.cpp", "json_writer.cpp" },
    });
    lib.linkLibCpp();

    b.installArtifact(lib);
}
