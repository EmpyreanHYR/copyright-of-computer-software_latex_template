# ============================================================
#  latexmk 跨平台配置（Windows / macOS / Linux 通用）
#
#  用法（在 main.tex 所在目录的终端中执行）：
#    latexmk main.tex          # 编译：自动判断需要多少遍（含参考文献）
#    latexmk -c                # 一键清理中间文件（保留 main.pdf 与源码）
#    latexmk -C                # 彻底清理（连 main.pdf 一起删除）
#    latexmk -pvc main.tex     # 持续监视，文件变化自动重编译（编写时用）
#
#  说明：本配置只针对本目录生效；如需全局生效请放入用户主目录。
# ============================================================

# 使用 XeLaTeX 生成 PDF（中文支持）
$pdf_mode = 4;
$xelatex  = 'xelatex -synctex=1 -interaction=nonstopmode -halt-on-error %O %S';

# 参考文献后端自动选择：
#   biblatex（softcopyright.sty 方案 A）-> biber
#   bibtex（方案 B）                    -> bibtex
# latexmk 会自行检测并调用相应后端，无需手工干预
$bibtex_use = 1;
$biber      = 'biber %O %S';

# latexmk -c 时清理的中间文件扩展名（main.pdf 与源文件保留）
$clean_ext = 'aux bbl bcf blg fls fdb_latexmk lof lot toc out synctex.gz run.xml xdv nav snm vrb thm';
