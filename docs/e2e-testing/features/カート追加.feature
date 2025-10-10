---
params:
  base_url: "https://staging.example.com"
  locale: "ja-JP"
---
Feature: カート追加（単品商品）
  Background:
    前提 "<base_url>/?hl=<locale>" を開いている
    かつ テストユーザーとしてログインしている
  Scenario Outline: 指定した商品をカートへ追加する
    もし 商品一覧ページを開く
    かつ 商品 "<商品名>" の詳細ページを開く
    かつ "カートに追加" をクリックする
    ならば カートアイコンに数量 "<数量>" が表示されていること
    かつ API "POST /api/cart" が ステータス201 で完了していること
  @カート追加
  Examples: 標準商品
    | 商品名       | 数量 |
    | basic-plan   | 1    |
    | starter-pack | 1    |
