require 'rails_helper'

RSpec.describe "favorite機能", type: :system do
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
        fill_in 'report_content', with: 'Hey' # fill in content
        click_button '投稿' # click create
    end

    context 'ユーザーAでログインしている' do
        
        it 'お気に入りする' do
          click_link 'New' # click title
          find('.heart').click # click favorite button
          expect(page).to have_content '1' # confirm favorite count
          expect(page).to have_content '投稿 Newをお気に入りしました' # confirm favorite message
        end

        it 'お気に入り解除' do
          click_link 'New' # click title
          find('.heart').click # click favorite button
          expect(page).to have_content '1' # confirm favorite count
          expect(page).to have_content '投稿 Newをお気に入りしました' # confirm favorite message
          find('.heart').click # click favorite button
          expect(page).to have_content '0' # confirm favorite deleted count 
          expect(page).to have_content '投稿 Newのお気に入りを解除しました' # confirm favorite deleted message
        end

    end  

    context 'ユーザーBでログインしている' do
        before do
           click_link 'ログアウト' # sign out
           click_link 'ログイン' # click sign in
           fill_in 'メールアドレス', with: 'b@example.com' # fill in email of userB
           fill_in 'パスワード', with: 'password' # fill in password of userB
           click_button 'ログイン' # click sign button
        end

        it 'お気に入りする' do
           click_link 'New' # click userA's report title
           find('.heart').click # click favorite button
           expect(page).to have_content '1' # confirm favorite count
           expect(page).to have_content '投稿 Newをお気に入りしました' # confirm favorite message
        end

        it 'お気に入り削除' do
           click_link 'New' # click userA's report title
           find('.heart').click # click favorite button
           expect(page).to have_content '1' # confirm favorite count
           expect(page).to have_content '投稿 Newをお気に入りしました' # confirm favorite message
           find('.heart').click # click favorite button to delete
           expect(page).to have_content '0' # confirm favorite count
           expect(page).to have_content '投稿 Newのお気に入りを解除しました' # confirm favorite message
        end

        it 'マイページに表示' do
           click_link 'New' # click userA's report title
           find('.heart').click # click favorite button
           expect(page).to have_content '1' # confirm favorite count
           expect(page).to have_content '投稿 Newをお気に入りしました' # confirm favorite message
           click_link 'マイページ' # click my page
           expect(page).to have_content 'userB' # show userB's page
           expect(page).to have_content 'New' # show report title userB favorited
           click_link 'New' # click report title
           expect(page).to have_content 'New' # show report title
        end

        it 'マイページに表示されない' do
           click_link 'マイページ' # move to userB's page
           expect(page).not_to have_content 'New' # not showing userA's report title
        end

    end

    context 'ログインしていない' do
        before do
          click_link 'ログアウト' # sign out
        end

        it 'お気に入りできない' do
        click_link 'New' # click report title
        expect(page).to have_content 'ログインしてお気に入りする' # can't click favorite button
        end

    end






end