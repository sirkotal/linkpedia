Scenario: Add a comment
    Given the user is in the comment section of an article
    When he wants to add a comment
    Then he should be able to enter his comment in a text field 
    And click the "Submit" button to post it

Scenario: Delete a comment
    Given the user has submitted a comment
    When he wants to delete his comment
    Then he should be able to click on the "Delete" button 
    And remove his comment from the comment section

Scenario: Interact with a comment
    Given the user is viewing a comment
    When he wants to interact with it
    Then he should be able to click either a "Like" or "Dislike" button
    Then the comment's number of likes either increases or decreases

Scenario: Report a Comment
    Given a comment has innapropriate content
    And the user wants to report it
    Then he should be able to click a "Report" button

Scenario: Create a comment signature for posted comments
    Given the user wants a predefined comment signature
    And the user sets his comment signature in the settings
    When he posts a comment
    Then it shows a unique signature after it