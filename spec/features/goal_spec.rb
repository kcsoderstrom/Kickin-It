require 'spec_helper'
require 'rails_helper'

feature "goals list on user's show page" do

  before do
    visit(new_user_url)
    fill_in 'username', with: 'Ho Chi Minh'
    fill_in 'password', with: 'deathtoimperialists'
    click_on 'Sign Up'
    # expect to redirect to his show page
    click_on 'Sign Out'
  end

  it "redirects to sign-in page when not signed in" do
    visit user_url(User.find_by_username('Ho Chi Minh'))
    expect(current_url).to eq(new_session_url)
  end

  feature "when signed in" do
    before do
      visit(new_user_url)
      fill_in 'username', with: 'Chiang Kai Shek'
      fill_in 'password', with: 'kmt4lyf'
      click_on 'Sign Up'
      # expect to redirect to his show page
    end

    context "making a new goal" do

      it "has a new goals form" do
        expect(page).to have_content("New Goal")
      end

      it "should validate goal titles' presence" do
        click_on 'goal_submit'
        expect(page).to have_content "Title can't be blank"
      end

      it "doesn't allow repeated goals by the same user" do
        fill_in 'goal_title', with: 'Retake the mainland'
        click_on 'goal_submit'

        save_and_open_page
        fill_in 'goal_title', with: 'Retake the mainland'
        click_on 'goal_submit'

        expect(page).to have_content 'Title has already been taken'
      end

      it "allows repeated goals by different users" do
        click_on 'Sign Out'

        visit(new_user_url)
        fill_in 'username', with: 'Deng Xiaoping'
        fill_in 'password', with: 'blackcatwhitecat'
        click_on 'Sign Up'

        fill_in 'goal_title', with: 'Retake the mainland'
        click_on 'goal_submit'
        expect(page).not_to have_content 'Title has already been taken'
      end

    end
  end

end

# feature "logging in" do
#
#   it "shows username on the homepage after login"
#
# end
#
# feature "logging out" do
#
#   it "begins with logged out state"
#
#   it "doesn't show username on the homepage after logout"
#
# end