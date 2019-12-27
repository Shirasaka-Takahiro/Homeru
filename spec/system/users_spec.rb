require 'rails_helper'

RSpec.describe 'user機能', type: :system do
    before do
      @user = FactoryBot.create(:user, username: 'userA', email: 'userA@example.com', password: 'password', password_confirmation: 'password') #ユーザーの作成

      visit user_session_path #ログイン画面に移動
      fill_in 'メールアドレス', with: 'userA@example.com' # メールアドレスを埋める
      fill_in 'パスワード', with: 'password' # パスワードを埋める
      click_button 'ログイン' # ログインする
      expect(page).to have_content 'ログインしました' #ログインに成功する
    end

    it '新規登録する' do
        click_link 'ログアウト' # ログアウトする
        expect(page).to have_content 'ログアウトしました' # ログアウトの確認
        click_link '新規登録' # 新規登録ボタンをおす
        fill_in 'user_username', with: 'pokepoke' # 名前
        fill_in 'user_email', with: 'poke@example.com' # メールアドレス
        fill_in 'user_password', with: 'password1' # パスワード
        fill_in 'user_password_confirmation', with: 'password1' # 確認用パスワード
        click_button 'アカウント登録' # アカウント登録ボタン
        expect(page).to have_content 'アカウント登録が完了しました。' # アカウント登録確認画面が表示される
    end
     

end