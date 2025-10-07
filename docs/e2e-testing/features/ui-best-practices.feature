Feature: UI Operations Best Practices
  Best practices and proven patterns for reliable UI automation

  Background: Chrome DevTools MCP Operation Patterns
    Given Chrome browser is accessing the web application

  @dropdown-basic
  Scenario: Dropdown (select element) operation - Basic pattern
    # Standard fill or click may not work for some dropdowns
    When setting value in a dropdown/select element
    Then use evaluate_script for reliable selection:
      """
      const options = document.querySelectorAll('option');
      for (let option of options) {
        if (option.textContent.trim() === 'Target Value') {
          option.selected = true;
          const selectElement = option.parentElement;
          const event = new Event('change', { bubbles: true });
          selectElement.dispatchEvent(event);
          return 'Selected option successfully';
        }
      }
      return 'Option not found';
      """

  @dropdown-multiple-fields
  Scenario: Dropdown operation - Multiple field batch setting
    # ✅ Successful approach: Reliable field identification using parentElement.textContent
    When setting multiple dropdowns in a dialog or form
    Then use evaluate_script with batch setting pattern:
      """
      const selects = document.querySelectorAll('select');
      const comboboxes = document.querySelectorAll('[role="combobox"]');
      const allSelects = [...selects, ...comboboxes];

      let results = [];

      allSelects.forEach((element, index) => {
        const options = element.querySelectorAll('option');
        const parentText = element.parentElement?.textContent || '';

        options.forEach(option => {
          // Example: Select "Electronics" category
          if (option.textContent.includes('Electronics') && !element.value.includes('Electronics')) {
            element.value = option.value || option.textContent;
            element.selectedIndex = option.index;
            element.dispatchEvent(new Event('change', {bubbles: true}));
            element.dispatchEvent(new Event('input', {bubbles: true}));
            results.push(`Category set: ${option.textContent}`);
          }
          // Example: Select "Active" status (identified by parent element text)
          else if (option.textContent.includes('Active') && parentText.includes('Status')) {
            element.value = option.value || option.textContent;
            element.selectedIndex = option.index;
            element.dispatchEvent(new Event('change', {bubbles: true}));
            element.dispatchEvent(new Event('input', {bubbles: true}));
            results.push(`Status set: ${option.textContent}`);
          }
        });
      });

      return results.length > 0 ? results : 'No matching options found';
      """
    # ✅ Success factors:
    # 1. Use parentElement.textContent for reliable field identification
    # 2. Explicitly set selectedIndex
    # 3. Trigger both change and input events

  @dynamic-form-step-by-step
  Scenario: Dynamic form step-by-step input
    # When selecting one field reveals the next field
    Given a dynamic form dialog is displayed
    When selecting the first field (category)
    Then the second field (type) becomes visible
    When selecting the second field (type)
    Then the third field (status) becomes visible
    When selecting the third field (status)
    Then action buttons become enabled
    And verify each step with take_snapshot

  @confirm-dialog-handling
  Scenario: Proper handling of confirmation dialogs
    # When save operation shows confirmation dialog
    When clicking form "Save" button
    Then modal confirmation dialog appears
    And dialog title should be "Save Changes" or "Confirm"
    And confirmation message is displayed
    When clicking dialog "Save" or "OK" button
    Then success message appears
    And notification timer starts

  @page-transition-handling
  Scenario: Element waiting after page transitions
    # When click causes page navigation
    When clicking a list item or navigation link
    And page transition occurs
    Then use take_snapshot to verify page content
    And wait for target elements to appear
    # take_snapshot repetition is more reliable than wait_for

  @troubleshooting
  Scenario: Troubleshooting when operations fail
    Given UI element operation has failed
    When investigating the problem in this order:
      | 1. take_snapshot to verify element existence |
      | 2. list_console_messages for JavaScript errors |
      | 3. evaluate_script to try direct DOM manipulation |
      | 4. take screenshot to document the situation |
    Then identify the root cause and apply appropriate solution

  @success-error-message-confirmation
  Scenario: Verify success/error messages
    # Confirming state after operations
    When executing form submission or data change operations
    Then verify the following:
      | Success message display |
      | Data change reflection |
      | Page state update |
    And record final state with take_snapshot

  @direct-url-navigation-pattern
  Scenario: Direct URL navigation pattern
    # Direct page access using IDs
    Given needing to access specific resource information
    When navigating directly to "/users/[userId]" format URL
    Then target resource detail page opens directly
    And no need to click through menus for navigation
    # Example: http://localhost:3000/users/123

  @evaluate-script-return-value-improvement
  Scenario: Improve evaluate_script return values
    # Clarify success/failure determination in JavaScript execution
    When executing DOM operations with evaluate_script
    Then return specific results on success:
      """
      return 'Selected [value] option';
      """
    And return clear error messages on failure:
      """
      return 'Option not found';
      """
    And enable execution result determination through return values

  @form-validation-handling
  Scenario: Handle form validation and errors
    # Dealing with client-side validation
    Given form with validation rules is displayed
    When submitting form with invalid data
    Then validation error messages should appear
    And form should not be submitted
    When correcting the validation errors
    And resubmitting the form
    Then validation should pass
    And form should submit successfully

  @loading-state-management
  Scenario: Manage loading states and async operations
    # Handle async operations and loading indicators
    Given user initiates an async operation (form submit, data fetch)
    When operation is in progress
    Then loading indicator should be displayed
    And interactive elements should be disabled
    When operation completes successfully
    Then loading indicator should disappear
    And success state should be displayed
    And interactive elements should be re-enabled