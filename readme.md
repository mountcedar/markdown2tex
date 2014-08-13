## はじめに

このプロジェクトは簡単なレポートをmarkdown形式で記述し、その内容をtexの2カラムa4paperに変換するサンプルです。
markdown形式で報告を記述することで、ドキュメント作成の手間を大幅にカットすることができると考えられます。

## サポートする環境

このプロジェクトは以下の環境で動作が確認されています。

* ubuntu12.04
* Mac OS X Mavericks

## 準備

まず、必要なパッケージをインストールします。

```
$ sudo apt-get install ptex-bin pandoc nkf
```

## 原稿の作り方

以下の2つの手順を踏むだけです．

1. contents.mdを編集
2. makeを実行

### contents.mdの編集

マークダウン形式で内容を書くだけです。以下に例を示します．

```
# はじめに

これはテストです。書式はgithubのmarkdownを採用しています。

# いろいろな書式

## subsection的な

* 箇条書きも対応してほしい
* itemizeとか毎回書くのまじでしんどい
    * 入れ子とかもサポートしてくれると良いよね

### subsubsection的な

1. もちろん、数字のサポートも必須でしょ
    * 違うアイテマイズの入れ子ももちろんサポートするよね

# リンク関係

[リンクはどうなるの？](http://localhost)

![画像とかはどうなるの？](sample.png)

# 文字書式

* これはイタリック体です*
* _これもイタリック体です_
* これはイタリック体になりません
* **これは太字です**
* __これも太字です__

> 引用はどうなるんだろう

# 表はどうなる

|カラム1|カラム2|
|------|------|
|hoge|geho|
```

これをmakeにかけると以下のようなtex形式に変換してくれます。

```
\section{はじめに}\label{はじめに}

これはテストです。書式はgithubのmarkdownを採用しています。

\section{いろいろな書式}\label{いろいろな書式}

\subsection{subsection的な}\label{subsection的な}

\begin{itemize}
\itemsep1pt\parskip0pt\parsep0pt
\item
  箇条書きも対応してほしい
\item
  itemizeとか毎回書くのまじでしんどい

  \begin{itemize}
  \itemsep1pt\parskip0pt\parsep0pt
  \item
    入れ子とかもサポートしてくれると良いよね
  \end{itemize}
\end{itemize}

\subsubsection{subsubsection的な}\label{subsubsection的な}

\begin{enumerate}
\def\labelenumi{\arabic{enumi}.}
\itemsep1pt\parskip0pt\parsep0pt
\item
  もちろん、数字のサポートも必須でしょ

  \begin{itemize}
  \itemsep1pt\parskip0pt\parsep0pt
  \item
    違うアイテマイズの入れ子ももちろんサポートするよね
  \end{itemize}
\end{enumerate}

\section{リンク関係}\label{リンク関係}

\href{http://localhost}{リンクはどうなるの？}

\begin{figure}[htbp]
\centering
\includegraphics{sample.png}
\caption{画像とかはどうなるの？}
\end{figure}

\section{文字書式}\label{文字書式}

\begin{itemize}
\itemsep1pt\parskip0pt\parsep0pt
\item
  これはイタリック体です*
\item
  \emph{これもイタリック体です}
\item
  これはイタリック体になりません
\item
  \textbf{これは太字です}
\item
  \textbf{これも太字です}
\end{itemize}

\begin{quote}
引用はどうなるんだろう
\end{quote}

\section{表はどうなる}\label{表はどうなる}

\begin{longtable}[c]{@{}ll@{}}
\hline\noalign{\medskip}
カラム1 & カラム2
\\\noalign{\medskip}
\hline\noalign{\medskip}
hoge & geho
\\\noalign{\medskip}
\hline
\end{longtable}
```

数式など、tex固有の形式を使いたい場合は、その部分だけtexの記法を使えばそのまま反映されます。

上記の書式で、contents.mdを編集して、最後にコマンドラインからmakeを実行します。すると、contents.mdをtexに変換するスクリプトが実行され、manuscript.pdfという名前で整形された文書が生成されます。

```
$ make
—
$ make clean all
```

## 仕組み

markdown形式から、tex形式への変換は以下の手順で行います。

* pandocを用いたcontents.mdから、contents.texへの変換
	* sedでいくつかの表現を置換しています
* manuscript.texからcontents.texを読み込み
* platexでmanuscript.texをコンパイル
* dvipdfmxでmanuscript.dviをmanuscript.pdfに変換

## 生成物

結果として、manuscript.pdfが得られます。途中で失敗すると、manuscript.dviまでしか出てこないことがあります。