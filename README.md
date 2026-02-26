# cau-thesis-doctor

中国农业大学研究生学位论文LaTeX模板

基于[中国农业大学研究生学位论文格式及书写规范（2025年修订）](https://gradsch1.cau.edu.cn/art/2025/8/13/art_41503_1079318.html)编写，适用于博士论文。

## 编译方式

1. `xelatex example`
2. `bibtex example`
3. `makeindex example.nlo -s nomencl.ist -o example.nls` （如有符号表）
4. `xelatex example`
5. `xelatex example`

或

```
latexmk -xelatex  example.tex
```
