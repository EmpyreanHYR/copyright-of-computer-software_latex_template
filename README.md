
# 计算机软件著作权说明书 LaTeX 模板

本项目为计算机软件著作权登记中“程序鉴别文档（使用说明书）”的 LaTeX 撰写模板，适用于中文环境，已适配宋体、A4 纸、标准段落缩进、章节结构等常见要求。

## 主要特性
- 完全中文支持，默认宋体、Times New Roman 字体
- 规范的封面、修订记录、目录、图目录、表目录
- 章节结构清晰，包含：
	- 软件概述（项目背景、编写目的、适用对象、适用范围）
	- 操作教程
	- 总结展望
- 图表命名、参考文献等均为中文格式
- 适合直接用于著作权登记材料

## 目录结构

```
├── main.tex                # 主文件，编译入口
├── texfile/
│   ├── 1_introduction.tex  # 软件概述
│   ├── 2_implosion.tex     # 操作教程
│   └── 3_summary.tex       # 总结展望
├── image/                  # 图片资源目录
├── LICENSE
├── README.md
```

## 使用方法
1. 安装 XeLaTeX（推荐 TeX Live 或 MacTeX 套件）
2. 编辑 main.tex 及 texfile/ 下各章节内容
3. 终端运行：
	 ```
	 xelatex main.tex
	 ```
	 可多编译几次以生成目录、图表目录等

## 注意事项
- 模板仅供参考，具体格式请结合实际登记要求调整
- 如遇格式或编译问题，欢迎 issue 讨论

## 版权声明
MIT License，欢迎自由使用和修改

---
最新版本请查看 [Releases](https://github.com/EmpyreanHYR/copyright-of-computer-software_latex_template/releases)
