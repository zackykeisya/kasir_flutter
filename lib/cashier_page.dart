import 'package:flutter/material.dart';
import 'checkout_page.dart';

class CashierPage extends StatefulWidget {
  const CashierPage({super.key});

  @override
  State<CashierPage> createState() => _CashierPageState();
}

class _CashierPageState extends State<CashierPage> {
  final TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> products = [
    {
      "image": "assets/images/1.jpeg",
      "name": "Indomie Goreng",
      "price": 2000,
      "stock": 20,
      "quantity": 0,
    },
    {
      "image": "assets/images/2.jpeg",
      "name": "Indomie",
      "price": 24000,
      "stock": 15,
      "quantity": 0,
    },
    {
      "image": "assets/images/3.jpeg",
      "name": "Susu Coklat",
      "price": 15000,
      "stock": 10,
      "quantity": 0,
    },
    {
      "image": "assets/images/4.jpeg",
      "name": "Teh Botol",
      "price": 9000,
      "stock": 25,
      "quantity": 0,
    }
  ];

  int _totalStockChanges = 0;
  int _totalHarga = 0;

  void _increaseStock(int index) {
    setState(() {
      products[index]['quantity']++;
      _totalStockChanges++;
      _totalHarga += (products[index]['price'] as int);
    });
  }

  void _decreaseStock(int index) {
    setState(() {
      if (products[index]['quantity'] > 0) {
        products[index]['quantity']--;
        _totalStockChanges--;
        _totalHarga -= (products[index]['price'] as int);
      }
    });
  }

  void _navigateToCheckout() {
    final checkoutItems =
        products.where((item) => item['quantity'] > 0).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutPage(
          checkoutItems: checkoutItems,
          totalPrice: _totalHarga,
        ),
      ),
    ).then((_) {
      setState(() {
        for (var product in products) {
          product['quantity'] = 0;
        }
        _totalStockChanges = 0;
        _totalHarga = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "💰 Cashier App",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const Text(
              "Semoga harimu menyenangkan :)",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Cari produk...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: products.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 15),
                itemBuilder: (context, index) {
                  final item = products[index];
                  return Container(
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            bottomLeft: Radius.circular(16.0),
                          ),
                          child: Image.asset(
                            item["image"],
                            height: 110,
                            width: 110,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  item["name"],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Rp. ${item["price"]}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Row(
                            children: [
                              _buildStockButton(
                                icon: Icons.remove,
                                color: Colors.redAccent,
                                onPressed: () => _decreaseStock(index),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  "${item["quantity"]}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              _buildStockButton(
                                icon: Icons.add,
                                color: Colors.green,
                                onPressed: () => _increaseStock(index),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "🧮 Total Perubahan Stok: $_totalStockChanges\n💸 Total Harga: Rp $_totalHarga",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (_totalStockChanges > 0)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _navigateToCheckout,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Checkout',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStockButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: color),
        onPressed: onPressed,
      ),
    );
  }
}
