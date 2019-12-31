require 'rails_helper'

RSpec.describe 'user機能', type: :system do
    before do
      FactoryBot.build(:user, username: 'userA', email: 'userA@example.com', password: 'password', password_confirmation: 'password') # user

      visit user_session_path # move to user_session
      fill_in 'メールアドレス', with: 'userA@example.com' # fill in e-mail
      fill_in 'パスワード', with: 'password' # fill in password
      click_button 'ログイン' # sign in
      expect(page).to have_content 'ログインしました' # confirm sign in
    end

    it '新規登録する' do
        click_link 'ログアウト' # sign out 
        expect(page).to have_content 'ログアウトしました' # confirm sign out
        click_link '新規登録' # click new_registration
        fill_in 'user_username', with: 'pokepoke' # fill in username
        fill_in 'user_email', with: 'poke@example.com' # fill in e-mail
        fill_in 'user_password', with: 'password1' # fill in password
        fill_in 'user_password_confirmation', with: 'password1' # fill in password-confirmation
        click_button 'アカウント登録' # click create account
        expect(page).to have_content 'アカウント登録が完了しました。' # confirm message
    end

    it 'プロフィール編集' do
       click_link 'マイページ' # click my page
       click_on 'プロフィールを編集する' # move to my page
       attach_file 'user_image', "#{Rails.root}/app/assets/images/UNADJUSTEDNONRAW_thumb_b.jpg" # add image file
       fill_in 'user_username', with: 'userA' # edit username
       fill_in 'user_email', with: 'userA@example.com' # edit email
       fill_in 'user_password', with: 'password1' #fill in new password
       fill_in 'user_profile', with: 'こんにちは' # fill in profile
       fill_in 'user_password_confirmation', with: 'password1' # fill in password
       fill_in 'user_current_password', with: 'password' # fill in current password
       click_button '更新' # click update
       expect(page).to have_content 'アカウント情報を変更しました。' # confirm edit account message
       expect(page).to have_content 'こんにちは' # confirm user_profile 
    end
     
    it '退会する' do
      click_link 'マイページ' # click my page
      click_on 'プロフィールを編集する' # move to my page
      click_button '退会' # click usaer_delete
      page.driver.browser.switch_to.alert.accept # confirm dialog
      expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。' # confirm message
    end

    it 'ログイン確認' do
      click_link '新規登録' #click new registration
      expect(page).to have_content 'すでにログインしています。' # confirm already sign in message
    end

end

RSpec.describe 'admin機能', type: :system do
  before do
    FactoryBot.build(:user, username: 'admin', email: 'admin@example.com', password: 'password2', password_confirmation: 'password2', admin: true) # admin user
    FactoryBot.build(:user, username: 'userA', email: 'userA@example.com', password: 'password', password_confirmation: 'password') # user

    visit user_session_path # move to user_session
    fill_in 'メールアドレス', with: 'admin@example.com' # fill in e-mail
    fill_in 'パスワード', with: 'password2' # fill in password
    click_button 'ログイン' # sign in
    expect(page).to have_content 'ログインしました' # confirm sign in
  end

  it 'ユーザー削除' do
    click_link 'マイページ' # click my page
    click_link '管理者画面' # click admin function
    expect(page).to have_content 'userA' # confirm userA
    expect(page).not_to have_content 'admin' # not showing admin user
    fill_in '名前を入力', with: 'userA' # fill in search box
    click_on '名前を検索' # click search button
    expect(page).to have_content 'userA' # confirm userA
    click_link '削除' # click delete button
    page.driver.browser.switch_to.alert.accept # confirm dialog
    expect(page).to have_content 'ユーザー「userA」を削除しました。' # confirm not showing userA
  end

  it 'userAのマイページを表示' do
    click_link 'マイページ' # click my page
    click_link '管理者画面' # click admin function
    click_link 'userA' # click userA
    expect(page).to have_content 'userAさんのページ' # show userA's my page
    expect(page).not_to have_content 'プロフィールを編集する' # not showing userA's profile button
    expect(page).to have_content '投稿一覧' # show userA's reports
    expect(page).to have_content 'お気に入り一覧' # show userA's favorites
  end

end