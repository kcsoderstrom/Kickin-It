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

feature "goal privacy" do

  before(:each) do
    visit(new_user_url)
    fill_in 'username', with: 'Kim_Yong-bom'
    fill_in 'password', with: 'thenorthremembers'
    click_on 'Sign Up'

    fill_in 'goal_title', with: 'Organize the workers'
    click_on 'goal_submit'

    fill_in 'goal_title', with: 'Starve the children'
    check('goal_private')
    click_on 'goal_submit'

    click_on "Sign Out"

    visit(new_user_url)
    fill_in 'username', with: 'Pol Pot'
    fill_in 'password', with: 'killthemall'
    click_on 'Sign Up'
  end

  after(:each) do
    click_on "Sign Out"
    User.find_by_username("Kim_Yong-bom").destroy
    User.find_by_username("Pol Pot").destroy
  end

  it "defaults to public" do
    visit user_url(User.find_by_username("Kim_Yong-bom"))
    expect(page).to have_content("Organize the workers")
  end

  it "disallows others from seeing private goals" do
    visit user_url(User.find_by_username("Kim_Yong-bom"))
    expect(page).not_to have_content("Starve the children")
  end

  it "can always be seen by author" do
    visit user_url(User.find_by_username("Pol Pot"))
    fill_in 'goal_title', with: 'Dig mass graves'
    fill_in 'goal_content', with: "I just don't want to show my soft side. ='("
    check('goal_private')
    click_on 'goal_submit'

    expect(page).to have_content("Dig mass graves")
  end

end