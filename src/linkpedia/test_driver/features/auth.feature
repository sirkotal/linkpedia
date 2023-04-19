Feature: Authentication
  Scenario: User logs in to Linkpedia successfully
    Given I have "email" and "password" and "login"
    When I fill the "email" field with "test@email.com"
    And I fill the "password" field with "test123"
    Then I tap the "login" button
    Then I wait until the text "Welcome to Linkpedia!" to be present

#   Scenario: User signs up to Linkpedia
#     Given the user is on the "Register" page
#     When he enters his name, email and password
#     And presses the "Sign Up" button
#     Then he should be redirected to the "Login" page
#     And he should see a success message

#   Scenario: User logs in to Linkpedia successfully
#     Given the user is on the "Login" page
#     When he enters his email and password
#     And presses the "Login" button
#     Then he should be redirected to the "Home" page

#   Scenario: Invalid Linkpedia login
#     Given the user is on the "Login" page
#     When he enters an invalid email or password
#     And presses the "Login" button
#     Then he should receive an error message