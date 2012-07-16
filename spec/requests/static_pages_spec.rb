require 'spec_helper'

describe "StaticPages" do
  subject { page }
  describe "Home page" do
    before { visit root_path }
    it { should have_selector 'h1', text:'Sample App' }
    it { should have_selector 'title', text: full_title('') }
    it { should_not have_selector 'title', text: '| Home' }
    
     it "should have the right links on the layout" do
        visit root_path
        click_link "About"
        page.should have_selector 'title', text: full_title('About Us')
        click_link "Help"
        page.should have_selector 'title', text: full_title('Help')
        click_link "Contact"
        page.should have_selector 'title', text: full_title('Contact')
        click_link "Home"
        click_link "Sign up now!"
        page.should have_selector 'title', text: full_title('Sign up')
        click_link "sample app"
        page.should have_selector 'title', text: full_title('')
     end
     describe "for signed-in users" do
        let(:user) { FactoryGirl.create(:user) }
        before do
          FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
          FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
          sign_in user
          visit root_path
        end

        it "should render the user's feed" do
          user.feed.each do |item|
            page.should have_selector("li##{item.id}", text: item.content)
          end
        end
    end
  end
  
  describe "Help page" do
    before do
      visit help_path
    end
    it "should have the content 'Help'" do
      page.should have_content('Help')
    end
    
    it "should have the title 'Help'" do
      page.should have_selector('title', :text => full_title('Help'))
    end
  end
  
  describe "About page" do
    before do
      visit about_path
    end
    it "should have the content 'About Us'" do
      page.should have_content('About Us')
    end
    
    it "should have the title 'About Us'" do
      page.should have_selector('title', :text => full_title('About Us'))
    end
  end
  
  describe "Contact page" do
    before do
      visit contact_path
    end
    it "should have the h1 'Contact'" do
      page.should have_selector('h1', text: 'Contact')
    end
    
    it "should have the title 'Contact'" do
      page.should have_selector('title', text: full_title('Contact'))
    end
  end 
end
