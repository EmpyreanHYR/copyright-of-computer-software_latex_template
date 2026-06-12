
# 计算机软件著作权说明书 LaTeX 模板

本项目为计算机软件著作权登记中“程序鉴别文档（使用说明书）”的 LaTeX 撰写模板，适用于中文环境，已适配宋体、A4 纸、标准段落缩进、章节结构等常见要求。

## 主要特性
- 基于 `ctexart` 文档类，开箱即用的中文支持
- 规范的封面、修订记录、目录、图目录、表目录
- 章节结构清晰，包含：
	- 软件概述（项目背景、编写目的、适用对象、适用范围）
	- 操作教程
	- 总结展望
- `hyperref` 超链接支持：PDF 目录、交叉引用、URL 可点击跳转
- `\upcite{}` 命令生成右上角参考文献标注
- 正文 `\section` 自动从新页开始，无需手动 `\newpage`
- 图表命名、参考文献等均为中文格式
- 一键编译脚本 `compile.bat`（Windows），自动多遍编译 + 清理中间文件
- 适合直接用于著作权登记材料

## 目录结构

```
├── main.tex                # 主文件，编译入口
├── compile.bat             # 一键编译脚本（Windows）
├── texfile/
│   ├── 1_introduction.tex  # 软件概述
│   ├── 2_implosion.tex     # 操作教程
│   └── 3_summary.tex       # 总结展望
├── image/                  # 图片资源目录
├── LICENSE
├── README.md
```

## 使用方法

### 一键编译（Windows）
双击 `compile.bat`，自动完成三遍编译并清理中间文件。

```bat
compile.bat          # 编译 + 清理 .aux .log 等中间文件
compile.bat keep     # 编译 + 保留中间文件（排查错误时用）
```

### 手动编译
1. 安装 XeLaTeX（推荐 TeX Live 或 MacTeX 套件）
2. 编辑 `main.tex` 及 `texfile/` 下各章节内容
3. 终端运行（至少两遍以生成目录和交叉引用）：
	 ```
	 xelatex main.tex
	 xelatex main.tex
	 xelatex main.tex
	 ```

## 字体要求

本模板使用 `ctexart` 文档类（`fontset=windows`），依赖以下字体：

| 字体 | 用途 | Windows | macOS 替代 |
|------|------|---------|------------|
| SimSun（宋体） | 正文 | 系统自带 | 安装 Office 字体 或改为 `fontset=mac` |
| SimHei（黑体） | 章节标题 | 系统自带 | 同上 |
| KaiTi（楷书） | ctex 内置命令 | 系统自带 | 同上 |
| FangSong（仿宋） | ctex 内置命令 | 系统自带 | 同上 |
| Consolas | 英文等宽字体 | 系统自带 | 改为 `Courier New` 或 `Source Code Pro` |
| Times New Roman | 英文正文字体 | 系统自带 | 系统自带 |

> **非 Windows 用户**：将 `\documentclass[12pt,fontset=windows]{ctexart}` 中的 `fontset=windows` 改为 `fontset=mac`（macOS）或 `fontset=ubuntu`（Linux），并根据上表调整 `\setmonofont{Consolas}`。

## 注意事项
- 模板仅供参考，具体格式请结合实际登记要求调整
- 正文每个 `\section`（编号章节）将自动从新页开始；`\section*`（无编号章节）不会自动分页，需手动 `\newpage`
- `\upcite{}` 命令可将参考文献标注显示为右上角上标
- 修订记录表格行数：在 `main.tex` 中搜索 `空行`，复制或删除以 `& & & \\ \hline` 结尾的行即可
- 表格列宽已在 `\textwidth` 内精确适配，修改列宽时注意总宽度不要超过 `15.4cm`
- 如遇格式或编译问题，欢迎 issue 讨论

## 版权声明
MIT License，欢迎自由使用和修改

---
最新版本请查看 [Releases](https://github.com/EmpyreanHYR/copyright-of-computer-software_latex_template/releases)
