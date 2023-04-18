Scenario: Search for Wikipedia articles
    Given the user wants to search for articles
    When he inputs a search query in the search bar
    Then the results of the query should be shown
    And a short introduction is given for each article

Scenario: Multiple search results
    Given the user has submitted a search query in the search bar
    Then the user should be taken to a page with multiple search results