Feature: User Authentication and Login
  Login processing and user session management for the e-commerce application

  Background:
    Given browser is launched
    And the main application tab is opened

  @user-login-demo
  Scenario: Demo user login with email and password
    Given user accesses the login page "/auth/login"
    When the signin page is displayed
    Then select email/password login method

    When user enters email "test@example.com"
    And user enters password "password123"
    And user clicks the "Sign in" button
    Then user should be redirected to the products page
    And user should see "Welcome" or product listings

  @user-login-admin
  Scenario: Admin user login
    Given user accesses the login page "/auth/login"
    When the signin page is displayed
    Then select email/password login method

    When user enters email "admin@example.com"
    And user enters password "admin123"
    And user clicks the "Sign in" button
    Then user should be redirected to the products page
    And user should see admin navigation options

  @session-verification
  Scenario: Verify user session after login
    Given user is logged into the application
    When checking the browser session
    Then user session should be active
    And user should be able to access protected pages

  @test-data-setup
  Scenario: Prepare test accounts for E2E testing
    Given the application database is accessible
    Then verify the following test accounts exist:
      | Email               | Role     | Status |
      | test@example.com    | Customer | Active |
      | admin@example.com   | Admin    | Active |
      | manager@example.com | Manager  | Active |
    And accounts should be usable for testing