require 'spec_helper'

#let :base_title { "Ruby on Rails Tutorial Sample App" } 

describe "Static Pages" do
  describe "Home page" do
    it "should have the content 'Sample App'" do
    	visit '/static_pages/home'
    	page.should have_content('Sample App')  

    end
    it "should have the base title" do
        visit '/static_pages/home'
        page.should have_selector('title', 
            :text => "Ruby on Rails Tutorial Sample App")
    end
    it "should have the right title 'home'" do
    	visit '/static_pages/home'
    	page.should_not have_selector('title', 
    		:text => ' | Home')
    end

  end

 describe "Help page" do
 	it "should have content 'Help'" do
 		visit '/static_pages/help'
 		page.should have_content 'Help'
 	end
 	it "should have the right title 'Help'" do
    	visit '/static_pages/help'
    	page.should have_selector('title', 
    		:text => ' | Help')
    end
 end

 describe "About page" do
 	it "should have content 'About Us'" do
 		visit '/static_pages/about'
 		page.should have_content 'About Us'
 	end
 	it "should have the right title about" do
    	visit '/static_pages/about'
    	page.should have_selector('title', 
    		:text => ' | About')
    end
 end

describe "Control page" do
 	it "should have content 'Control'" do
 		visit '/static_pages/control'
 		page.should have_content 'Control'
 	end
 	it "should have the right title 'Control'" do
    	visit '/static_pages/control'
    	page.should have_selector('title', 
    		:text => ' | Control')
    end
 end



end
