Feature: Comments

  Scenario: Add a comment
    Given the user is on an article page
    When he scrolls down to the comments section
    And enters a comment in the text field
    And presses the "Submit" button
    Then he should see his comment displayed

  Scenario: Delete a comment
    Given the user has submitted a comment on an article page
    When he scrolls down to the comments section
    And presses the "Delete" button on his comment
    Then his comment should be removed from the comments section

  Scenario: Interact with a comment
    Given the user is viewing a comment
    When he wants to interact with it
    And clicks either the "Like" or "Dislike" button
    Then the comment's number of likes either increases or decreases

  Scenario: Report a Comment
    Given a comment that has innapropriate content
    And the user clicks on the "Report" button to report it
    Then a warning should be sent to the devs about that comment

  Scenario: Create a comment signature for posted comments
    Given the user wants a predefined comment signature
    And the user sets his comment signature in the settings
    When he posts a comment
    Then it shows a unique signature after it

  Scenario: Format the comment's contents
    Given the user is writing a comment 
    And wants to change the way the text looks
    When he toggles one of the available formatting options
    Then the displayed comment text should reflect the selected option