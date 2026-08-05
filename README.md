
# 计算机软件著作权说明书 LaTeX 模板

本项目为计算机软件著作权登记中“程序鉴别文档（使用说明书）”的 LaTeX 撰写模板，适用于中文环境，已适配宋体、A4 纸、标准段落缩进、章节结构等常见要求。

## 主要特性
- 基于 `ctexart` 文档类，开箱即用的中文支持；`fontset` 自动检测（Windows / macOS / Linux 自动选用合适的系统字体）
- 规范的封面、修订记录、目录、图目录、表目录
- 章节结构清晰，包含：
	- 软件概述（项目背景、编写目的、适用对象、适用范围）
	- 操作教程
	- 总结展望
- 章节使用 `\include` 引入：每章自动从新页开始（软著要求），并支持 `\includeonly` 单独编译某一章（大幅提速）
- 全部样式配置集中在 `softcopyright.sty`，主文件 `main.tex` 只保留文档结构与内容
- `hyperref` 超链接支持：PDF 目录、交叉引用、URL 可点击跳转
- 参考文献支持 GB/T 7714-2015 规范，内置两套方案（biblatex+biber / bibtex），切换只需改一行注释
- `\upcite{}` 命令生成右上角参考文献标注
- 长表格 `longtable` 支持：单元格内断行、跨页自动换页并重复表头
- 一键编译脚本：Windows `compile.bat`、macOS `compile.command`、Linux `compile.sh`、跨平台 `latexmk`
- 适合直接用于著作权登记材料


## 目录结构

```
├── main.tex                # 主文件，编译入口（只含文档结构）
├── softcopyright.sty       # 全部样式/宏包配置（字体、字号、参考文献方案等）
├── refs.bib                # 参考文献数据库（示例）
├── .latexmkrc              # latexmk 跨平台配置（自动多遍编译 + 清理）
├── compile.bat             # 一键编译脚本（Windows）
├── clean.bat               # 清理中间文件脚本（Windows）
├── compile.sh              # 一键编译脚本（Linux/macOS 终端）
├── compile.command         # 一键编译脚本（macOS 双击）
├── texfile/
│   ├── 1_introduction.tex  # 软件概述
│   ├── 2_operation.tex     # 操作教程
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
双击 `compile.bat`，自动完成多遍编译（含参考文献）并清理中间文件。

```bat
compile.bat          # 编译 + 清理中间文件
compile.bat keep     # 编译 + 保留中间文件（排查错误时用）
```

> 任一步骤失败会暂停并报错，且 **不会清理日志**（`main.log` 保留供排查）。

### 一键编译（macOS）
双击 `compile.command` 即可在“终端”中编译；编译成功/失败后窗口会暂停等待按键。

### 一键编译（Linux）
双击 `compile.sh`（首次需在文件属性中勾选“允许作为程序执行”），或在终端执行：

```sh
./compile.sh          # 编译
./compile.sh clean    # 一键清理中间文件（保留 main.pdf）
```

### 跨平台编译（latexmk，推荐）
安装 TeX Live / MacTeX 后自带 latexmk。在项目根目录终端执行：

```sh
latexmk main.tex        # 编译：自动判断需要几遍（目录、交叉引用、参考文献）
latexmk -c              # 一键清理中间文件（保留 main.pdf）
latexmk -C              # 彻底清理（连 main.pdf 一起删除）
latexmk -pvc main.tex   # 持续监视，文件变化自动重编译（编写时用）
```

`.latexmkrc` 已配置好 XeLaTeX 引擎与 biber/bibtex 自动检测，无需手工指定。

### 手动编译
1. 安装 XeLaTeX（推荐 TeX Live 或 MacTeX 套件）
2. 编辑 `main.tex` 及 `texfile/` 下各章节内容
3. 终端运行：
	 ```
	 xelatex main.tex
	 biber  main         # 若使用 biblatex 方案；bibtex 方案则运行 bibtex main
	 xelatex main.tex
	 xelatex main.tex
	 ```

### 单独编译某一章（编写时提速）
`\include` 支持 `\includeonly`：只需在 `main.tex` 导言区取消注释一行，即可只编译指定章节，大幅缩短编译时间：

```latex
\includeonly{texfile/2_operation}   % 只编译“操作教程”一章
```

- 参数须与正文中的 `\include{texfile/2_operation}` 完全一致（不带 `.tex` 后缀）
- 只编译单章时，该章编号会从 1 开始（其他章节未被编译）
- **正式提交/生成最终 PDF 前，务必注释掉这一行做全量编译**

## 字体说明

`ctexart` 的 `fontset` 选项**不指定即为自动检测**（等效 `fontset=auto`），根据操作系统自动选择中文字体；英文字体则通过 `\IfFontExistsTF` 按可用性自动回退，保证在 Windows / macOS / Linux 上都能编译：

| 用途 | 首选（Windows） | macOS 回退 | Linux 回退 |
|------|-----------------|------------|------------|
| 中文正文（ctex 自动） | SimSun | Songti SC | Fandol 宋体 |
| 中文标题（ctex 自动） | SimHei | Heiti SC | Fandol 黑体 |
| 英文正文 | Times New Roman | Times New Roman | Liberation Serif / TeX Gyre Termes |
| 英文等宽（代码） | Consolas | Menlo / Courier New | DejaVu Sans Mono / Liberation Mono |

> 以上回退链已内置在 `softcopyright.sty` 中，无需手动修改；如某字体缺失会自动降级到下一个可用字体，不会导致编译失败。

## 参考文献（GB/T 7714-2015）

模板内置两套方案，默认启用**方案 A**。切换方案只需在 `softcopyright.sty` 的“10. 参考文献方案”一节改注释，正文无需改动：

- **方案 A（默认，推荐）**：`biblatex` + `biber` + `gb7714-2015` 样式，顺序编码制
  ```latex
  \usepackage[backend=biber, style=gb7714-2015, sorting=none]{biblatex}
  \addbibresource{refs.bib}
  ```
- **方案 B（备选）**：`bibtex` + `gbt7714` 宏包（natbib 接口）
  ```latex
  \usepackage[sort&compress]{gbt7714}
  ```

在正文中引用：

```latex
\cite{example:article}     % 文末编号列表
\upcite{example:book}      % 右上角上标（GB/T 7714 常用样式）
```

- 文献条目写入 `refs.bib`（已含图书/期刊/网络资源三种示例）
- 未被引用的条目不会出现在参考文献列表中；如需全部列出，在 `main.tex` 参考文献部分加一行 `\nocite{*}`
- 参考文献宏包与 `\upcite` 的冲突已处理：方案 A 下 `\upcite` 由 gbt7714 样式内置，模板仅在未内置时自动补一个兜底定义

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
  - 行高调整请使用 `\begingroup ... \endgroup` 限定作用域（修订记录表格已是此写法），避免影响后续表格

## 注意事项
- 模板仅供参考，具体格式请结合实际登记要求调整
- 正文每个 `\section`（编号章节）将自动从新页开始；`\section*`（无编号章节）不会自动分页，需手动 `\newpage`
- `\upcite{}` 命令可将参考文献标注显示为右上角上标
- 修订记录表格行数：在 `main.tex` 中搜索 `空行`，复制或删除以 `& & & \\ \hline` 结尾的行即可
- 表格列宽已在 `\textwidth` 内精确适配，修改列宽时注意总宽度不要超过 `15.4cm`
- 软件名称、版本号、作者在 `softcopyright.sty` 的“8. 作者与版本信息”一节修改
- `compile.bat` / `clean.bat` 请保持 ASCII（英文）内容：`cmd.exe` 按系统代码页解析批处理，UTF-8 中文会造成命令错乱
- 如遇格式或编译问题，欢迎 issue 讨论

## 版权声明
MIT License，欢迎自由使用和修改

---
最新版本请查看 [Releases](https://github.com/EmpyreanHYR/copyright-of-computer-software_latex_template/releases)
