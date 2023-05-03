Feature: User Customization

  Scenario: Change the page's theme
    Given the user is on a Linkpedia page
    When the user wants to change the page's theme
    And changes it in the settings
    Then the page should be reloaded with the new theme

  Scenario: Select the article's language
    Given the user is on an article page
    When he wants to view it in a different language
    And selects a different language from a menu
    Then the article should be displayed in a different language