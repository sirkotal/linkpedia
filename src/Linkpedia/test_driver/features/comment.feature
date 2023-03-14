Scenario: Add a comment
    Given that I am in the comment section of an article
    When I want to add a comment
    Then I should be able to enter my comment in a text field and submit it

Scenario: Delete a comment
    Given that I have submitted a comment
    When I want to delete my comment
    Then I should be able to click on a delete button and remove my comment from the comment section

Scenario : Interact with a comment
    Given the user is viewing a comment
    When he wants to interact with it
    Then he should be able to click either a "Like" or "Dislike" button, either increasing or decreasing the number of likes