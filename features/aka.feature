Feature: Help method is complete
  In order to understand how this app works
  I can access the help function
  and get a complete and understandable set of instructions for using the app.

  Scenario: App just runs
    When I get help for "aka"
    Then the exit status should be 0
    And the banner should be present
    And there should be a one line summary of what the app does
    And the banner should document that this app takes options
    And the following options should be documented:
      |--version|
      |-a       |
      |--add    |
      |-l       |
      |--list   |
      |-r       |
      |--remove |
      |-s       |
      |--show   |
    Then the banner should document that this app's arguments are:
    |alias|
    |value|
