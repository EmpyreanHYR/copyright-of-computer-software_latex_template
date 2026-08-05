#!/usr/bin/env bash
# ============================================================
#  Linux/macOS 一键编译脚本（基于 latexmk）
#
#  用法：
#    - Linux 桌面：双击本文件（首次需在文件属性中勾选“允许作为
#      程序执行”，或右键 -> 运行）；也可在终端执行 ./compile.sh
#    - macOS：建议双击同目录下的 compile.command（Finder 中
#      双击即可在“终端”中运行），本脚本内容与之相同
#    - 参数：./compile.sh clean  一键清理中间文件（保留 main.pdf）
#
#  依赖：TeX Live / MacTeX（含 latexmk、xelatex、biber）
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
    error "未找到 latexmk，请先安装 TeX Live / MacTeX："
    error "  macOS: https://tug.org/mactex/  或  brew install --cask mactex"
    error "  Linux: sudo apt install texlive-full   (或 texlive-xetex texlive-latex-extra biber)"
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
