Feature: Shopping Cart Management
  Add products to cart and manage shopping cart functionality

  Background:
    Given browser is launched
    And user is logged into the application
    And user is on the products page

  @add-to-cart-single
  Scenario: Add single product to cart
    Given the product catalog is displayed
    When user finds product "Wireless Headphones"
    And product shows "In Stock" status
    And user clicks "Add to Cart" button for that product
    Then cart status should update to show "Cart: 1 item added"
    And cart notification should be displayed

  @add-to-cart-multiple
  Scenario: Add multiple products to cart
    Given the product catalog is displayed
    When user adds "Wireless Headphones" to cart
    And user adds "Smart Watch" to cart
    And user adds "Coffee Maker" to cart
    Then cart status should show "Cart: 3 items added"
    And cart should contain all selected products

  @add-to-cart-out-of-stock
  Scenario: Attempt to add out of stock product
    Given the product catalog is displayed
    When user finds a product with "Out of Stock" status
    Then "Add to Cart" button should be disabled
    And button text should show "Out of Stock"
    And user should not be able to add the product to cart

  @add-to-cart-low-stock-warning
  Scenario: Add product with low stock
    Given the product catalog is displayed
    When user finds product with "Low Stock" or "Very Low" status
    And user clicks "Add to Cart" button
    Then product should be added to cart
    And cart should show updated item count
    And low stock indicator should remain visible

  @clear-cart
  Scenario: Clear shopping cart
    Given user has added multiple products to cart
    And cart shows "Cart: 3 items added"
    When user clicks "Clear Cart" button
    Then cart should be emptied
    And cart notification should disappear
    And cart status should no longer be displayed

  @cart-persistence
  Scenario: Verify cart persists during session
    Given user has added products to cart
    And cart shows items added
    When user navigates to admin panel
    And user returns to products page
    Then cart status should still show the same number of items
    And cart contents should be preserved