Scenario: Change the page's theme
    When the user wants to change a page's theme
    Then he should be able to change the theme in the settings
    And the page should be reloaded with the new theme

Scenario: Select the article's language
    Given the user is viewing an article
    When he wants to view it in a different language
    Then the user should be able to select a language from a menu

Scenario: Format the comment's contents
    Given the user is writing a comment 
    And he wants to change the way the text looks
    Then the user should be able to use the available text formatting options to change its looks