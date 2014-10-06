require 'spec_helper'
require 'rails_helper'

feature "comments" do
  context "on users" do
    before(:each) do
      visit(new_user_url)
      fill_in 'username', with: 'Kim_Yong-bom'
      fill_in 'password', with: 'thenorthremembers'
      click_on 'Sign Up'

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


    it "has link on user's show page" do
      expect(page).to have_link("Comment on Pol Pot")
    end

    it "rejects blank comments" do
      visit user_comments_url(User.find_by_username('Kim_Yong-bom'))
      click_on 'comment_submit'
      expect(page).to have_content("can't be blank")
    end

    it "add valid comments to the list" do
      visit user_comments_url(User.find_by_username('Kim_Yong-bom'))
      fill_in 'comment_content', with: "Bro nice communism!!"
      click_on 'comment_submit'
      expect(page).to have_content("Bro nice communism!!")
    end

  end

  context "on goals" do
    before(:each) do
      visit(new_user_url)
      fill_in 'username', with: 'Kim_Yong-bom'
      fill_in 'password', with: 'thenorthremembers'
      click_on 'Sign Up'

      fill_in 'goal_title', with: 'Organize the workers'
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


    it "has link on user's show page" do
      expect(page).to have_link("Comment")
    end

    it "rejects blank comments" do
      visit goal_comments_url(Goal.find_by_title('Organize the workers'))
      click_on 'comment_submit'
      expect(page).to have_content("can't be blank")
    end

    it "add valid comments to the list" do
      visit goal_comments_url(Goal.find_by_title('Organize the workers'))
      fill_in 'comment_content', with: "Ya I'm 'bout that 2 dough!!"
      click_on 'comment_submit'
      expect(page).to have_content("Ya I'm 'bout that 2 dough!!")
    end

  end

end