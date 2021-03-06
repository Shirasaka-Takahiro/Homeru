<h3>概要</h3>

写真を投稿し、褒めてもらえるアプリ

<h3>機能一覧</h3>

・画像アップロード機能
・投稿詳細機能
・ログイン、ログアウト機能(Twitterによるログイン可能)
・ユーザー登録、退会機能
・管理者機能（登録ユーザーを管理）
・ユーザー詳細機能
・お気に入り機能
・コメント機能
・ページネーション機能
・検索機能(投稿、ユーザー)
・投稿ソート機能

<h3>使用技術一覧</h3>

・Ruby on Rails -v 6.0.2
・Heroku(本番環境)
・AWS S3(画像アップロード)
・bootstrap
・carrierwave
・rmagic
・devise（認証機能）
・ominiauth-twitter
・Ajax(コメント機能)
・kaminari（ページネーション機能）
・faker
・obscenity(NGワード設定)

・環境構築 -> Virtual Box + Vagrant
・テスト -> Capybara + RSpec

<h3>工夫した点</h3>
・色を４色以上使わないなど配色を意識しました。・管理者にのみユーザー削除機能を付与しました。・NGワードを設定しました。・Twitterでログイン出来るようにしました。・縦画像を縦のまま投稿できるようにしました。