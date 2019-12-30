require 'rails_helper'

RSpec.describe 'comment機能', type: :system do
    FactoryBot.build(:user, username: 'userA', email: 'a@example.com', password: 'password', password_confirmation: 'password') # user
    FactoryBot.build(:user, username: 'userB', email: 'b@example.com', password: 'password', password_confirmation: 'password') # user

    before do
        visit user_session_path # move to user_session
        fill_in 'メールアドレス', with: 'a@example.com' # fill in e-mail
        fill_in 'パスワード', with: 'password' # fill in password
        click_button 'ログイン' # sign in
        click_on '新規投稿' # click new report
        fill_in 'report_title', with: 'New' # fill in title
        attach_file 'report_image', "#{Rails.root}/app/assets/images/UNADJUSTEDNONRAW_thumb_b.jpg" # attach image
        fill_in 'report_content', with: 'Hello' # fill in content
        click_button '投稿' # click create
    end

    context 'ユーザーAでログインしている' do

      it 'コメントする' do
         click_on 'New' # click report title
         fill_in 'comment_content', with: 'Hey' # fill in comment_content
         click_button 'コメントする' # click comment
         expect(page).to have_selector('#comments_area', text: 'Hey') # show comment content
         expect(page).to have_selector('#comments_area', text: 'userAさん') # show comment user
         expect(page).to have_selector('#comments_area', text: '削除') # show comment delete button
      end

      it 'コメントを削除' do
        click_on 'New' # click report title
        fill_in 'comment_content', with: 'Hey' # fill in comment_content
        click_button 'コメントする' # click comment
        click_link '削除' # click delete button
        page.driver.browser.switch_to.alert.accept # confirm dialog
        expect(page).not_to have_selector('#comments_area', text: 'Hey') # not showing comment content
      end

    end

    context 'ユーザーBでログインしている' do
        before do
          click_on 'New' # click report title
          fill_in 'comment_content', with: 'Hey' # fill in comment_content
          click_button 'コメントする' # click comment
          expect(page).to have_selector('#comments_area', text: 'Hey') # show comment content
          click_link 'ログアウト' # sign out 
        end

        it 'コメントする' do
          click_link 'ログイン' # click sign in
          fill_in 'メールアドレス', with: 'b@example.com' # fill in email of userB
          fill_in 'パスワード', with: 'password' # fill in password of userB
          click_button 'ログイン' # sign in
          click_link 'New' # click userA's report title
          fill_in 'comment_content', with: 'whats up' # fill in comment_content
          click_button 'コメントする' # click comment
          expect(page).to have_selector('#comments_area', text: 'whats up') # show userB's comment content
          expect(page).to have_selector('#comments_area', text: 'userBさん') # show userB's name in comments area
          expect(page).to have_selector('#comments_area', text: '削除') # show comment delete button
          expect(page).to have_selector('#comments_area', text: 'Hey') # show userA's comment content
          expect(page).to have_selector('#comments_area', text: 'userAさん') # show userA's name in comments area
        end

        it 'マイページに移動' do
          click_link 'ログイン' # click sign in
          fill_in 'メールアドレス', with: 'b@example.com' # fill in email of userB
          fill_in 'パスワード', with: 'password' # fill in password of userB
          click_button 'ログイン' # sign in
          click_link 'New' # click userA's report title
          click_link 'userAさん' # click username
          expect(page).to have_content 'userAさんのページ' # show userA's page
        end

    end

end