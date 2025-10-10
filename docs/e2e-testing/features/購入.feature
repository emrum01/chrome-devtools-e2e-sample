---
params:
  base_url: "https://staging.example.com"
  locale: "ja-JP"
---
Feature: 購入（支払い方法の切り替え）
  Background:
    前提 "<base_url>/?hl=<locale>" を開いている
    かつ テストユーザーとしてログインしている
    かつ カートに商品が1点以上入っている
  Scenario Outline: 指定の支払い方法で購入を完了する
    もし チェックアウトページを開く
    かつ 支払い方法 "<支払い方法>" を選択する
    かつ スニペット "fillCardForm" を実行してカード情報を入力する
    かつ "注文を確定する" をクリックする
    ならば "注文が完了しました" が表示されていること
    かつ API "POST /api/orders" が ステータス201 で完了していること
  @クレジットカード
  Examples: クレジットカード決済
    | 支払い方法 |
    | credit_card |
  @ペイパル
  Examples: ペイパル決済
    | 支払い方法 |
    | paypal |
