Feature: Show an alias

    Scenario: display an alias
        When I run `aka -a test "echo this is a test"`
        And I run `aka -s test`
        Then the exit status should be 0
        And the output should contain "echo this is a test"
