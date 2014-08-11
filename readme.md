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

## 仕組み

markdown形式から、tex形式への変換は以下の手順で行います。

* pandocを用いたcontents.mdから、contents.texへの変換
	* sedでいくつかの表現を置換しています
* manuscript.texからcontents.texを読み込み
* platexでmanuscript.texをコンパイル
* dvipdfmxでmanuscript.dviをmanuscript.pdfに変換

## 生成物

結果として、manuscript.pdfが得られます。途中で失敗すると、manuscript.dviまでしか出てこないことがあります。