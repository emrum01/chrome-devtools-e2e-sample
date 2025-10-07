Feature: Product Search and Filtering
  Search for products and apply filters in the product catalog

  Background:
    Given browser is launched
    And user is logged into the application
    And user is on the products page

  @product-search-basic
  Scenario: Search products by name
    Given the product catalog page is displayed
    When user enters "Headphones" in the search field
    And user waits for search results to update
    Then products containing "Headphones" should be displayed
    And products not matching the search should be hidden

  @product-filter-category
  Scenario: Filter products by category
    Given the product catalog page is displayed
    When user selects "Electronics" from the category dropdown
    And user waits for filter to apply
    Then only products in "Electronics" category should be displayed
    And the product count should reflect filtered results

  @product-search-and-filter
  Scenario: Combine search and category filter
    Given the product catalog page is displayed
    When user enters "Smart" in the search field
    And user selects "Electronics" from the category dropdown
    And user waits for combined filters to apply
    Then only "Electronics" products containing "Smart" should be displayed
    And non-matching products should be hidden

  @product-search-no-results
  Scenario: Search with no matching results
    Given the product catalog page is displayed
    When user enters "NonexistentProduct123" in the search field
    And user waits for search results to update
    Then "No products found" message should be displayed
    And product grid should be empty

  @product-clear-filters
  Scenario: Clear search and filters
    Given user has applied search term "Smart" and category filter "Electronics"
    And filtered results are displayed
    When user clears the search field
    And user selects "All" from the category dropdown
    Then all available products should be displayed
    And product count should show total number of products