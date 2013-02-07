Feature: Adding a new alias
    In order to navigate and control my system quickly
    I can add new aliases to the system's alias file

    Scenario: Short Form
        When I run `aka -a second "echo second"`
        Then the alias "second" should be in the alias file.

    Scenario: Long Form
        When I run `aka -add third "echo third"`
        Then the alias "third" should be in the alias file.