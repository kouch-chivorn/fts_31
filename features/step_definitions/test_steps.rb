Given(/^there are categories such as:$/) do |table|
  table.map_headers! "name" => :name, "duration" => :duration
  table.hashes.each { |hash| FactoryGirl.create :category, hash}
end

When(/^I visit test page$/) do
  visit tests_path
end

Then(/^I should see message "(.*?)"$/) do |message|
  expect(page).to have_selector("p.alert.alert-danger", text: message)
end

Given(/^I have signed in$/) do
  @user = FactoryGirl.create :user,
    name: "kouch chivorn",
    email: "kouchchivorn5@yahoo.com",
    password: "12345678",
    password_confirmation: "12345678"

  visit new_user_session_path
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password
  click_button "Log in"
end

Then(/^I should see heading "(.*?)",a dropdown list and button "(.*?)"$/) do |arg1, arg2|
  expect(page).to have_selector("h1", text: arg1)
  expect(page).to have_selector("select[name='test[category_id]']")
  expect(page).to have_selector("input[type=submit][value='#{arg2}']")
end

When(/^I choose category "(.*?)" for instance which is option "(.*?)" and click "(.*?)"$/) do |category,opt, button|
  @category = Category.find_by_name category
  find("#test_category_id").find(:xpath,"option[#{opt.to_i}]").select_option
  click_button button
end

Then(/^I should see that category "(.*?)" being selected$/) do |category|
  @category_id = find("#test_category_id").find("option[selected]").value
  @category = Category.find @category_id.to_i
  expect(@category.name).to eq(category)
end

Then(/^I should see a new test has been created with link of status "(.*?)"$/) do |link|
  @test = Test.last
  expect(page).to have_link(link, href: edit_test_path(@test))
end
