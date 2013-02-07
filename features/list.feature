Feature: Aliases are listed
    In order to know what aliases are available to me
    I want to ask for a list of aliases
    So I can confidently use them.


    #TODO: Create a mock file in the fake test directory that has some good fake aliases to test.
    Scenario: Use Short Code
        When I run `aka -l`
        Then the exit status should be 0
        And the output should contain "test"

    Scenario: Use Long code
        When I run `aka --list`
        Then the exit status should be 0
        And the output should contain "test"