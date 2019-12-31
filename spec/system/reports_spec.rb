require 'rails_helper'

RSpec.describe "report機能", type: :system do
    FactoryBot.build(:user, username: 'userA', email: 'a@example.com', password: 'password', password_confirmation: 'password') # user
    FactoryBot.build(:user, username: 'userB', email: 'b@example.com', password: 'password', password_confirmation: 'password') # user
    

    context 'ユーザーAでログインしている' do
      before do
        visit user_session_path # move to user_session
        fill_in 'メールアドレス', with: 'a@example.com' # fill in e-mail
        fill_in 'パスワード', with: 'password' # fill in password
        click_button 'ログイン' # sign in
        expect(page).to have_content 'ログインしました' # confirm sign in
        click_on '新規投稿' # click new report
        fill_in 'report_title', with: 'New' # fill in title
        attach_file 'report_image', "#{Rails.root}/app/assets/images/UNADJUSTEDNONRAW_thumb_b.jpg" # attach image
        fill_in 'report_content', with: 'Hey' # fill in content
        click_button '投稿' # click create
      end

      describe '新規投稿' do

        it 'ユーザーAの投稿が表示されている' do
          click_on '新規投稿' # click new report
          fill_in 'report_title', with: 'Text' # fill in title
          attach_file 'report_image', "#{Rails.root}/app/assets/images/UNADJUSTEDNONRAW_thumb_b.jpg" # attach image
          fill_in 'report_content', with: 'Hello' # fill in content
          click_button '投稿' # click create
          expect(page).to have_content 'userAさんがTextを投稿しました。' # confirm message
          expect(page).to have_content 'userA' # show user's username
          expect(page).to have_content 'Text' # show user's report title
          expect(page).to have_content 'Hello' # show user's report content
        end

        it 'マイページに表示' do
          click_link 'マイページ' # move to userA's page
          expect(page).to have_content 'New' # show report's title
          click_link 'New' # click title
          expect(page).to have_content 'New' # show report's title
        end

        it 'Title image バリデーションが表示される' do
          click_on '新規投稿' # click new report
          fill_in 'report_content', with: 'Hello' # fill in content
          click_button '投稿' # click create
          expect(page).to have_content '写真を選択してください' # confirm image validation error
          expect(page).to have_content 'タイトルを入力してください' # confirm title validation error
        end

      
      end

      describe '詳細機能' do
      
        it '詳細画面が表示される' do
          click_link 'New' # click title
          expect(page).to have_content '投稿詳細' # show report description
          expect(page).to have_content '一覧画面' # show report index
          expect(page).to have_content 'userA' # show username
          expect(page).to have_content '投稿を削除' # show delete button
          expect(page).to have_content 'タイトル: New' # show title
          expect(page).to have_content 'Hey' # show report content
          expect(page).to have_selector '.heart' # show favorite button
          expect(page).to have_selector '#comment_content'# show comment form
          expect(page).to have_button 'コメントする' # show comment button
          click_link '一覧画面' # go back to report index
        end
      
      end

      describe '削除機能' do

        it '投稿が削除される' do
          click_link 'New' # click title
          click_link '投稿を削除' # click delete button
          page.driver.browser.switch_to.alert.accept # confirm dialog
          expect(page).to have_content 'Newを削除しました' # confirm delete message
        end

        it 'マイページに表示されない' do
          click_link 'New' # click title
          click_link '投稿を削除' # click delete button
          page.driver.browser.switch_to.alert.accept # confirm dialog
          expect(page).to have_content 'Newを削除しました' # confirm delete message
          click_link 'マイページ' # click userA's page
          expect(page).not_to have_content 'New' # not showing report's title
        end

      end

      describe '投稿検索機能' do

        it '投稿が表示' do
          click_on '新規投稿' # click new report
          fill_in 'report_title', with: 'Hennn' # fill in title
          attach_file 'report_image', "#{Rails.root}/app/assets/images/UNADJUSTEDNONRAW_thumb_b.jpg" # attach image
          fill_in 'report_content', with: 'Sup' # fill in content
          click_button '投稿' # click create
          fill_in 'search', with: 'Hennn' # fill in serch box
          click_on '投稿を検索' # click search button
          expect(page).to have_content 'Hennn' # confirm the report
        end

        it '表示されない' do
          fill_in 'search', with: 'hoihoi' # fill in serch box
          click_on '投稿を検索' # click search button
          expect(page).not_to have_content 'hoihoi' # confirm the report
        end

      end


    end

    context 'ユーザーBでログインしている' do

      # userAでログイン -> 投稿作成 -> ログアウト -> userBでログイン -> userAの投稿詳細画面に移動

      it 'ユーザーAの投稿詳細' do
        visit user_session_path # move to user_session
        fill_in 'メールアドレス', with: 'a@example.com' # fill in e-mail of userA
        fill_in 'パスワード', with: 'password' # fill in password of userA
        click_button 'ログイン' # sign in
        expect(page).to have_content 'ログインしました' # confirm sign in
        click_on '新規投稿' # click new report
        fill_in 'report_title', with: 'New' # fill in title
        attach_file 'report_image', "#{Rails.root}/app/assets/images/UNADJUSTEDNONRAW_thumb_b.jpg" # attach image
        fill_in 'report_content', with: 'Hey' # fill in content
        click_button '投稿' # click create
        expect(page).to have_content 'userAさんがNewを投稿しました。'
        click_link 'ログアウト' # click sign out
        visit user_session_path # move to user_session
        fill_in 'メールアドレス', with: 'b@example.com' # fill in email of userB
        fill_in 'パスワード', with: 'password' # fill in password of userB
        click_button 'ログイン' # sign in
        expect(page).to have_content 'ログインしました' # confirm sign in
        expect(page).to have_content 'New' # confirm userA's report title
        click_link 'New' # click title 
        expect(page).to have_content 'userA' # show userA's name
        expect(page).not_to have_content '投稿を削除' # not showing delete button
      end

    end
end