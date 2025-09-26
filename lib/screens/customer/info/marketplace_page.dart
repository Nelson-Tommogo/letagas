import 'package:flutter/material.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({super.key});

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Gas',
    'Burners',
    'Grills',
    'Accessories',
  ];

  // Map product names to their image URLs
  final Map<String, String> productImages = {
    '13kg LPG Gas Cylinder':
        'https://drive.google.com/thumbnail?id=1OftV0FJUNGdhocYFLBjLvchlg5nLOg-e',
    '6kg LPG Gas Cylinder':
        'https://drive.google.com/thumbnail?id=1-1Xja5MFVIct0m8h8rj8zULPVTWA6AOo',
    'Double Burner Stove':
        'https://drive.google.com/thumbnail?id=1OQxIlNAoS2HQVff6WR1tsNZgeg5fsuzZ',
    'Single Burner Stove':
        'https://drive.google.com/thumbnail?id=1MS7h5-8ebPTDEZrAQez63DGTY6ZlrBwt',
    'Charcoal Grill':
        'https://drive.google.com/thumbnail?id=11dDn_Wqe-Zia97E9c1xc3tD1E8s8fXsb',
    'Premium Gas Regulator':
        'https://drive.google.com/thumbnail?id=1K3IF36UKouULXk-NqZ1hiUjwn0iOoj2w',
    'High-Quality Gas Hose':
        'https://drive.google.com/thumbnail?id=1tVYzCw8zWkVH-eSVYPeRJvq5bvJ3zb1t',
    'Portable Cooking Grill':
        'https://drive.google.com/thumbnail?id=1V-Z6Hy-OMg6j7yxLsnIyLvjjaWNRyC8S',
  };

  final List<Map<String, dynamic>> products = [
    {
      'name': '13kg LPG Gas Cylinder',
      'category': 'Gas',
      'price': 3000,
      'rating': 4.5,
      'reviews': 124,
    },
    {
      'name': '6kg LPG Gas Cylinder',
      'category': 'Gas',
      'price': 1500,
      'rating': 4.2,
      'reviews': 89,
    },
    {
      'name': 'Double Burner Stove',
      'category': 'Burners',
      'price': 2500,
      'rating': 4.7,
      'reviews': 156,
    },
    {
      'name': 'Single Burner Stove',
      'category': 'Burners',
      'price': 1200,
      'rating': 4.3,
      'reviews': 92,
    },
    {
      'name': 'Charcoal Grill',
      'category': 'Grills',
      'price': 3500,
      'rating': 4.8,
      'reviews': 201,
    },
    {
      'name': 'Premium Gas Regulator',
      'category': 'Accessories',
      'price': 700,
      'rating': 4.1,
      'reviews': 67,
    },
    {
      'name': 'High-Quality Gas Hose',
      'category': 'Accessories',
      'price': 400,
      'rating': 4.0,
      'reviews': 53,
    },
    {
      'name': 'Portable Cooking Grill',
      'category': 'Grills',
      'price': 4200,
      'rating': 4.9,
      'reviews': 178,
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    return products.where((product) {
      final matchesCategory = _selectedCategory == 'All' ||
          product['category'] == _selectedCategory;
      final matchesSearch =
          product['name'].toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Marketplace',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFF05E23),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: () {
              _showCategoryFilter(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              // Navigate to cart
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with search
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF05E23),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Find the perfect',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Cooking Equipment',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // Search bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.grey),
                            onPressed: () {
                              setState(() {
                                _searchQuery = '';
                                _searchController.clear();
                              });
                            },
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ],
            ),
          ),

          // Category filter chips
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = categories[index];
                return FilterChip(
                  label: Text(category),
                  selected: _selectedCategory == category,
                  selectedColor: const Color(0xFFF05E23),
                  backgroundColor: Colors.grey[200],
                  labelStyle: TextStyle(
                    color: _selectedCategory == category
                        ? Colors.white
                        : Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                  showCheckmark: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                );
              },
            ),
          ),

          // Products section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular Products',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  '${filteredProducts.length} items',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Products grid
          Expanded(
            child: filteredProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 60,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No products found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try a different search or category',
                          style: TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return ProductCard(
                        product: product,
                        imageUrl: productImages[product['name']] ?? '',
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showCategoryFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: SizedBox(
                  width: 40,
                  child: Divider(thickness: 3, height: 24),
                ),
              ),
              const Text(
                'Filter by Category',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...categories.map((category) => ListTile(
                    title: Text(
                      category,
                      style: TextStyle(
                        fontWeight: _selectedCategory == category
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    trailing: _selectedCategory == category
                        ? const Icon(Icons.check, color: Color(0xFFF05E23))
                        : null,
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                      Navigator.pop(context);
                    },
                  )),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF05E23),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Apply Filters',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final String imageUrl;

  const ProductCard({super.key, required this.product, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // Navigate to product detail
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey[200],
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFFF05E23)),
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[200],
                      child: Center(
                        child: Icon(
                          _getCategoryIcon(product['category']),
                          size: 40,
                          color: const Color(0xFFF05E23),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                product['name'],
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                product['category'],
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              // Rating row
              Row(
                children: [
                  Icon(Icons.star_rounded, color: Colors.amber[600], size: 16),
                  const SizedBox(width: 4),
                  Text(
                    product['rating'].toString(),
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    ' (${product['reviews']})',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ksh ${product['price']}',
                    style: const TextStyle(
                      color: Color(0xFFF05E23),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Add to cart
                    },
                    icon: const Icon(Icons.add_shopping_cart_rounded,
                        color: Color(0xFFF05E23), size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Gas':
        return Icons.local_gas_station_rounded;
      case 'Burners':
        return Icons.fireplace_rounded;
      case 'Grills':
        return Icons.outdoor_grill_rounded;
      case 'Accessories':
        return Icons.settings_input_component_rounded;
      default:
        return Icons.shopping_bag_rounded;
    }
  }
}
