機能: UI操作ベストプラクティス
  信頼性の高いUI自動化のためのベストプラクティスと実証済みパターン

  背景: Chrome DevTools MCP 操作パターン
    前提 Chromeブラウザがウェブアプリケーションにアクセスしている

  @ドロップダウン基本
  シナリオ: ドロップダウン（select要素）操作 - 基本パターン
    # 一部のドロップダウンでは標準的なfillやclickが機能しない場合がある
    もし ドロップダウン/select要素で値を設定する場合
    ならば 信頼性の高い選択のためevaluate_scriptを使用する:
      """
      const options = document.querySelectorAll('option');
      for (let option of options) {
        if (option.textContent.trim() === '対象値') {
          option.selected = true;
          const selectElement = option.parentElement;
          const event = new Event('change', { bubbles: true });
          selectElement.dispatchEvent(event);
          return '選択肢が正常に選択されました';
        }
      }
      return '選択肢が見つかりません';
      """

  @ドロップダウン複数フィールド
  シナリオ: ドロップダウン操作 - 複数フィールド一括設定
    # ✅ 成功のアプローチ: parentElement.textContentを使用した信頼性の高いフィールド識別
    もし ダイアログまたはフォームで複数のドロップダウンを設定する場合
    ならば 一括設定パターンでevaluate_scriptを使用する:
      """
      const selects = document.querySelectorAll('select');
      const comboboxes = document.querySelectorAll('[role="combobox"]');
      const allSelects = [...selects, ...comboboxes];

      let results = [];

      allSelects.forEach((element, index) => {
        const options = element.querySelectorAll('option');
        const parentText = element.parentElement?.textContent || '';

        options.forEach(option => {
          // 例: "家電" カテゴリを選択
          if (option.textContent.includes('家電') && !element.value.includes('家電')) {
            element.value = option.value || option.textContent;
            element.selectedIndex = option.index;
            element.dispatchEvent(new Event('change', {bubbles: true}));
            element.dispatchEvent(new Event('input', {bubbles: true}));
            results.push(`カテゴリ設定: ${option.textContent}`);
          }
          // 例: "アクティブ" ステータスを選択（親要素のテキストで識別）
          else if (option.textContent.includes('アクティブ') && parentText.includes('ステータス')) {
            element.value = option.value || option.textContent;
            element.selectedIndex = option.index;
            element.dispatchEvent(new Event('change', {bubbles: true}));
            element.dispatchEvent(new Event('input', {bubbles: true}));
            results.push(`ステータス設定: ${option.textContent}`);
          }
        });
      });

      return results.length > 0 ? results : 'マッチする選択肢が見つかりません';
      """
    # ✅ 成功要因:
    # 1. フィールド識別にparentElement.textContentを使用
    # 2. selectedIndexを明示的に設定
    # 3. changeとinputイベントの両方をトリガー

  @動的フォーム段階的
  シナリオ: 動的フォームの段階的入力
    # 一つのフィールドを選択すると次のフィールドが表示される場合
    前提 動的フォームダイアログが表示されている
    もし 最初のフィールド（カテゴリ）を選択する
    ならば 2番目のフィールド（タイプ）が表示される
    もし 2番目のフィールド（タイプ）を選択する
    ならば 3番目のフィールド（ステータス）が表示される
    もし 3番目のフィールド（ステータス）を選択する
    ならば アクションボタンが有効になる
    かつ 各ステップをtake_snapshotで確認する

  @確認ダイアログ処理
  シナリオ: 確認ダイアログの適切な処理
    # 保存操作で確認ダイアログが表示される場合
    もし フォームの "保存" ボタンをクリックする
    ならば モーダル確認ダイアログが表示される
    かつ ダイアログタイトルが "変更を保存" または "確認" である
    かつ 確認メッセージが表示される
    もし ダイアログの "保存" または "OK" ボタンをクリックする
    ならば 成功メッセージが表示される
    かつ 通知タイマーが開始される

  @ページ遷移処理
  シナリオ: ページ遷移後の要素待機
    # クリックによってページナビゲーションが発生する場合
    もし リスト項目またはナビゲーションリンクをクリックする
    かつ ページ遷移が発生する
    ならば take_snapshotでページ内容を確認する
    かつ 対象要素が表示されるまで待機する
    # take_snapshotの繰り返しはwait_forより信頼性が高い

  @トラブルシューティング
  シナリオ: 操作が失敗した場合のトラブルシューティング
    前提 UI要素の操作が失敗している
    もし この順序で問題を調査する:
      | 1. take_snapshotで要素の存在を確認 |
      | 2. list_console_messagesでJavaScriptエラーを確認 |
      | 3. evaluate_scriptで直接的なDOM操作を試行 |
      | 4. 状況を記録するためのスクリーンショットを取得 |
    ならば 根本原因を特定し、適切な解決策を適用する

  @成功エラーメッセージ確認
  シナリオ: 成功/エラーメッセージの確認
    # 操作後の状態確認
    もし フォーム送信またはデータ変更操作を実行する
    ならば 以下を確認する:
      | 成功メッセージの表示 |
      | データ変更の反映 |
      | ページ状態の更新 |
    かつ take_snapshotで最終状態を記録する

  @直接URL遷移パターン
  シナリオ: 直接URL遷移パターン
    # IDを使用した特定のページへの直接アクセス
    前提 特定のリソース情報にアクセスする必要がある
    もし "/users/[userId]" 形式のURLに直接遷移する
    ならば 対象リソース詳細ページが直接開く
    かつ ナビゲーションのためのメニューをクリックする必要がない
    # 例: http://localhost:3000/users/123

  @evaluate_script戻り値改善
  シナリオ: evaluate_scriptの戻り値改善
    # JavaScript実行での成功/失敗判定の明確化
    もし evaluate_scriptでDOM操作を実行する
    ならば 成功時に具体的な結果を返す:
      """
      return '[値] 選択肢が選択されました';
      """
    かつ 失敗時に明確なエラーメッセージを返す:
      """
      return '選択肢が見つかりません';
      """
    かつ 戻り値によって実行結果の判定を可能にする

  @フォーム検証処理
  シナリオ: フォーム検証とエラーの処理
    # クライアントサイド検証への対応
    前提 検証ルールを持つフォームが表示されている
    もし 無効なデータでフォームを送信する
    ならば 検証エラーメッセージが表示される
    かつ フォームが送信されない
    もし 検証エラーを修正する
    かつ フォームを再送信する
    ならば 検証が通る
    かつ フォームが正常に送信される

  @ローディング状態管理
  シナリオ: ローディング状態と非同期操作の管理
    # 非同期操作とローディングインジケーターの処理
    前提 ユーザーが非同期操作を開始する（フォーム送信、データ取得）
    もし 操作が進行中の場合
    ならば ローディングインジケーターが表示される
    かつ インタラクティブ要素が無効化される
    もし 操作が正常に完了する
    ならば ローディングインジケーターが消える
    かつ 成功状態が表示される
    かつ インタラクティブ要素が再び有効化される