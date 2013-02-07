Feature: Remove an alias
    In order to get rid of aliases that I no longer use
    I can remove an alias from my system.

    Scenario: Drop an alias
        When I run `aka -r test`
        Then the alias "test" should no longer be in the alias file.