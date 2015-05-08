Feature: Creating a Puppet MySQL module
  In order to modularize MySQL builds for all nodes
  As a Puppet Master
  I want to make sure the module has no bugs

  Background:
    Given A node is present with certificates

  Scenario: MySQL package is present
    Given I have connection to the repo
    When  The correct version is present
    Then  Download and install MySQL package

  Scenario: MySQL has been installed
    Given I have included Puppet module to the node
    When  Puppet apply for module completed without errors
    Then  I expect MySQL service to be running

  Scenario: Login to MySQL
    Given I have provided the username and password upon installation
    When  I login to MySQL
    Then  I should be prompted to MySQL shell

  Scenario: MySQL read access
    Given I login to to MySQL
    When  I try to read
    Then  I should retrieve data from MySQL

  Scenario: MySQL database is present
    Given I have created a temporary database
    When  I login to MySQL
    And   Check database
    Then  Database should be present

  Scenario: Checks are in place for this module
    Given I have added the Sensu template for MySQL
    When  The json file is present
    Then  Sensu monitoring should pick up the json file
