---
allowed_tools:
  - "mcp__chrome-devtools__*"
  - "!mcp__chrome-devtools__close_page"
  - "!mcp__chrome-devtools__resize_page"
  - "!mcp__chrome-devtools__emulate_*"
---

# Chrome DevTools E2E Testing Command

Execute E2E tests using Chrome DevTools MCP and Gherkin scenarios.

## Usage

```
/e2e-testing [scenario description]
```

## Examples

- `/e2e-testing user login and product search`
- `/e2e-testing admin user management workflow`
- `/e2e-testing shopping cart functionality`

## Available Test Scenarios

| Command Example | Test File | Description |
|----------------|-----------|-------------|
| `user authentication test` | `user-authentication.feature` | Login and session verification |
| `product search and filter` | `product-search.feature` | Product catalog operations |
| `admin user management` | `admin-user-management.feature` | Admin panel user management |
| `shopping cart operations` | `shopping-cart.feature` | Cart add/remove functionality |

## Test Execution Flow

1. **Initial Command**: Run `/e2e-testing [scenario description]`
2. **Feature File Selection**: AI automatically selects appropriate test files
3. **Step-by-Step Execution**: Progress through test scenarios
4. **Best Practices Application**: Apply UI operation patterns when needed

## Example Workflow

```
# 1. Start testing
/e2e-testing user login and product search

# 2. Execute specific feature file
Run 'docs/e2e-testing/features/user-authentication.feature'

# 3. Continue with product search
Run 'docs/e2e-testing/features/product-search.feature'

# 4. Apply best practices if UI issues occur
Apply patterns from 'docs/e2e-testing/features/ui-best-practices.feature'

# 5. Continue execution
Continue with next steps
```

## Environment Configuration

- **Local**: http://localhost:3000
- **Dev**: https://dev.example.com
- **Staging**: https://staging.example.com

## Test Accounts

Use the following test accounts for scenarios:
- **Customer**: test@example.com / password123
- **Admin**: admin@example.com / admin123
- **Manager**: manager@example.com / manager123