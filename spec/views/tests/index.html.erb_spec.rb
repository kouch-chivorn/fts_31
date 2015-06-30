require "rails_helper"

RSpec.describe "tests/index.html.erb", type: :view do
  before :each do
    @user = FactoryGirl.create :user
    @category1 = FactoryGirl.create :category, name: "JAVA"
    @category2 = FactoryGirl.create :category, name: "Ruby"
    assign(:tests, [
             mock_model(Test, user: @user, category: @category1),
             mock_model(Test, user: @user, category: @category2)
    ])
    allow(view).to receive_messages(will_paginate: nil)
    @test = FactoryGirl.build :test, user: @user, category: @category
    assign(:test, @test)
    render
  end

  it "show test heading" do
    expect(rendered).to have_selector("h1", text: "All Test")
  end

  it "show details on questions and answers" do
    expect(rendered).to have_selector("form") do |form|
      expect(form).to have_selector("select[name='test[category_id]']")
      expect(rendered).to have_selector("input[type=submit][value='Start New Test']")
    end
  end

  it "displays both tests" do
    expect(rendered).to have_content "JAVA"
    expect(rendered).to have_content "Ruby"
  end
end
