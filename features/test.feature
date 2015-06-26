Feature: test 
 As a test-taker
 I want to be able to log in the test page
 so that I can choose a category and start the test

 Background:
  Given there are categories such as:
  | name | duration |
  | RUBY | 20       |
  | JAVA | 20       |
  | SQL  | 20       |
  | PHP  | 20       |
  
 Scenario: User not signed in
  When I visit test page
  Then I should see message "You need to sign in or sign up before continuing."

 Scenario: User signed in
  Given I have signed in 
  When I visit test page
  Then I should see heading "All Test",a dropdown list and button "Start New Test"
  When I choose category "JAVA" for instance which is option "3" and click "Start New Test"
  Then I should see that category "JAVA" being selected
  And I should see a new test has been created with link of status "Start"

