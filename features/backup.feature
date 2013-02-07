Feature: Create a backup file
    In order to ensure that I can keep my awesome list of aliases safe
    I can create a backup file
    So that I can restore it if things go wrong.

    Scenario: Create a backup.
        When I run `aka -b`
        Then a file named "/tmp/akaTest/.alias.bak" should exist