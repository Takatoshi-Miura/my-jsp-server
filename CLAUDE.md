# my-jsp-server - Claude Code Project Context

JSP / Servlet の学習用ローカルサーバ。Gradle + Tomcat 9 で構成。

## 技術スタック

- **言語**: Java 11+、JSP 2.3、JSTL 1.2
- **パッケージ**: `javax.servlet.*`（Jakarta EE 移行前の旧系）
- **コンテナ**: Tomcat 9（`/usr/local/opt/tomcat@9/libexec/`）
- **ビルド**: Gradle 8.x（Wrapper同梱）

## プロジェクト構造

```
src/main/
├── java/com/example/        # Servlet クラス
└── webapp/
    ├── index.jsp            # トップページ
    ├── css/
    └── WEB-INF/
        ├── web.xml          # Servlet マッピング
        └── views/           # JSP（直接URLアクセス不可）
```

## よく使うコマンド

```bash
# ビルド → Tomcat へデプロイ
./gradlew deploy

# デプロイ削除
./gradlew undeploy

# Tomcat 起動
/usr/local/opt/tomcat@9/bin/catalina start

# Tomcat 停止
/usr/local/opt/tomcat@9/bin/catalina stop

# ログ確認
tail -f /usr/local/opt/tomcat@9/libexec/logs/catalina.out
```

アクセス先: `http://localhost:8080/my-app/`

## コーディング規約

- **JSP にスクリプトレット（`<% %>`）を書かない** ── EL式（`${}`）と JSTL で代替する
- 出力は必ず `<c:out value="${...}" />` を使う（XSS対策のHTMLエスケープのため）
- リクエスト処理のロジックは Servlet に書き、JSP は表示のみに徹する
- 新しい画面は `WEB-INF/views/` 配下に JSP を置き、Servlet 経由で forward する

## ファイル追加時の手順

1. `src/main/java/com/example/` に Servlet クラスを作成
2. `src/main/webapp/WEB-INF/views/` に JSP を作成
3. `web.xml` に `<servlet>` と `<servlet-mapping>` を追加
4. `./gradlew deploy` で再デプロイ（Tomcat 起動中であれば自動リロード）

## build.gradle の主要設定

- `tomcatHome`: Tomcat のインストールパス（`/usr/local/opt/tomcat@9/libexec`）
- `appName`: デプロイ時のコンテキストパス名（`my-app`）
- `deploy` タスク: WAR をビルドして webapps にコピー
- `undeploy` タスク: WAR とデプロイ済みディレクトリを削除
