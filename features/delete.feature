Feature: Delete the entire file
    In order to get a fresh start on things
    I can delete my alias file entirely

    Scenario: short code
        When I run `aka -d` interactively
        Then the alias file should be empty.