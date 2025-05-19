import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckoutPage extends StatelessWidget {
  final List<Map<String, dynamic>> checkoutItems;
  final int totalPrice;

  const CheckoutPage({
    super.key,
    required this.checkoutItems,
    required this.totalPrice,
  });

  String formatRupiah(int amount) {
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return formatCurrency.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Struk Pembelian"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'TOKO ZACKY MART',
                  style: const TextStyle(
                    fontFamily: 'Courier',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: Text(
                  'Jl. Raya SMK Wikrama No.1, Bogor',
                  style: const TextStyle(fontFamily: 'Courier', fontSize: 12),
                ),
              ),
              const Divider(thickness: 1, color: Colors.black87),
              Text(
                'Tanggal : ${DateFormat('dd/MM/yyyy – HH:mm').format(DateTime.now())}',
                style: const TextStyle(fontFamily: 'Courier', fontSize: 12),
              ),
              const SizedBox(height: 10),
              const Text(
                'Nama Barang          Qty   Subtotal',
                style: TextStyle(
                  fontFamily: 'Courier',
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const Divider(thickness: 1, color: Colors.black87),
              ...checkoutItems.map((item) {
                final subtotal = item['price'] * item['quantity'];
                final name = item['name'].length > 18
                    ? item['name'].substring(0, 18)
                    : item['name'].padRight(18);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(
                    '$name  ${item['quantity'].toString().padLeft(3)}x  ${formatRupiah(subtotal)}',
                    style: const TextStyle(fontFamily: 'Courier', fontSize: 12),
                  ),
                );
              }).toList(),
              const Divider(thickness: 1, color: Colors.black87),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'TOTAL: ${formatRupiah(totalPrice)}',
                  style: const TextStyle(
                    fontFamily: 'Courier',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  '** TERIMA KASIH **',
                  style: TextStyle(
                    fontFamily: 'Courier',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              const Center(
                child: Text(
                  'Barang yang sudah dibeli\n'
                  'tidak dapat dikembalikan.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Courier', fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
