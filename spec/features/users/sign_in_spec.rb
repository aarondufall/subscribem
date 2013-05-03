require 'spec_helper'
	feature 'User sign in' do
	extend SubdomainHelpers
	let!(:account) { FactoryGirl.create(:account_with_schema) }
	let(:sign_in_url) { "http://#{account.subdomain}.example.com/sign_in" }
	let(:root_url) { "http://#{account.subdomain}.example.com/"}

	context "within a subdomain" do
		let(:subdomain_url) { "http://#{account.subdomain}.example.com"}
		before 	{ Capybara.default_host = subdomain_url }
		after 	{ Capybara.default_host = "http://example.com" }
		scenario "signs in as an account owner successfully" do
			visit subscribem.root_url(subdomain: account.subdomain)
			page.current_url.should == sign_in_url
			fill_in "Email", with: account.owner.email
			fill_in "Password", with: "password"
			click_button "Sign in"
			page.should have_content("You are now signed in.")
			page.current_url.should == root_url
		end
	end

	it 'attempts sign in with an invalid password and fails' do
		visit subscribem.root_url(subdomain: account.subdomain)
		page.current_url.should == sign_in_url
		page.should have_content("Please sign in.")
		fill_in "Email", with: account.owner
		fill_in "Password", with: "drowssap"
		click_button "Sign in"
		page.should have_content("Invalid email or password.")
		page.current_url.should == sign_in_url
	end

	it "attempts sign in with an invalid email addess and fails" do
		visit subscribem.root_url(subdomain: account.subdomain)
		page.current_url.should == sign_in_url
		page.should have_content("Please sign in.")
		fill_in "Email", with: "foo@example.com"
		fill_in "Password", with: "password"
		click_button "Sign in"
		page.should have_content("Invalid email or password.")
		page.current_url.should == sign_in_url
	end

	it "cannot sign in if not part of this subdomain" do
		other_account = FactoryGirl.create(:account_with_schema)
		visit subscribem.root_url(subdomain: account.subdomain)
		page.current_url.should == sign_in_url
		page.should have_content("Please sign in.")
		fill_in "Email", with: other_account.owner.email
		fill_in "Password", with: "password"
		click_button "Sign in"
		page.should have_content("Invalid email or password.")
		page.current_url.should == sign_in_url
	end
end
