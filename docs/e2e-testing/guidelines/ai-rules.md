# AI実行ガイドライン

## env
- `staging_url`: https://staging.example.com
- `default_user`: test-user@example.com
- `default_password`: （セキュアストレージから取得。ログ出力禁止）
- `locale`: ja-JP

## mcp
- `retries`: 3  # 通常操作の再試行上限
- `step_timeout_ms`: 30000  # 1操作あたりのタイムアウト
- `trace_on_failure`: true  # 失敗時にトレースを保存する

## policy
- すべての操作は `wait_for` による可視・可操作状態の確認後に実行する。
- ロケータは `role/name` > `data-testid` > 安定CSS の順で選定する。
- `snippets/` は通常操作が連続失敗した場合にのみ使用し、1回の失敗につき最大1度の実行とする。
- コンソールエラーと主要APIレスポンスを必ず確認し、失敗時は詳細ログを保存する。
- ステージング環境での実行を原則とし、機密値はマスクする。

## mapping
- "ログインして" → `features/認証.feature@ログイン`
- "商品をカートに入れて" → `features/カート追加.feature@カート追加`
- "クレジットカードで購入" → `features/購入.feature@クレジットカード`
- "ペイパルで支払って" → `features/購入.feature@ペイパル`
- "一気通貫で購入フロー" → `scenarios/完全購入フロー.feature@完全購入フロー`
