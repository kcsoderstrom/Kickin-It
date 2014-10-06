# require 'spec_helper'
# require 'rails_helper'
#
# feature "the signup process" do
#
#   it "has a new user page" do
#     visit(new_user_url)
#     expect(page).to have_content "Sign Up"
#   end
#
#   feature "signing up a user" do
#     before do
#       visit(new_user_url)
#       fill_in 'username', with: 'Chairman_Mao'
#       fill_in 'password', with: 'red glory'
#       click_on 'Sign Up'
#     end
#
#     it "shows username on the homepage after signup" do
#       visit(root_url)
#       expect(page).to have_content('Chairman_Mao')
#     end
#
#   end
#
# end
#
# feature "logging in" do
#   before do
#     visit(new_session_url)
#     fill_in 'username', with: 'Chairman_Mao'
#     fill_in 'password', with: 'red glory'
#     click_on 'Sign In'
#   end
#
#   it "shows username on the homepage after login" do
#     visit(root_url)
#     expect(page).to have_content('Chairman_Mao')
#   end
#
# end
#
# feature "logging out" do
#
#   it "begins with logged out state" do
#     visit(root_url)
#     expect(page).not_to have_content('Chairman_Mao')
#   end
#
#   it "doesn't show username on the homepage after logout" do
#     visit(new_session_url)
#     fill_in 'username', with: 'Chairman_Mao'
#     fill_in 'password', with: 'red glory'
#     click_on 'Sign In'
#     visit(root_url)
#     click_on 'Sign Out'
#     expect(page).not_to have_content('Chairman_Mao')
#   end
#
# end