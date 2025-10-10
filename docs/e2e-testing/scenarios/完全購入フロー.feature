---
params:
  base_url: "https://staging.example.com"
  locale: "ja-JP"
---
Feature: 完全購入フロー
  Scenario: 新規ログインから購入完了までを通しで確認する
    前提 RUNBOOK を読み guidelines を適用済みである
    かつ "<base_url>/?hl=<locale>" を開いている
    もし feature "../features/認証.feature" のシナリオ @ログイン を実行する
    かつ feature "../features/カート追加.feature" のシナリオ @カート追加 を実行する
    かつ feature "../features/購入.feature" のシナリオ @クレジットカード を実行する
    ならば チェックアウト完了ページのスクリーンショットを保存していること
    かつ コンソールエラーが存在しないこと
  @完全購入フロー
