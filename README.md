# my-jsp-server

JSP / Servlet の学習用ローカルサーバ。  
同一ネットワーク内のスマートフォンからもアクセスできます。

## 技術スタック

| 要素 | バージョン |
|------|-----------|
| Java | 11+ |
| Servlet API | 4.0 (javax.*) |
| JSTL | 1.2 |
| Tomcat | 9.x |
| Gradle | 8.x (Wrapper同梱) |

## ディレクトリ構成

```
src/main/
├── java/com/example/
│   └── HelloServlet.java       # サンプル Servlet
└── webapp/
    ├── index.jsp               # トップページ（ウェルカムファイル）
    ├── css/style.css
    └── WEB-INF/
        ├── web.xml             # Servlet マッピング定義
        └── views/
            └── hello.jsp       # EL式 + JSTL を使ったサンプルビュー
```

> `WEB-INF/views/` 配下の JSP はブラウザから直接アクセスできません。  
> 必ず Servlet を経由して `RequestDispatcher#forward()` で表示します。

## セットアップ

### 前提条件

- Homebrew がインストール済みであること
- Java 11 以上がインストール済みであること

### Tomcat 9 のインストール

```bash
brew install tomcat@9
```

## よく使うコマンド

### ビルドとデプロイ

```bash
# WARをビルドして Tomcat の webapps にデプロイ
./gradlew deploy

# デプロイ済みのWARとアプリを削除
./gradlew undeploy
```

### Tomcat の起動・停止

```bash
# 起動
/usr/local/opt/tomcat@9/bin/catalina start

# 停止
/usr/local/opt/tomcat@9/bin/catalina stop

# フォアグラウンドで起動（ログをターミナルに表示）
/usr/local/opt/tomcat@9/bin/catalina run
```

### 通常の開発サイクル

```bash
# コードを修正したら再ビルド＆再デプロイ
./gradlew deploy

# Tomcat はデプロイ検知して自動的にアプリを再ロードします
```

## アクセス方法

### ブラウザ（Mac本体）

```
http://localhost:8080/my-app/
```

### スマートフォン（同一Wi-Fi接続時）

```
http://<MacのローカルIP>:8080/my-app/
```

MacのローカルIPは以下で確認できます：

```bash
ipconfig getifaddr en0
```

## ルーティング

| URL | 処理 |
|-----|------|
| `/my-app/` | `index.jsp` を表示 |
| `/my-app/hello` | `HelloServlet` → `WEB-INF/views/hello.jsp` を表示 |

## Tomcat のログ

```bash
tail -f /usr/local/opt/tomcat@9/libexec/logs/catalina.out
```

## 新しい画面を追加する手順

1. `HelloServlet.java` を参考に Servlet クラスを `src/main/java/com/example/` に作成
2. `src/main/webapp/WEB-INF/views/` に JSP ファイルを作成
3. `web.xml` に Servlet とURLのマッピングを追加
4. `./gradlew deploy` で再デプロイ

## JSP 記述のポイント

```jsp
<%-- EL式でデータを出力（スクリプトレット不使用） --%>
<c:out value="${message}" />

<%-- スクリプトレット（非推奨） --%>
<%= request.getAttribute("message") %>
```

- `<c:out>` はHTMLエスケープを自動で行うため XSS 対策になります
- スクリプトレット（`<% %>`）は可読性・保守性の低下につながるため使用しないことを推奨します
- EL式（`${}`）と JSTL（`<c:if>`, `<c:forEach>` 等）を組み合わせて記述します
