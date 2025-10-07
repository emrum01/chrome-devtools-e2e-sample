---
description: "UI操作ベストプラクティスの信頼性を検証するテストシナリオ"
execute:
  - step: "ドロップダウン基本操作テスト"
    feature: "docs/e2e-testing/features/UI操作ベストプラクティス.feature"
    scenario: "@ドロップダウン基本"
    arguments:
      target_value: "家電"
    expect_output:
      operation_results: ["選択肢が正常に選択されました"]

  - step: "複数フィールド一括設定テスト"
    feature: "docs/e2e-testing/features/UI操作ベストプラクティス.feature"
    scenario: "@ドロップダウン複数フィールド"
    arguments:
      category_value: "家電"
      status_value: "アクティブ"
    expect_output:
      operation_results: ["カテゴリ設定: 家電", "ステータス設定: アクティブ"]
      best_practices_applied: true

  - step: "動的フォーム段階的入力テスト"
    feature: "docs/e2e-testing/features/UI操作ベストプラクティス.feature"
    scenario: "@動的フォーム段階的"
    expect_output:
      form_steps_completed: true

  - step: "確認ダイアログ処理テスト"
    feature: "docs/e2e-testing/features/UI操作ベストプラクティス.feature"
    scenario: "@確認ダイアログ処理"
    expect_output:
      dialog_handled: true
      success_message_displayed: true

  - step: "ページ遷移処理テスト"
    feature: "docs/e2e-testing/features/UI操作ベストプラクティス.feature"
    scenario: "@ページ遷移処理"
    expect_output:
      page_transition_handled: true
      target_elements_visible: true

  - step: "フォーム検証処理テスト"
    feature: "docs/e2e-testing/features/UI操作ベストプラクティス.feature"
    scenario: "@フォーム検証処理"
    expect_output:
      validation_errors_handled: true
      form_submitted_successfully: true

  - step: "ローディング状態管理テスト"
    feature: "docs/e2e-testing/features/UI操作ベストプラクティス.feature"
    scenario: "@ローディング状態管理"
    expect_output:
      loading_indicators_managed: true
      async_operations_completed: true

environment:
  target_url: "http://localhost:3004"
  browser: "chrome"
  headless: false

success_criteria:
  - "全てのドロップダウン操作が成功すること"
  - "動的フォームの段階的入力が正常に動作すること"
  - "確認ダイアログが適切に処理されること"
  - "ページ遷移が安全に処理されること"
  - "フォーム検証エラーが正しく処理されること"
  - "非同期操作のローディング状態が管理されること"
  - "全ての操作でベストプラクティスが適用されること"

troubleshooting:
  enabled: true
  steps:
    1: "take_snapshot で要素の存在確認"
    2: "list_console_messages で JavaScript エラー確認"
    3: "evaluate_script で直接 DOM 操作試行"
    4: "スクリーンショット取得で状況記録"

performance_monitoring:
  - "Network requests の監視"
  - "React コンポーネント読み込み状態の確認"
  - "DOM 要素安定性の検証"
---

# UI操作信頼性テスト実行シナリオ

このシナリオは、Chrome DevTools MCP でのUI操作の信頼性を包括的にテストします：

## テストカバレッジ

### 1. ドロップダウン操作
- 基本的な select 要素操作
- 複数フィールドの一括設定
- combobox 要素の処理

### 2. 動的UI処理
- 段階的に表示されるフォーム要素
- 条件付きで有効化されるボタン
- リアルタイムバリデーション

### 3. ダイアログ処理
- モーダル確認ダイアログ
- 成功/エラー通知
- 通知タイマーの管理

### 4. 状態管理
- ページ遷移時の要素待機
- フォーム検証状態の処理
- 非同期操作のローディング管理

## 実行方法

```bash
# Chrome DevTools MCP 経由で実行
/e2e-testing UI操作のベストプラクティスと信頼性を検証してください
```

## 期待される結果

- ✅ 全てのUI操作パターンが成功
- ✅ エラーハンドリングが適切に動作
- ✅ パフォーマンス問題なし
- ✅ クロスブラウザ互換性確保
- ✅ アクセシビリティ問題なし