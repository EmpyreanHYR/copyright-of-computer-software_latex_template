#!/usr/bin/env bash
# ============================================================
#  macOS 一键编译脚本（Finder 中双击本文件即可在“终端”运行）
#  内容与 compile.sh 相同；Linux 用户请双击 compile.sh。
#  用法：./compile.command [clean]
# ============================================================

set -u
cd "$(dirname "$0")" || exit 1

info()  { printf '\033[36m==> %s\033[0m\n' "$*"; }
error() { printf '\033[31m[错误] %s\033[0m\n' "$*" >&2; }

# ---------- 清理模式 ----------
if [ "${1:-}" = "clean" ]; then
    info "latexmk -c 清理中间文件（保留 main.pdf）..."
    latexmk -c main.tex
    info "清理完成。"
    read -r -p "按回车键退出..."
    exit 0
fi

# ---------- 检查 latexmk ----------
if ! command -v latexmk >/dev/null 2>&1; then
    error "未找到 latexmk，请先安装 MacTeX：https://tug.org/mactex/  或  brew install --cask mactex"
    read -r -p "按回车键退出..."
    exit 1
fi

# ---------- 编译 ----------
info "开始编译（latexmk 自动多遍编译并处理参考文献，稍候）..."
latexmk -xelatex -synctex=1 -interaction=nonstopmode -halt-on-error main.tex
status=$?
if [ "$status" -ne 0 ]; then
    error "编译失败！请查看 main.log 定位错误（日志已保留，未被清理）。"
    read -r -p "按回车键退出..."
    exit "$status"
fi

info "编译成功：main.pdf"
read -r -p "按回车键退出..."
exit 0
