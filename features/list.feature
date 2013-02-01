Feature: Aliases are listed
    In order to know what aliases are available to me
    I want to ask for a list of aliases
    So I can confidently use them.

    Scenario: Use Short Code
    When I type `aka -l`
    Then I should see a list of all aliases
    And the list should contain the alias "gohome"