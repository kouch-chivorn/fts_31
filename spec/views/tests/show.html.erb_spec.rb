require "rails_helper"

RSpec.describe "tests/show.html.erb", type: :view do
  before :each do
    @category = FactoryGirl.create :category
    @test = FactoryGirl.create :test, category: @category
    assign(:test, @test)
    @i = 0
    render
  end

  it "show test heading and result" do
    expect(rendered).to have_selector("h1", text: @test.category.name)
    expect(rendered).to have_selector("h2", text: "Result: #{@test.result}/#{Settings.test_quest.num}")
  end

  it "show details on questions and answers" do
    expect(rendered).to have_selector("form") do |form|
      expect(form).to have_css("p.correct", text: "Correct!")
      expect(rendered).to have_css("p.incorrect", text: "InCorrect!")
    end
  end
end
