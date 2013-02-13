Feature: Show all the Groups
    In order to more easily manage a long list of aliases
    I can show a list of the groups of aliases in my alias file
    So that I can understand where they're all being used.

    Scenario: List all Groups
        When I run `aka -G`
        Then the output should contain "Git"