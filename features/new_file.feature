Feature: Use an alternate alias file
    In order to fit my personal workflow better
    I want to be able to use a file other than `~/.alias` to store my aliases
    So that I can be large and in charge.

    Scenario: Create a new alias file
        When I run `aka --new-file .shortcuts`
        Then a file named "/tmp/akaTest/.shortcuts" should exist
        And that file should have all my current shortcuts in it

    Scenario: Check for a configuration file
        When I run `aka --new-file .newcuts`
        Then a file named "/tmp/akaText/.aka" should exist
        And it should contain the text ".newcuts"