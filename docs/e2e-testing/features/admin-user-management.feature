Feature: Admin User Management
  Admin panel user role and status management functionality

  Background:
    Given browser is launched
    And admin user is logged into the application
    And admin user is on the admin panel

  @admin-user-list
  Scenario: View user management list
    Given admin accesses the admin panel "/admin"
    When the admin dashboard is displayed
    And admin clicks on "User Management" tab
    Then user management table should be displayed
    And table should show columns: User, Role, Status, Actions
    And test users should be visible in the list

  @admin-change-user-role
  Scenario: Change user role from admin panel
    Given admin is on the User Management tab
    When admin finds user "John Doe" in the user list
    And admin clicks on the role dropdown for that user
    And admin selects "Manager" from role options
    Then role change confirmation should be triggered
    And user role should be updated to "Manager"
    And success message should be displayed

  @admin-change-user-status
  Scenario: Change user status
    Given admin is on the User Management tab
    When admin finds user "Bob Johnson" in the user list
    And admin clicks on the status dropdown for that user
    And admin selects "Active" from status options
    Then status change confirmation should be triggered
    And user status should be updated to "Active"
    And success message should be displayed

  @admin-view-user-details
  Scenario: View detailed user information
    Given admin is on the User Management tab
    When admin finds user "Alice Brown" in the user list
    And admin clicks "View Details" for that user
    Then user details panel should be displayed
    And panel should show: Name, Email, Role, Status, User ID
    And information should match the user data

  @admin-edit-user-profile
  Scenario: Edit user profile from admin panel
    Given admin is on the User Management tab
    When admin finds user "John Doe" in the user list
    And admin clicks "Edit" link for that user
    Then user profile page should open
    And user details form should be displayed
    When admin clicks "Edit User" button
    And admin changes user role to "Admin"
    And admin clicks "Save Changes" button
    Then confirmation dialog should appear with title "Save Changes"
    And dialog should ask "Are you sure you want to save these changes?"
    When admin clicks "Save" button in the confirmation dialog
    Then "Changes saved successfully!" message should be displayed
    And user information should be updated