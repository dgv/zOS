// wip
const sbiret = struct { err: usize, value: usize };
fn sbi_call(a0: usize, a1: usize, a2: usize, a3: usize, a4: usize, a5: usize, a6: usize, a7: usize) sbiret {
    return asm volatile ("ecall"
        : [a0] "={r}" (-> .{ .err = a0, .value = a1 }),
        : [a0] "{r}" (a0),
          [a1] "{r}" (a1),
          [a2] "{r}" (a2),
          [a3] "{r}" (a3),
          [a4] "{r}" (a4),
          [a5] "{r}" (a5),
          [a6] "{r}" (a6),
          [a7] "{r}" (a7),
        : "memory"
    );
}

fn putchar(ch: u8) void {
    _ = sbi_call(ch, 0, 0, 0, 0, 0, 0, 1);
}

fn kernel_main() noreturn {
    const s = "\n\nHello World!\n";
    for (s) |i| {
        putchar(i);
    }
    while (true) {
        asm volatile ("wfi");
    }
}

const SYSCON_REG_ADDR: usize = 0x11100000;
const UART_BUF_REG_ADDR: usize = 0x10000000;

const syscon: *volatile u32 = @ptrFromInt(SYSCON_REG_ADDR);
const uart_buf_reg: *volatile u8 = @ptrFromInt(UART_BUF_REG_ADDR);

export fn _start() callconv(.Naked) noreturn {
    asm volatile ("la sp, _sstack"); // set stack pointer
    for ("Hello world\n") |b| {
        // write each byte to the UART FIFO
        uart_buf_reg.* = b;
    }
    syscon.* = 0x5555; // send powerdown
    while (true) {} // Ctrl-a then x to exit
}
