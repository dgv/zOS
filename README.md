# zOS

[![zig version](https://img.shields.io/badge/0.13.0-orange?style=flat&logo=zig&label=zig&color=%23eba742)](https://ziglang.org/download/)
[![0 dependencies!](https://0dependencies.dev/0dependencies.svg)](https://0dependencies.dev)
[![license](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

just reimplementation of [OS in 1k lines](https://operating-system-in-1000-lines.vercel.app/en/)

## setup

**linux**
```sh
sudo apt update && sudo apt install -y snapd qemu-system-misc curl
sudo snap install zig --beta --classic
git clone https://github.com/dgv/zOS; cd zOS
curl -LO https://github.com/qemu/qemu/raw/v8.0.4/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
zig build run
```
**macos**
```sh
brew install zig qemu
git clone https://github.com/dgv/zOS; cd zOS
zig build run
```
