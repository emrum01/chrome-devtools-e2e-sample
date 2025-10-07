import Link from 'next/link'

export default function Home() {
  return (
    <div className="min-h-screen bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-4xl mx-auto">
        <div className="text-center">
          <h1 className="text-4xl font-bold text-gray-900 sm:text-5xl md:text-6xl">
            Sample E-commerce App
          </h1>
          <p className="mt-3 max-w-md mx-auto text-base text-gray-500 sm:text-lg md:mt-5 md:text-xl md:max-w-3xl">
            A demo application for Chrome DevTools MCP E2E testing with Gherkin scenarios
          </p>
        </div>

        <div className="mt-10 max-w-sm mx-auto grid grid-cols-1 gap-8 sm:max-w-none sm:grid-cols-2 lg:grid-cols-3">
          <div className="text-center">
            <div className="bg-white rounded-lg shadow-lg p-6">
              <h3 className="text-lg font-medium text-gray-900">User Management</h3>
              <p className="mt-2 text-base text-gray-500">
                Login, registration, and profile management
              </p>
              <div className="mt-4">
                <Link
                  href="/auth/login"
                  className="inline-flex items-center px-4 py-2 border border-transparent text-base font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700"
                >
                  Go to Login
                </Link>
              </div>
            </div>
          </div>

          <div className="text-center">
            <div className="bg-white rounded-lg shadow-lg p-6">
              <h3 className="text-lg font-medium text-gray-900">Product Catalog</h3>
              <p className="mt-2 text-base text-gray-500">
                Browse products and add to cart
              </p>
              <div className="mt-4">
                <Link
                  href="/products"
                  className="inline-flex items-center px-4 py-2 border border-transparent text-base font-medium rounded-md text-white bg-green-600 hover:bg-green-700"
                >
                  Browse Products
                </Link>
              </div>
            </div>
          </div>

          <div className="text-center">
            <div className="bg-white rounded-lg shadow-lg p-6">
              <h3 className="text-lg font-medium text-gray-900">Admin Panel</h3>
              <p className="mt-2 text-base text-gray-500">
                Manage users, products, and orders
              </p>
              <div className="mt-4">
                <Link
                  href="/admin"
                  className="inline-flex items-center px-4 py-2 border border-transparent text-base font-medium rounded-md text-white bg-purple-600 hover:bg-purple-700"
                >
                  Admin Panel
                </Link>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
