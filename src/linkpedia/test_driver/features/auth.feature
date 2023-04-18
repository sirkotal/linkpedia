Feature: Authentication

  Scenario: User signs up to Linkpedia
    Given the user is on the "Register" page
    When he enters his name, email and password
    And presses the "Sign Up" button
    Then he should be redirected to the "Login" page
    And he should see a success message

  Scenario: User logs in to Linkpedia successfully
    Given the user is on the "Login" page
    When he enters his email and password
    And presses the "Login" button
    Then he should be redirected to the "Home" page

  Scenario: Invalid Linkpedia login
    Given the user is on the "Login" page
    When he enters an invalid email or password
    And presses the "Login" button
    Then he should receive an error message