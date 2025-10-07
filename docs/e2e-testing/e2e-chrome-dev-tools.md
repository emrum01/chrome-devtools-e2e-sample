# Chrome DevTools MCP E2E Testing Framework

This document defines the execution procedures for E2E testing using Chrome DevTools MCP server.

## Overview

Each test case is defined in independent Gherkin files, and this document manages the execution flow. **Test execution is the main purpose of this document**, with environment configuration and URL information positioned as reference materials.

## Basic Test Execution Flow

### 1. Prerequisites
- Confirm Chrome DevTools MCP server is running
- Verify target environment applications are accessible
- **Obtain test account information**:
  ```
  Test accounts should be prepared in advance or retrieved from secure storage.

  Information to obtain:
  - test-user@example.com password
  - admin-user@example.com password
  - Other test account credentials

  Reuse this information during the session once obtained
  ```

### 2. Execution Steps
1. **Browser Launch**: Open the target environment app in multiple tabs
2. **Authentication Check**: Immediately verify authentication status for each app (terminate if unauthenticated)
3. **Test Execution**: Execute specified test cases sequentially
4. **Result Verification**: Compare with expected results
5. **Report Generation**: Record execution results

### 3. Important Execution Rules
- **Immediate termination on authentication failure**: If authentication is not complete, terminate test immediately and request user authentication
- **Independent execution**: Each test must be executable independently
- **Data consistency**: Maintain data consistency before and after test execution

## Available Test Cases

| Test Name | Description | Prerequisites | Execution File |
|-----------|-------------|---------------|----------------|
| User Authentication Test | Login processing and user ID extraction test | • Test user account exists | [`features/user-authentication.feature`](features/user-authentication.feature) |
| Product Search Test | Search and filter products test | • User logged in | [`features/product-search.feature`](features/product-search.feature) |
| Admin User Management Test | User role change test from admin panel | • Admin privileges logged in<br>• Target user account exists | [`features/admin-user-management.feature`](features/admin-user-management.feature) |
| Shopping Cart Test | Add products to cart and checkout test | • User logged in<br>• Products available | [`features/shopping-cart.feature`](features/shopping-cart.feature) |

---

## Reference Information

### Test Environment URLs

**Usage**: Select the appropriate environment and application type URL from the table below according to test execution instructions.

| Environment | Application Type | URL | Description |
|-------------|------------------|-----|-------------|
| local | Main App | http://localhost:3000 | Local development main application |
| dev | Main App | https://dev.example.com | Development environment |
| staging | Main App | https://staging.example.com | Staging environment |

### Browser Operation Basic Rules

- **Tab Management**: Manage different application views (user, admin, etc.) in different tabs of one browser window
- **Authentication Check**: Immediately verify authentication status when accessing each app (required)
- **Authentication Failure**: If unauthenticated, immediately terminate test and request user authentication
- **Tab Switching**: Switch to appropriate tabs according to operation target

### Page Load Confirmation Strategy

When application response is slow, confirm page load completion in the following order:

#### 1. Network Status Check
```
list_network_requests → Confirm no ongoing API requests
```

#### 2. React Component Loading Status Check
```
evaluate_script → Check for loading indicators
take_snapshot → Confirm disappearance of loading elements (spinners, progress bars, etc.)
```

#### 3. DOM Element Stability Check
```
take_snapshot → Confirm target elements exist and are operable
```

#### 4. Wait Strategy Priority
1. **Recommended**: Network + React status check
2. **Alternative**: `wait_for` specific elements (only when elements definitely exist)
3. **Not recommended**: Fixed time wait

## Test Execution Flow

1. **Obtain test account information**
   - Execute once at session start
   - Reuse obtained information during session
2. Launch browser and open necessary tabs
3. Verify authentication status (terminate immediately if unauthenticated)
4. Execute specified operations sequentially
5. Verify and report results

## Error Handling

### Authentication Errors
- If authentication cannot be verified, immediately terminate test
- Output error message and request user authentication

### Element Not Found
- If specified element not found, output detailed error information
- Take screenshot to verify current status

### Page Load Delays
- **Network timeout**: Identify long-unresponsive API requests and record details
- **Component not rendered**: If React component not rendered, check console.errors
- **JavaScript errors**: Collect and analyze browser errors with `list_console_messages`

### Timeouts
- Set appropriate timeout for each operation
- Record current status with screenshot on timeout
- Record network status and console errors simultaneously

## Important Notes

- Each test must be executable independently
- Maintain data consistency before and after test execution
- Avoid execution in production environments
- Properly clean up test data