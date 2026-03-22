%% CAUthesis.cls
%% 中国农业大学学术学位博士学位论文LaTeX模板
%% 依据《中国农业大学研究生学位论文格式及书写规范（2025年修订）》制作
%% 编译方式：XeLaTeX -> BibTeX/Biber -> XeLaTeX -> XeLaTeX
%%
%% 说明：本模板适用于学术学位博士研究生

%% Author: ZHuo Yue
%% Email: zhuo0000yue@gmail.com
%% GitHub: github.com/Zhuoy3/cau-thesis-doctor
%% License: GPL-3.0 license
%% Last Modified: 2026/02/26

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{CAUthesis}[2025/08/13 China Agricultural University Doctoral Thesis Template]

%% ============================================================
%% 选项定义
%% ============================================================
% 目录深度开关：默认列至二级标题(tocdepth=2)，可选三级(tocdepth=3)
\newif\if@tocthree\@tocthreefalse
\DeclareOption{tocthree}{\@tocthreetrue}

% 将其他选项传递给ctexbook
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions\relax

%% ============================================================
%% 基础文档类
%% ============================================================
% 使用ctexbook作为基础类，A4纸，小四号字体(12pt)，单面排版（不镜像）
\LoadClass[a4paper, zihao=-4, oneside, openany, UTF8]{ctexbook}

%% ============================================================
%% 宏包加载
%% ============================================================
\RequirePackage[nottoc]{tocbibind}   % 将参考文献等加入目录
\RequirePackage{geometry}            % 页面布局
\RequirePackage{fancyhdr}            % 页眉页脚
\RequirePackage{titletoc}            % 目录格式
\RequirePackage{graphicx}            % 图片
\RequirePackage{booktabs}            % 三线表
\RequirePackage{caption}             % 图表标题
\RequirePackage{bicaption}           % 支持双语图表标题
\RequirePackage{amsmath}             % 数学公式
% \RequirePackage{amssymb}             % 数学符号
\RequirePackage{amsthm}              % 定理环境
\RequirePackage{unicode-math}        % Unicode数学字体（XeLaTeX）
\RequirePackage{xcolor}              % 颜色
\RequirePackage{enumitem}            % 列表环境
\RequirePackage{tabularx}            % 表格
\RequirePackage{longtable}           % 长表格（跨页）
\RequirePackage{multirow}            % 表格合并行
\RequirePackage{threeparttable}      % 自动调整表格注释宽度
\RequirePackage{makecell}            % 表格内换行和多行单元格
\RequirePackage{setspace}            % 行间距
\RequirePackage{tikz}                % 绘图（用于文武线等）
\RequirePackage{etoolbox}            % 编程工具
\RequirePackage{xparse}              % 命令定义
\RequirePackage{nomencl}             % 主要符号表
% \RequirePackage[titles]{tocloft}     % 目录格式微调
\RequirePackage{pdfpages}            % 插入PDF页面（如有需要）
\RequirePackage{hyperref}            % 超链接
\RequirePackage{cleveref}            % 智能引用

% \RequirePackage[authoryear]{gbt7714} % 使用 gbt7714 宏包，著者-出版年制，该宏包实现了 GB/T 7714-2015 标准
\RequirePackage[
  backend=biber,           % 使用 biber 后端处理数据
  style=gb7714-2015ay,       % 著者-出版年制（biblatex-gb7714-2015 默认样式）
  maxcitenames=2,
  mincitenames=1,
  gbcitelabel=quanjiao,    % 引用标签使用全角括号
]{biblatex}

%% ============================================================
%% 页面布局
%% ============================================================
% 版芯要求：左30mm，右25mm，上30mm，下25mm，页眉距23mm，页脚距18mm
\geometry{
  paper      = a4paper,
  left       = 30mm,
  right      = 25mm,
  top        = 30mm,
  bottom     = 30mm,
  headheight = 16pt,
  headsep    = 1.36mm,       % 30mm(上边距) - 23mm(页眉边距) = 7mm - 16pt(页眉高度) ≈ 1.36mm
  footskip   = 7mm,          % 25mm(下边距) - 18mm(页脚边距) = 7mm
}

%% ============================================================
%% 浮动体设置（解决图表独占一页、上下空白过大的问题）
%% ============================================================
\renewcommand{\textfraction}{0.05}      % 页面最少必须有 5% 的文字，否则允许浮动体占据整页
\renewcommand{\topfraction}{0.95}       % 页面顶部最多允许占 95% 的浮动体
\renewcommand{\bottomfraction}{0.95}    % 页面底部最多允许占 95% 的浮动体
\renewcommand{\floatpagefraction}{0.90} % 浮动页必须被占用 80% 以上才允许生成独立浮动页

%% ============================================================
%% 字体设置
%% ============================================================
% Windows系统字体设置
% 如果编译时找不到字体，请根据系统实际字体名称修改
\setmainfont{Times New Roman}  % 英文正文字体
\setsansfont{Arial}             % 英文无衬线字体（备用）
\setmonofont{Courier New}       % 英文等宽字体（备用）
% \setmathfont{Latin Modern Math}

% 中文字体由ctex自动配置（Windows下默认：宋体/黑体/楷体/仿宋）
% 如需手动指定，取消以下注释并修改：
% \setCJKmainfont{SimSun}[BoldFont=SimHei, ItalicFont=KaiTi]
% \setCJKsansfont{SimHei}
% \setCJKmonofont{FangSong}

% 定义字号命令（LaTeX中ctex已提供\zihao命令）
% 二号=22pt, 三号=16pt, 四号=14pt, 小四=12pt, 五号=10.5pt, 小五=9pt

%% ============================================================
%% 行间距设置
%% ============================================================
% 正文行间距为20磅。20磅 ≈ 20/72 inch ≈ 7.06mm
% 小四号字体(12pt)下，baselineskip = 12pt * 1.2 = 14.4pt
% 要实现20磅行距，设 \linespread = 20 / 14.4 ≈ 1.389
% \linespread{1.389}
\setstretch{1.389}

%% ============================================================
%% 章节标题格式
%% ============================================================
% 一级标题：第X章 标题名（居中，黑体，三号/16pt，段前段后1行）
% 使用中文数字："第一章"
\ctexset{
  chapter = {
    format      = \centering\heiti\zihao{3},
    nameformat  = {},
    titleformat = {},
    name        = {第,章},
    number      = \chinese{chapter},
    aftername   = \quad,
    beforeskip  = {0pt},
    afterskip   = {1\baselineskip},
    pagestyle   = fancy,
   },
  section = {
    format     = \raggedright\heiti\zihao{4},
    aftername  = \quad,
    beforeskip = {1\baselineskip},
    afterskip  = {1\baselineskip},
   },
  subsection = {
      format     = \raggedright\heiti\zihao{-4},
      aftername  = \quad,
      beforeskip = {1\baselineskip},
      afterskip  = {1\baselineskip},
    },
  subsubsection = {
      name       = {（,）},
      number     = \arabic{subsubsection},
      format     = \hspace{2\ccwd}\kaishu\zihao{-4},
      aftername  = {},
      beforeskip = {0.75\baselineskip},
      afterskip  = {0.75\baselineskip},
    },
}

%% ============================================================
%% 目录格式
%% ============================================================
% 目录深度控制
\if@tocthree
  \setcounter{tocdepth}{3}  % 显示到1.1.1
  \setcounter{secnumdepth}{3}
\else
  \setcounter{tocdepth}{2}  % 显示到1.1
  \setcounter{secnumdepth}{3} % 编号仍到三级
\fi

% 目录标题格式
% \renewcommand{\contentsname}{目\quad 录}
% \renewcommand{\listfigurename}{插图清单}
% \renewcommand{\listtablename}{附表清单}
\ctexset{
  contentsname   = {目\quad 录},
  listfigurename = {插图清单},
  listtablename  = {附表清单}
}

% 去掉目录中章条目前的额外间距，使章与节行距一致
% ctexbook默认在chapter条目前添加约1em的额外垂直间距，这里设为0
\titlecontents{chapter}
[0em]                                      % 左缩进
{\zihao{-4}\heiti}                         % 章标题字体：小四黑体
{\thecontentslabel\quad}                   % 有编号时的格式
{}                                         % 无编号时的格式
{\titlerule*[0.5pc]{.}\contentspage}       % 填充点和页码
[]                                         % 条目后（无额外间距）

\titlecontents{section}
[2em]                                      % 左缩进
{\zihao{-4}\songti}                        % 节标题字体：小四宋体
{\thecontentslabel\quad}
{}
{\titlerule*[0.5pc]{.}\contentspage}
[]

\titlecontents{subsection}
[4em]                                      % 左缩进
{\zihao{-4}\songti}                        % 小节标题字体：小四宋体
{\thecontentslabel\quad}
{}
{\titlerule*[0.5pc]{.}\contentspage}
[]

%% ============================================================
%% 页眉页脚设置
%% ============================================================

% 定义页眉灰色（与Word页眉颜色一致，约#808080）
% 如果实际颜色有偏差，请修改此处的RGB值
\definecolor{headercolor}{HTML}{808080}

% ----- 自定义文武线（上粗下细，总3磅 ≈ 1.06mm） -----
% 文武线：上方粗线约2磅(0.7mm)，下方细线约0.75磅(0.26mm)，间距约0.1mm
% 颜色为灰色 #808080
% 注意：此处为近似实现，请编译后检查效果，可微调参数
\newcommand{\WuwenLine}{%
  \color{headercolor}%
  \vbox{%
    \hrule height 0.7mm depth 0pt width \textwidth
    \vskip 0.1mm
    \hrule height 0.25mm depth 0pt width \textwidth
  }%
}

% 定义正文页眉页脚样式
% 页眉文字和文武线之间的距离通过负的 \vspace 减小
\fancypagestyle{mainmatter}{%
  \fancyhf{}%
  \fancyhead[L]{\color{headercolor}\zihao{-5}\songti 中国农业大学博士学位论文}%
  \fancyhead[R]{\color{headercolor}\zihao{-5}\songti \leftmark}%
  \fancyfoot[C]{\color{headercolor}\zihao{-5}\thepage}%
  \renewcommand{\headrulewidth}{0pt}% 去掉默认页眉线
  \renewcommand{\headrule}{\vspace{-7pt}\WuwenLine}%
  % 注：vspace{-7pt} 用于缩小页眉文字与文武线的距离
  % 如果距离仍不理想，可调整此值（负值越大距离越近）
}

% 前置部分样式：无页眉，页码居中（罗马数字）
\fancypagestyle{frontmatter}{%
  \fancyhf{}%
  \fancyfoot[C]{\color{headercolor}\zihao{-5}\thepage}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\headrule}{}%
}

% plain样式重定义（章首页自动使用plain样式）
\fancypagestyle{plain}{%
  \fancyhf{}%
  \fancyhead[L]{\color{headercolor}\zihao{-5}\songti 中国农业大学博士学位论文}%
  \fancyhead[R]{\color{headercolor}\zihao{-5}\songti \leftmark}%
  \fancyfoot[C]{\color{headercolor}\zihao{-5}\thepage}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\headrule}{\vspace{-3pt}\WuwenLine}%
}

%% ============================================================
%% 图表标题格式
%% ============================================================
% 图、表标题：五号黑体
% 按章节编号：图1-1，表2-2
\DeclareCaptionFont{wuhaoheiti}{\zihao{5}\heiti}
\captionsetup{
  font          = wuhaoheiti,
  labelsep      = space,
  figureposition = bottom,
  tableposition  = top,
  justification  = centering,
}
\captionsetup[figure]{name={图}}
\captionsetup[table]{name={表}}

\captionsetup[figure][bi-second]{name=Figure, list=no}
\captionsetup[table][bi-second]{name=Table, list=no}

% 图表按章编号
\counterwithin{figure}{chapter}
\counterwithin{table}{chapter}
\counterwithin{equation}{chapter}

% 修改编号分隔符为连字符：图1-1（而非图1.1）
\renewcommand{\thefigure}{\thechapter-\arabic{figure}}
\renewcommand{\thetable}{\thechapter-\arabic{table}}
% \renewcommand{\theequation}{\thechapter-\arabic{equation}}

%% ============================================================
%% 公式格式
%% ============================================================
% 公式居中对齐，编号右对齐（amsmath默认行为）
% 公式编号格式：公式（章-序号），如 公式（2-1）
\renewcommand{\theequation}{\thechapter-\arabic{equation}}

% 在编号前添加"公式"二字，使用小括号
% 最终显示效果：公式（2-1）
\def\tagform@#1{\maketag@@@{公式（\ignorespaces#1\unskip\@@italiccorr）}}

%% ============================================================
%% 公式引用命令
%% ============================================================
% 使用 \eqnref{label} 引用公式，显示为"公式（2-1）"
\newcommand{\eqnref}[1]{公式（\ref{#1}）}

%% ============================================================
%% cleveref 智能引用中文配置
%% ============================================================
% 基础环境名称替换
\crefname{figure}{图}{图}
\crefname{table}{表}{表}
\crefname{chapter}{第}{第}
\crefname{section}{节}{节}
\crefname{subsection}{小节}{小节}
\crefname{subsubsection}{小节}{小节}
\crefname{equation}{公式}{公式}

% 针对图、表取消默认的空格（英文通常是 fig. 1，中文不需要空格即 图1）
\crefformat{figure}{#2图#1#3}
\crefformat{table}{#2表#1#3}

% 公式的特殊格式：添加全角括号
\crefformat{equation}{#2公式（#1）#3}
% 如果需要引用多个公式，例如 \cref{eq:1,eq:2}，也需要定义复数格式（按需添加）
\crefmultiformat{equation}{#2公式（#1）#3}{ 和 #2（#1）#3}{、#2（#1）#3}{ 和 #2（#1）#3}

% 章节引用：输出为“第1章”、“第1.1节”、“第1.1.1节”
\crefformat{chapter}{#2第#1章#3}
\crefformat{section}{#2第#1节#3}
\crefformat{subsection}{#2第#1小节#3}
\crefformat{subsubsection}{#2第#1小节#3}
\newcommand{\creft}[1]{\cref{#1}“\nameref{#1}”}

%% ============================================================
%% 三线表支持
%% ============================================================
% booktabs 已加载，直接使用 \toprule, \midrule, \bottomrule
% 顶线和底线 1.5磅 ≈ 0.53mm，栏目线 0.75磅 ≈ 0.26mm
\setlength{\heavyrulewidth}{0.53mm}  % \toprule, \bottomrule 粗线
\setlength{\lightrulewidth}{0.26mm}  % \midrule 细线
\setlength{\cmidrulewidth}{0.26mm}   % \cmidrule 辅助线

%% ============================================================
%% 主要符号表（nomenclature）
%% ============================================================
\makenomenclature
\renewcommand{\nomname}{主要符号表}

%% ============================================================
%% 封面变量定义
%% ============================================================
\newcommand{\cau@classno}{}      % 分类号
\newcommand{\cau@secretlevel}{}  % 密级
\newcommand{\cau@studentid}{}    % 学号
\newcommand{\cau@titlecn}{}      % 中文题目
\newcommand{\cau@titleen}{}      % 英文题目
\newcommand{\cau@author}{}       % 研究生姓名
\newcommand{\cau@supervisor}{}   % 指导教师
\newcommand{\cau@cosupervisor}{} % 合作指导教师
\newcommand{\cau@degreetype}{}   % 申请学位门类级别
\newcommand{\cau@major}{}        % 专业名称
\newcommand{\cau@research}{}     % 研究方向
\newcommand{\cau@college}{}      % 所在学院
\newcommand{\cau@date}{}         % 日期

% 用户接口命令
\newcommand{\classno}[1]{\renewcommand{\cau@classno}{#1}}
\newcommand{\secretlevel}[1]{\renewcommand{\cau@secretlevel}{#1}}
\newcommand{\studentid}[1]{\renewcommand{\cau@studentid}{#1}}
\newcommand{\titlecn}[1]{\renewcommand{\cau@titlecn}{#1}}
\newcommand{\titleen}[1]{\renewcommand{\cau@titleen}{#1}}
\renewcommand{\author}[1]{\renewcommand{\cau@author}{#1}}
\newcommand{\supervisor}[1]{\renewcommand{\cau@supervisor}{#1}}
\newcommand{\cosupervisor}[1]{\renewcommand{\cau@cosupervisor}{#1}}
\newcommand{\degreetype}[1]{\renewcommand{\cau@degreetype}{#1}}
\newcommand{\major}[1]{\renewcommand{\cau@major}{#1}}
\newcommand{\research}[1]{\renewcommand{\cau@research}{#1}}
\newcommand{\college}[1]{\renewcommand{\cau@college}{#1}}
\renewcommand{\date}[1]{\renewcommand{\cau@date}{#1}}

%% ============================================================
%% 封面页辅助命令：生成固定宽度的下划线
%% ============================================================
\newcommand{\cau@infofield}[1]{\underline{\makebox[12em]{\hfill#1\hfill}}}

%% ============================================================
%% 封面页
%% ============================================================
\newcommand{\makecover}{%
  \hbadness=10000
  \begin{titlepage}
    \thispagestyle{empty}
    \begin{center}
      % ---- 分类号、单位代码、密级、学号 ----
      \vspace*{-18pt}
      {
        \zihao{-4}\songti
        \fontsize{12pt}{12pt}\selectfont
        \makebox[4em][s]{分类号}：\underline{\makebox[6em][c]{\cau@classno}}
        \hfill
        \makebox[5em][s]{单位代码}：\underline{\makebox[8em][c]{10019}}
        \\[4pt]
        \makebox[4em][s]{密\hfill 级}：\underline{\makebox[6em][c]{\cau@secretlevel}}
        \hfill
        \makebox[5em][s]{学\hfill 号}：\underline{\makebox[8em][c]{\cau@studentid}}
        \par
      }

      \vspace{40pt}

      % ---- 校名/校徽图片占位 ----
      % TODO: 请将学校校名图片替换到此处
      % 例如: \includegraphics[width=0.6\textwidth]{cau_logo.png}
      % 当前使用文字占位
      \IfFileExists{cau_logo.png}{%
        \includegraphics[width=0.5\textwidth]{cau_logo.png}
      }{
        {\zihao{0}\heiti 中国农业大学}
      }

      \vspace{10pt}

      % ---- "博士学位论文" ----
      {
        \zihao{-2}\songti 博士学位论文
      }

      \vspace{30pt}

      % ---- 中文论文题目 ----
      {
        \zihao{2}\heiti\cau@titlecn
      }

      \vspace{10pt}

      % ---- 英文论文题目 ----
      {
        \fontsize{16pt}{24pt}\selectfont\bfseries\cau@titleen
      }

      \vspace{40pt}

      % ---- 作者信息表 ----
      % 下划线宽度统一为10em，可根据实际内容微调

      {
        \zihao{4}\songti
        \renewcommand{\arraystretch}{1.4}% 信息表行间距（从1.8减小到1.4）
        \begin{tabular}{r @{\hspace{0.5em}：\hspace{0.5em}} l}
          \makebox[8em][s]{研究生}      & \cau@infofield{\cau@author}       \\
          \makebox[8em][s]{指导教师}     & \cau@infofield{\cau@supervisor}   \\
          \makebox[8em][s]{合作指导教师}   & \cau@infofield{\cau@cosupervisor} \\
          \makebox[8em][s]{申请学位门类级别} & \cau@infofield{\cau@degreetype}   \\
          \makebox[8em][s]{专业领域名称}   & \cau@infofield{\cau@major}        \\
          \makebox[8em][s]{研究方向}     & \cau@infofield{\cau@research}     \\
          \makebox[8em][s]{所在学院}     & \cau@infofield{\cau@college}      \\
        \end{tabular}
      }

      \vfill

      % ---- 日期 ----
      {
        \zihao{4}\songti\cau@date
      }

      \vspace{20pt}
    \end{center}
  \end{titlepage}
  \clearpage
}

%% ============================================================
%% 独创性声明页
%% ============================================================
\newcommand{\makedeclaration}{%
\clearpage
\thispagestyle{empty}

\vspace*{-18pt}

\begin{center}
  {\zihao{2}\heiti 独\enspace 创\enspace 性\enspace 声\enspace 明}
\end{center}

% \vspace{20pt}

{
\zihao{-4}
\setlength{\parindent}{2em}

本人声明所呈交的学位论文是我个人在导师指导下进行的研究工作及取得的研究成果。尽我所知，除了文中已经注明引用、已经声明生成式人工智能使用情况和致谢的内容外，论
文中不包含其他人已经发表或撰写过的研究成果，不包含使用生成式人工智能直接生成的内容，也不包含本人为获得中国农业大学或其他教育机构的学位或证书而使用过的材料。
与我一同工作的同志对本研究所做的任何贡献均已在论文中作了明确的说明并表达了谢意。

\vspace{25pt}

\noindent
学位论文作者签名：{\makebox[6em]{}}
\hfill
时间：{\makebox[3em]{}}年{\makebox[2em]{}}月{\makebox[2em]{}}日
}

\vspace{60pt}

\begin{center}
  {\zihao{2}\heiti 关于学位论文使用授权的说明}
\end{center}

% \vspace{20pt}

{
\zihao{-4}
\setlength{\parindent}{2em}

本人完全了解中国农业大学有关保留、使用学位论文的规定。本人同意中国农业大学有权保存及向国家有关部门和机构送交论文的纸质版和电子版，允许论文被查阅和借阅。

\vspace{5pt}

\textbf{（保密的学位论文在解密后应遵守此协议）}

\vspace{50pt}

\noindent
学位论文作者签名：{\makebox[6em]{}}
\hfill
时间：{\makebox[3em]{}}年{\makebox[2em]{}}月{\makebox[2em]{}}日

\vspace{30pt}

\noindent
导师签名：{\makebox[6em]{}}
\hfill
时间：{\makebox[3em]{}}年{\makebox[2em]{}}月{\makebox[2em]{}}日
}

\clearpage
}

%% ============================================================
%% 中文摘要环境
%% ============================================================
\newenvironment{abstractcn}{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{\texorpdfstring{摘\quad 要}{摘 要}}
  \chapter*{\zihao{3}\heiti 摘\quad 要}
  \zihao{-4}
  \setlength{\parindent}{2em}
}{%
  \par
}

\newcommand{\keywordscn}[1]{%
  \vspace{10pt}
  \noindent{\zihao{4}\heiti 关键词：}{\zihao{-4}\songti #1}
}

%% ============================================================
%% 英文摘要环境
%% ============================================================
\newenvironment{abstracten}{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{Abstract}
  \chapter*{\zihao{3}\bfseries Abstract}
  \zihao{-4}
  \setlength{\parindent}{2em}
}{%
  \par
}

\newcommand{\keywordsen}[1]{%
  \vspace{10pt}
  \noindent{\zihao{4}\bfseries Key words: }{\zihao{-4} #1}
}

%% ============================================================
%% 致谢环境
%% ============================================================
\newenvironment{acknowledgements}{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{\texorpdfstring{致\quad 谢}{致 谢}}
  \chapter*{\zihao{3}\heiti 致\quad 谢}
  \zihao{-4}
  \setlength{\parindent}{2em}
}{%
  \par
  \clearpage
}

%% ============================================================
%% 作者简介环境
%% ============================================================
\newenvironment{authorinfo}{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{作者简介}
  \chapter*{\zihao{3}\heiti 作者简介}
  \zihao{-4}
  \setlength{\parindent}{2em}
}{%
  \par
  \clearpage
}

%% ============================================================
%% 插图和附表清单页
%% ============================================================
\newcommand{\makelistoffiguresandtables}{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{插图和附表清单}
  \chapter*{\zihao{3}\heiti 插图和附表清单}

   % 插图清单
   {\zihao{-4}\heiti 插图清单}
  \vspace{5pt}

  \@starttoc{lof}

  \vspace{20pt}

  % 附表清单
  {\zihao{-4}\heiti 附表清单}
  \vspace{5pt}

  \@starttoc{lot}

  \clearpage
}

%% ============================================================
%% 主要符号表页
%% ============================================================
% 使用 nomencl 宏包，编译时需运行 makeindex main.nlo -s nomencl.ist -o main.nls
\newcommand{\makesymboltable}{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{主要符号表}
  \printnomenclature
  \clearpage
}

%% ============================================================
%% 附录格式
%% ============================================================
% 附录用大写字母编号：附录A，附录B...
% 使用方法：\appendix 后用 \chapter{} 即可
% ctex会自动将附录章标题改为"附录A"等格式
\appto{\appendix}{%
  \ctexset{
    chapter = {
      name   = {附录},
      number = \Alph{chapter},
     },
  }
}

%% ============================================================
%% 参考文献设置
%% ============================================================
% \renewcommand{\bibname}{参考文献}

% 参考文献字号设为五号（10.5pt）
\renewcommand*{\bibfont}{\zihao{5}}

% 设置条目之间的距离
\setlength{\bibitemsep}{0pt}      % 条目之间不留额外垂直间距
\setlength{\bibnamesep}{0pt}
\setlength{\bibparsep}{0pt}
\setstretch{1.25}                 % 参考文献内部建议使用约1.25倍行距（对应五号字的紧凑排版）

%% ============================================================
%% 超链接设置
%% ============================================================
\hypersetup{
  colorlinks  = true,
  linkcolor   = black,
  citecolor   = black,
  urlcolor    = black,
  bookmarksnumbered = true,
  bookmarksopen     = true,
  pdfstartview      = FitH,
}

%% ============================================================
%% 列表环境设置
%% ============================================================

\setlist[enumerate]{
  itemindent=0pt,
  leftmargin=4\ccwd,
  itemsep=0pt,
  parsep=0pt,
  topsep=0pt
}

%% ============================================================
%% 前置部分与正文部分切换命令
%% ============================================================
\renewcommand{\frontmatter}{%
  \clearpage
  \@mainmatterfalse
  \pagenumbering{Roman}  % 罗马数字页码
  \pagestyle{frontmatter}
}

\renewcommand{\mainmatter}{%
  \clearpage
  \@mainmattertrue
  \pagenumbering{arabic}  % 阿拉伯数字页码
  \pagestyle{mainmatter}
}

\renewcommand{\backmatter}{%
  \clearpage
  \@mainmatterfalse
  \pagestyle{mainmatter}  % 后置部分继续使用正文页眉
}

%% ============================================================
%% 结束
%% ============================================================
\endinput
