Feature: Use an alternate alias file
    In order to fit my personal workflow better
    I want to be able to use a file other than `~/.alias` to store my aliases
    So that I can be large and in charge.

    Scenario: Create a new alias file
        When I run `aka --alias-file .shortcuts` interactively
        And I type "y"
        And I close the stdin stream
        Then a file named "/tmp/akaTest/.shortcuts" should exist
        And the file "/tmp/akaTest/.shortcuts" should contain "alias test" 

    Scenario: Check for a configuration file
        When I run `aka --alias-file .newcuts` interactively
        And I type "y"
        And I close the stdin stream
        Then a file named "/tmp/akaTest/.aka" should exist
        And the file "/tmp/akaTest/.aka" should contain ".newcuts"