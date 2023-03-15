Scenario: Search for Wikipedia articles
    Given the user searched for articles
    When showing the search results 
    Then give a short introduction for each article

Scenario: Multiple search results
    Given the user has entered a search query in the search bar
    When the search query is submitted
    Then the user should be taken to a page with multiple search results