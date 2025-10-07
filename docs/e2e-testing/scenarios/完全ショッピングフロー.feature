---
description: "ユーザー認証から商品購入までの完全なeコマースフロー"
execute:
  - step: "ユーザー認証"
    feature: "docs/e2e-testing/features/ユーザー認証.feature"
    scenario: "@ユーザーログインデモ"
    arguments:
      test_email: "test@example.com"
      test_password: "password123"
    expect_output:
      user_session: true
      authenticated_user: "test@example.com"

  - step: "商品検索"
    feature: "docs/e2e-testing/features/商品検索とフィルタリング.feature"
    scenario: "@商品検索基本"
    arguments:
      search_term: "ヘッドフォン"
    expect_output:
      search_results: ["ワイヤレスヘッドフォン"]

  - step: "単一商品をカートに追加"
    feature: "docs/e2e-testing/features/ショッピングカート管理.feature"
    scenario: "@カート単一商品追加"
    arguments:
      product_1: "ワイヤレスヘッドフォン"
    expect_output:
      cart_count: 1
      cart_items: ["ワイヤレスヘッドフォン"]

  - step: "複数商品をカートに追加"
    feature: "docs/e2e-testing/features/ショッピングカート管理.feature"
    scenario: "@カート複数商品追加"
    arguments:
      product_2: "スマートウォッチ"
      product_3: "コーヒーメーカー"
    expect_output:
      cart_count: 3
      cart_items: ["ワイヤレスヘッドフォン", "スマートウォッチ", "コーヒーメーカー"]

environment:
  target_url: "http://localhost:3004"
  browser: "chrome"
  headless: false

success_criteria:
  - "全てのステップが正常に完了すること"
  - "カートに3つの商品が追加されていること"
  - "各商品の価格が正しく表示されていること"
  - "カート合計金額が正確に計算されていること"
---

# 完全ショッピングフロー実行シナリオ

このシナリオは、eコマースアプリケーションの完全なユーザージャーニーをテストします：

1. **ユーザー認証**: テストアカウントでログイン
2. **商品検索**: 目的の商品を検索・発見
3. **商品選択**: 商品詳細の確認と選択
4. **カート追加**: 単一および複数商品のカート追加
5. **購入フロー**: カート確認から購入完了まで

## 実行方法

```bash
# Chrome DevTools MCP 経由で実行
/e2e-testing 完全なeコマースショッピング体験をテストしてください
```

## 期待される結果

- ✅ ユーザー認証成功
- ✅ 商品検索・発見成功
- ✅ カート機能正常動作
- ✅ 商品価格・合計計算正確
- ✅ ユーザビリティ問題なし