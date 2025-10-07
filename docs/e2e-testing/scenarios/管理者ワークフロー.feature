---
description: "管理者による認証からユーザー管理まての完全な管理者ワークフロー"
execute:
  - step: "管理者認証"
    feature: "docs/e2e-testing/features/ユーザー認証.feature"
    scenario: "@管理者ユーザーログイン"
    arguments:
      admin_email: "admin@example.com"
      admin_password: "admin123"
    expect_output:
      user_session: true
      authenticated_user: "admin@example.com"

  - step: "ユーザー管理リスト表示"
    feature: "docs/e2e-testing/features/管理者ユーザー管理.feature"
    scenario: "@管理者ユーザーリスト"
    expect_output:
      user_list_displayed: true

  - step: "ユーザー役割変更"
    feature: "docs/e2e-testing/features/管理者ユーザー管理.feature"
    scenario: "@管理者ユーザー役割変更"
    arguments:
      target_user: "田中太郎"
      new_role: "マネージャー"
    apply_best_practices:
      - feature: "docs/e2e-testing/features/UI操作ベストプラクティス.feature"
        scenario: "@ドロップダウン複数フィールド"
        arguments:
          category_value: "マネージャー"
    expect_output:
      user_role_changed: true
      success_message: "変更しました"

  - step: "ユーザーステータス変更"
    feature: "docs/e2e-testing/features/管理者ユーザー管理.feature"
    scenario: "@管理者ユーザーステータス変更"
    arguments:
      target_user_status: "佐藤花子"
      new_status: "アクティブ"
    apply_best_practices:
      - feature: "docs/e2e-testing/features/UI操作ベストプラクティス.feature"
        scenario: "@確認ダイアログ処理"
    expect_output:
      user_status_changed: true
      success_message: "変更しました"

  - step: "ユーザー詳細確認"
    feature: "docs/e2e-testing/features/管理者ユーザー管理.feature"
    scenario: "@管理者ユーザー詳細表示"
    arguments:
      detail_user: "山田次郎"
    expect_output:
      user_details:
        name: "山田次郎"
        email: "yamada@example.com"
        role: "マネージャー"
        status: "アクティブ"

environment:
  target_url: "http://localhost:3004"
  browser: "chrome"
  headless: false

success_criteria:
  - "管理者認証が正常に完了すること"
  - "ユーザー管理画面にアクセスできること"
  - "ユーザー役割の変更が成功すること"
  - "ユーザーステータスの変更が成功すること"
  - "ユーザー詳細情報が正しく表示されること"
  - "全ての操作で適切な成功メッセージが表示されること"

error_handling:
  - condition: "認証失敗"
    action: "テスト即座終了、ユーザー認証要求"
  - condition: "ドロップダウン操作失敗"
    action: "UI操作ベストプラクティス適用"
  - condition: "確認ダイアログ表示されない"
    action: "ページ状態確認とスクリーンショット取得"
---

# 管理者ワークフロー実行シナリオ

このシナリオは、eコマースアプリケーションの管理者機能の完全なワークフローをテストします：

1. **管理者認証**: 管理者アカウントでログイン
2. **ユーザー管理**: ユーザーリストの表示と確認
3. **役割管理**: ユーザー役割の変更操作
4. **ステータス管理**: ユーザーアクティブ状態の制御
5. **詳細確認**: ユーザー情報の詳細表示と検証

## UI操作のベストプラクティス適用

このシナリオでは以下のベストプラクティスを自動適用：

- **ドロップダウン操作**: `evaluate_script` を使用した信頼性の高い選択
- **確認ダイアログ**: モーダルダイアログの適切な処理
- **エラーハンドリング**: 各操作の失敗時の対応策

## 実行方法

```bash
# Chrome DevTools MCP 経由で実行
/e2e-testing 管理者によるユーザー管理機能をテストしてください
```

## 期待される結果

- ✅ 管理者認証成功
- ✅ ユーザー管理機能アクセス成功
- ✅ 役割変更操作成功
- ✅ ステータス変更操作成功
- ✅ 詳細情報表示成功
- ✅ UI操作の信頼性確保