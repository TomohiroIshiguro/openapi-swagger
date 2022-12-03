# RESTful API の仕様書を OpenAPI のフォーマットで書く

API 仕様書を OpenAPI のフォーマットで記述して、Web ブラウザで参照できます。使用するツールは Swagger です。  
同時に、記述した仕様書から API モックサーバも構築できます。使用するツールは Prism です。

ローカル環境でサーバーを構築する時は Docker を使用します。コマンドは Makefile を参考にしてください。

## OpenAPI とは: 参考資料

フォーマット

- OpenAPI
    - Intro. https://oai.github.io/Documentation/introduction.html
    - Syntax https://swagger.io/docs/specification/basic-structure/

ツール

- Swagger
    - UI (仕様書のビューア) https://swagger.io/tools/swagger-ui/
    - Editor (仕様書のオンラインエディタ) https://swagger.io/tools/swagger-editor/
- Prism
    - Mock (仕様書から API mock を自動構築) https://stoplight.io/open-source/prism

## ローカル環境

このリポジトリには下記のファイルが含まれています。

```
|_ README.md
|_ Makefile ... このリポジトリにおけるコマンドのエイリアス
|_ src/     ... 編集用のファイル (コンテナ構築の度にファイルを結合して dest/openapi.yaml を更新する)
|    |_ openapi.yaml
|    |_ common
|    |    |_ info.yaml
|    |    |_ servers.yaml
|    |_ paths
|    |    |_ _index.yaml
|    |_ components/schemas/
|         |_ _index.yaml
|_ dest/     ... 仕様書 (ビューア、API モックサーバがロードするファイル)
     |_ openapi.yaml
```

### 作業の準備

- Docker Desktop
- VSCode (OpenAPI Editor 拡張を追加, ローカルで yaml を編集する場合のみ)

### サーバ構築手順

- Makefile がある階層で `$ make viewer` を実行してください。詳しくは Makefile を参照。

### コンテナを破棄手順

- Makefile がある階層で `$ make down` を実行してください。詳しくは Makefile を参照。

## 備考

- src/openapi.yaml を編集する時は以下の 2 通りの手段があります。
    - yaml を直接編集する方法 (VSCode に OpenAPI Editor 拡張を追加するのがオススメ、リアルタイムでプレビュー表示しながら編集できます)
    - オンラインエディタで編集してから、メニューの File > Save as Yaml でダウンロードして openapi.yaml を置き換える方法 (非推奨)
        - Swagger Editor は OpenAPI のフォーマットに慣れていない頃の入門としては活躍します。オンライエディタのメニュー Insert で、追加したい項目をフォームから追加できるため。

以上
