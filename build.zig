const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "kernel.elf",
        .root_source_file = b.path("kernel.zig"),
        .target = b.standardTargetOptions(.{ .default_target = .{ .cpu_arch = .riscv32, .os_tag = .freestanding, .abi = .none, .cpu_model = .{ .explicit = &std.Target.riscv.cpu.generic_rv32 } } }),
        .optimize = .ReleaseSmall,
    });
    exe.setLinkerScript(b.path("start.ld"));
    b.installArtifact(exe);

    const qemu = b.addSystemCommand(&.{
        "qemu-system-riscv32",
        "-machine",
        "virt",
        "-bios",
        "default",
        "-nographic",
        "-serial",
        "mon:stdio",
        "--no-reboot",
        "-kernel",
        "./zig-out/bin/kernel.elf",
    });
    const kernel = b.addRunArtifact(exe);
    const run_step = b.step("run", "run kernel.elf on qemu");
    run_step.dependOn(&kernel.step);
    run_step.dependOn(&qemu.step);
}
