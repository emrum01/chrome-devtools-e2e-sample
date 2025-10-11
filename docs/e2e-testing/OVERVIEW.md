# AI駆動E2Eドキュメントの見取り図

Zenn 記事「[動作確認は面倒なので Claude CodeとChrome DevTools MCPにやってもらいましょう](https://zenn.dev/emrum/articles/ai-driven-e2e-claude-code-chrome-devtools-mcp)」で紹介した「AI に動作確認を丸ごと任せる」構成を、`docs/e2e-testing/` 以下にドキュメントとして閉じ込めています。本書では RUNBOOK を中心に、ガイドライン・Gherkin シナリオ・フォールバックをどう連携させているかを俯瞰します。

## 📚 ドキュメント構成

```
docs/e2e-testing/
├─ RUNBOOK.md                 # Claude Code が最初に読む台本
├─ OVERVIEW.md                # (本書) 役割分担と導線の説明
├─ guidelines/
│   └─ ai-rules.md            # 環境・ポリシー・自然言語マッピング
├─ features/                  # 単機能の日本語 Gherkin
├─ scenarios/                 # ユーザージャーニーを束ねるシナリオ
└─ snippets/                  # 失敗時のフォールバックスクリプト
```

各フォルダは「RUNBOOK → ai-rules → feature/scenario → snippets」という 5 ステップフローをそのまま辿れるように整理されています。

## 🧭 RUNBOOK.md — 5 ステップフローの起点

記事で示したフローをそのまま文字化したのが RUNBOOK です。

1. **ガイドライン読込**: `guidelines/ai-rules.md` の `env` / `policy` / `mapping` を適用
2. **対象特定**: 利用者の自然言語を mapping から `feature@tag`・`scenario` に変換
3. **前処理**: 認証状態や初期データを整備
4. **ケース実行**: 待機・クリック・入力・検証を日本語 Gherkin に従って進める
5. **結果確認**: スナップショット・コンソール・API を評価し、必要なら snippets を 1 回だけ実行

「E2E テストは頼むだけ」という体験を再現するため、AI が迷わず同じルートを辿れるよう順路・成功条件・フォールバック条件を一か所で宣言しています。

## 🧠 guidelines/ai-rules.md — 自然言語からシナリオへ

- `env` にはステージング URL や既定ユーザーなど、毎回参照する値だけを掲載。
- `policy` ではロケータ戦略・待機・ログ収集・ `snippets/` の使用制限を明文化。
- `mapping` では「ペイパルで支払って」→ `features/購入.feature@ペイパル` のように自然言語とタグをひも付けています。

RUNBOOK はこのファイルを必ず読み込み、記事にある「自然言語 → feature@tag マッピング」を実現します。

## ✍️ features/ — 日本語 Gherkin の単機能テスト

- `params` と Background で初期状態を整え、以降のシナリオが安定するように設計。
- 重要ステップではスナップショット取得や API レスポンス確認を盛り込み、AI が自己評価できるようにしています。
- `@ログイン` や `@ペイパル` といったタグを付けて、自然言語からダイレクトに指定できるようにしました。

## 🧩 scenarios/ — ジャーニーを束ねる

`scenarios/完全購入フロー.feature` のように、複数の feature を `feature "../features/<name>.feature"` で呼び出します。これにより、記事で紹介している「認証 → 検索 → カート → 支払い」の長尺フローを 1 つのシナリオで追体験できます。

## 🛟 snippets/ — 最後の 1 手

`fillCardForm.js` などのスニペットは、通常操作がリトライ上限を超えて失敗したときだけ呼び出すフォールバックです。RUNBOOK / ai-rules の両方で使用条件を明示し、AI がむやみにスニペット頼みにならないよう制御しています。

## ✅ 設計チェックリスト

- RUNBOOK が唯一の実行起点になっているか
- ai-rules の `mapping` が日本語指示と一致しているか
- feature / scenario がタグと相対パスで相互参照できるか
- snippets がフォールバックとしてだけ利用されるよう文書化されているか

このチェックが満たされていれば、記事で紹介した「入力 → 状態確認 → 再入力」のループや `evaluate_script` / `snippets` のフォールバックも含めて、Claude Code が同じ振る舞いを再現できます。
