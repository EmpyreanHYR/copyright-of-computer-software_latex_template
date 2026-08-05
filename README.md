
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
- 长表格 `longtable` 支持：单元格内断行、跨页自动换页并重复表头
- 正文 `\section` 自动从新页开始，无需手动 `\newpage`
- 图表命名、参考文献等均为中文格式
- 一键编译脚本 `compile.bat`（Windows），自动多遍编译 + 清理中间文件
- 适合直接用于著作权登记材料


## 目录结构

```
├── main.tex                # 主文件，编译入口
├── compile.bat             # 一键编译脚本（Windows）
├── clean.bat               # 清理中间文件脚本
├── texfile/
│   ├── 1_introduction.tex  # 软件概述
│   ├── 2_operation.tex       # 操作教程
│   └── 3_summary.tex       # 总结展望
├── image/                  # 图片资源目录
├── LICENSE
├── README.md
```



## 🚀 完整软著申请解决方案

本仓库专注于提供高质量的 **文档鉴别材料**（使用说明书）LaTeX 模板。如果您还需要处理 **程序鉴别材料**（源代码），欢迎使用配套工具：

[![Software Copyright Toolkit](https://img.shields.io/badge/配套工具-Software%20Copyright%20Toolkit-blue?style=for-the-badge&logo=github)](https://github.com/EmpyreanHYR/software-copyright-toolkit)

### 为什么推荐它？
| 特性 | 说明 |
| :--- | :--- |
| 📝 **程序鉴别材料生成** | 一键生成符合规范的“前后 30 页”及“全量代码” Word 文档 |
| 📊 **精准代码统计** | 支持 40+ 种语言，自动排除空行与注释，生成 Markdown 报告 |
| 🖱️ **零门槛使用** | 提供开箱即用的 GUI 图形界面，无需记忆任何命令行参数 |
| ⚡ **高性能与健壮性** | 支持大文件流式读取，自动处理多种文件编码 |

> **💡 最佳实践**：  
> 1. 使用 [software-copyright-toolkit](https://github.com/EmpyreanHYR/software-copyright-toolkit) 导出您的源代码 Word 文档。  
> 2. 使用本 [LaTeX 模板](https://github.com/EmpyreanHYR/copyright-of-computer-software_latex_template) 填写并编译您的软件使用说明书。  
> 3. 合并提交，轻松完成软著登记材料准备！


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

## 表格：单元格断行与跨页

模板已内置 `longtable` 长表格支持，行数超出一页时自动断行换页，并在续页自动重复表头。已有表格（如"文件修订记录"）保持原样即可，需要长表格时按下面方式编写。

- **单元格内断行**：列格式使用 `m{宽度}`（垂直居中）、`p{宽度}`（顶部对齐）或 `b{宽度}`（底部对齐），单元格内用 `\\` 换行
- **跨页换页**：把 `tabular` 换成 `longtable` 即可自动跨页；`\endfirsthead` 之前为首页表头，`\endhead` 之前为续页表头（每页重复），`\endlastfoot` 之前为最后一页表尾
- **表格标题**：`longtable` 内用 `\caption{标题}\label{标签}\\` 生成标题，可被交叉引用并进入表目录；若不需要编号/不进表目录，省略 `\caption` 即可
- **最小示例**：

```latex
\begin{longtable}{ | m{1.5cm}<{\centering} | m{4cm}<{\centering} | m{4.64cm}<{\centering} | m{3.5cm}<{\centering} |}
	\caption{示例表格}\label{tab:example}\\
	\hline
	版本号 & 生成日期 & 作者 & 修订内容 \\ % 首页表头
	\hline
	\endfirsthead
	\hline
	版本号 & 生成日期 & 作者 & 修订内容 \\ % 续页表头（自动重复）
	\hline
	\endhead
	\hline
	\endlastfoot
	V1.0 & 2025年6月29日 & 作者 & 初始版本 \\ % 数据行（可继续添加）
	\hline
\end{longtable}
```

- **注意事项**：
  - `longtable` **不能**放在 `center` 环境内（会阻止跨页分页）
  - 行高调整 `\renewcommand{\arraystretch}{1.5}` 在表格结束后应恢复为 `1`，避免影响后续表格

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
