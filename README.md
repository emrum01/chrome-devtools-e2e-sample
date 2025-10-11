# Chrome DevTools E2E テストサンプル

Claude Code と Chrome DevTools MCP を組み合わせ、**「E2E テストは AI に頼むだけ」**という体験を紹介するサンプルリポジトリです。Zenn 記事「[動作確認は面倒なので Claude CodeとChrome DevTools MCPにやってもらいましょう](https://zenn.dev/emrum/articles/ai-driven-e2e-claude-code-chrome-devtools-mcp)」で解説している構成をそのまま再現しています。

> 🧩 **目的**
> - Claude Code から `/e2e-chrome-devtools-mcp` コマンドを 1 行呼び出すだけで、AI がブラウザを起動してシナリオを解釈・実行・検証するワークフローを確認できます。
> - 日本語 Gherkin で記述したシナリオを、Chrome DevTools MCP が提供する実ブラウザ制御と組み合わせて動かします。

## 📦 リポジトリ構成

```
chrome-devtools-e2e-sample/
├── src/app/                    # Next.js デモアプリ (認証 / 商品カタログ / カート / 管理画面)
├── docs/e2e-testing/
│   ├── RUNBOOK.md              # Claude Code が最初に読む実行台本
│   ├── OVERVIEW.md             # ドキュメント群の意図と連携を解説
│   ├── guidelines/ai-rules.md  # 環境・ポリシー・自然言語マッピング
│   ├── features/               # 日本語 Gherkin の機能テスト
│   │   ├── 認証.feature
│   │   ├── カート追加.feature
│   │   └── 購入.feature        # @ペイパル / @クレジットカード などのタグを保持
│   ├── scenarios/完全購入フロー.feature
│   └── snippets/fillCardForm.js
├── .claude/commands/e2e-chrome-devtools-mcp.md
├── .mcp.json                   # Chrome DevTools MCP の実行設定
└── README.md
```

## ⚙️ セットアップ

```bash
# リポジトリを取得
git clone https://github.com/emrum01/chrome-devtools-e2e-sample.git
cd chrome-devtools-e2e-sample

# 依存関係をインストール
pnpm install

# Next.js デモアプリを起動 (必要に応じて)
pnpm dev
```

Chrome DevTools MCP サーバーを `.mcp.json` で登録します。Claude Code の `claude_desktop_config.json` に下記のような設定を追加しておけば、ローカルでブラウザを自動起動できます。

```json
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "npx",
      "args": ["-y", "chrome-devtools-mcp", "--isolated"]
    }
  }
}
```

`.claude/commands/e2e-chrome-devtools-mcp.md` は 1 行だけのカスタムコマンドです。

```
docs/e2e-testing/RUNBOOK.md を読み込んでその中身を実行する
```

これを呼び出すと Claude Code が RUNBOOK → ガイドライン → feature/scenario の順に読み込み、自然言語の指示をテストケースへ自動的にマッピングします。

## 🧭 RUNBOOK 駆動の 5 ステップフロー

記事と同じく、E2E 実行は次の 5 つの段階で進みます。

1. **自然言語で指示**: 例 `/e2e-chrome-devtools-mcp "ペイパルで購入して"`
2. **RUNBOOK 読み込み**: 目的・前提・成功条件・フォールバック方針を把握
3. **ai-rules 適用**: `guidelines/ai-rules.md` の `env` / `policy` / `mapping` を読み込む
4. **feature 実行**: 日本語 Gherkin に従ってクリック・入力・待機・検証を繰り返す
5. **結果確認**: スナップショット・コンソール・API レスポンスをチェックし、必要に応じて `snippets/` のフォールバックを 1 度だけ利用

## 🧪 収録シナリオ

| 種別 | 説明 | 呼び出し例 |
|------|------|------------|
| 認証.feature @ログイン | メール/パスワードでのログインとセッション確認 | 「ログインして」 |
| カート追加.feature @カート追加 | 商品検索とカート投入の操作 | 「商品をカートに入れて」 |
| 購入.feature @ペイパル / @クレジットカード | 支払い手段を切り替えて購入完了を検証 | 「ペイパルで支払って」 |
| scenarios/完全購入フロー.feature @完全購入フロー | 認証 → 検索 → カート → 支払いを一気に実行 | 「一気通貫で購入フロー」 |

## 👤 テストアカウント

```
顧客:    test@example.com / password123
管理者:  admin@example.com / admin123
マネージャー: manager@example.com / manager123
```

## 📚 参考リンク

- 記事本編: [動作確認は面倒なので Claude CodeとChrome DevTools MCPにやってもらいましょう](https://zenn.dev/emrum/articles/ai-driven-e2e-claude-code-chrome-devtools-mcp)
- Chrome DevTools MCP 公式リポジトリ: <https://github.com/ChromeDevTools/chrome-devtools-mcp>
- Gherkin リファレンス: <https://cucumber.io/docs/gherkin/reference/>

記事内で紹介されたフロー・フォールバック戦略・自然言語マッピングは `docs/e2e-testing/` 以下に全て収録しています。RUNBOOK を起点に辿っていただければ、Claude Code がどのようにシナリオを選定しブラウザを操作しているかをそのまま再現できます。
