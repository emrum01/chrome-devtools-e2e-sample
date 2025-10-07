'use client'

import { useState } from 'react'
import Link from 'next/link'

const mockProducts = [
  {
    id: 1,
    name: 'Wireless Headphones',
    price: 299,
    category: 'Electronics',
    stock: 15,
    description: 'High-quality wireless headphones with noise cancellation'
  },
  {
    id: 2,
    name: 'Smart Watch',
    price: 399,
    category: 'Electronics',
    stock: 8,
    description: 'Advanced smartwatch with health monitoring features'
  },
  {
    id: 3,
    name: 'Coffee Maker',
    price: 199,
    category: 'Home & Kitchen',
    stock: 5,
    description: 'Automatic coffee maker with programmable settings'
  },
  {
    id: 4,
    name: 'Running Shoes',
    price: 129,
    category: 'Sports',
    stock: 20,
    description: 'Comfortable running shoes for all terrain'
  }
]

export default function ProductsPage() {
  const [searchTerm, setSearchTerm] = useState('')
  const [selectedCategory, setSelectedCategory] = useState('All')
  const [cart, setCart] = useState<number[]>([])

  const categories = ['All', ...new Set(mockProducts.map(p => p.category))]

  const filteredProducts = mockProducts.filter(product => {
    const matchesSearch = product.name.toLowerCase().includes(searchTerm.toLowerCase())
    const matchesCategory = selectedCategory === 'All' || product.category === selectedCategory
    return matchesSearch && matchesCategory
  })

  const addToCart = (productId: number) => {
    setCart([...cart, productId])
  }

  return (
    <div className="min-h-screen bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-6xl mx-auto">
        <div className="text-center mb-8">
          <h1 className="text-3xl font-bold text-gray-900">Product Catalog</h1>
          <p className="mt-2 text-gray-600">Browse our selection of products</p>
          <Link
            href="/"
            className="mt-4 inline-block text-blue-600 hover:text-blue-500"
          >
            ← Back to Home
          </Link>
        </div>

        {/* Search and Filter */}
        <div className="mb-8 bg-white p-6 rounded-lg shadow">
          <div className="flex flex-col sm:flex-row gap-4">
            <div className="flex-1">
              <label htmlFor="search" className="block text-sm font-medium text-gray-700 mb-2">
                Search Products
              </label>
              <input
                type="text"
                id="search"
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                placeholder="Search by product name..."
                className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
            <div className="sm:w-64">
              <label htmlFor="category" className="block text-sm font-medium text-gray-700 mb-2">
                Category
              </label>
              <select
                id="category"
                value={selectedCategory}
                onChange={(e) => setSelectedCategory(e.target.value)}
                className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
              >
                {categories.map(category => (
                  <option key={category} value={category}>{category}</option>
                ))}
              </select>
            </div>
          </div>
        </div>

        {/* Shopping Cart Status */}
        {cart.length > 0 && (
          <div className="mb-6 p-4 bg-green-50 border border-green-200 rounded-md">
            <p className="text-green-800">
              Cart: {cart.length} item{cart.length !== 1 ? 's' : ''} added
              <button
                onClick={() => setCart([])}
                className="ml-4 text-green-600 hover:text-green-500 underline"
              >
                Clear Cart
              </button>
            </p>
          </div>
        )}

        {/* Product Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
          {filteredProducts.map(product => (
            <div key={product.id} className="bg-white rounded-lg shadow-md overflow-hidden">
              <div className="p-6">
                <h3 className="text-lg font-semibold text-gray-900 mb-2">{product.name}</h3>
                <p className="text-sm text-gray-600 mb-4">{product.description}</p>
                <div className="flex justify-between items-center mb-4">
                  <span className="text-2xl font-bold text-blue-600">${product.price}</span>
                  <span className="text-sm text-gray-500">{product.category}</span>
                </div>
                <div className="flex justify-between items-center mb-4">
                  <span className="text-sm text-gray-600">
                    Stock: {product.stock} available
                  </span>
                  <span className={`px-2 py-1 text-xs rounded ${
                    product.stock > 10 ? 'bg-green-100 text-green-800' :
                    product.stock > 5 ? 'bg-yellow-100 text-yellow-800' :
                    'bg-red-100 text-red-800'
                  }`}>
                    {product.stock > 10 ? 'In Stock' :
                     product.stock > 5 ? 'Low Stock' : 'Very Low'}
                  </span>
                </div>
                <button
                  onClick={() => addToCart(product.id)}
                  disabled={product.stock === 0}
                  className="w-full bg-blue-600 text-white py-2 px-4 rounded hover:bg-blue-700 disabled:bg-gray-300 disabled:cursor-not-allowed"
                >
                  {product.stock === 0 ? 'Out of Stock' : 'Add to Cart'}
                </button>
              </div>
            </div>
          ))}
        </div>

        {filteredProducts.length === 0 && (
          <div className="text-center py-12">
            <p className="text-gray-500">No products found matching your criteria.</p>
          </div>
        )}
      </div>
    </div>
  )
}