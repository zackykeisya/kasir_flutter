import 'package:flutter/material.dart';
import '../models/tiket_model.dart';
import 'success_page.dart';
import 'modals/modal_tunai.dart';
import 'modals/modal_kartu_kredit.dart';
import 'modals/modal_qris.dart';

class PaymentPage extends StatefulWidget {
  final TiketModel ticket;

  PaymentPage({required this.ticket});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPaymentMethod = 'Kartu Kredit'; // Default selected

  String formatCurrency(int amount) {
    return 'Rp ${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  void showPaymentModal(String method) {
    Widget modal;
    switch (method) {
      case 'Tunai (Cash)':
        modal = ModalTunai(
          ticket: widget.ticket,
          onPaymentComplete: () => navigateToSuccess(),
        );
        break;
      case 'Kartu Kredit':
        modal = ModalKartuKredit(
          ticket: widget.ticket,
          onPaymentComplete: () => navigateToSuccess(),
        );
        break;
      case 'QRIS / QR Pay':
        modal = ModalQris(
          ticket: widget.ticket,
          onPaymentComplete: () => navigateToSuccess(),
        );
        break;
      default:
        return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => modal,
    );
  }

  void navigateToSuccess() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SuccessPage(ticket: widget.ticket),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Pembayaran',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total Tagihan Section
            Text(
              'Total Tagihan',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 4),
            Text(
              formatCurrency(widget.ticket.harga),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 24),

            // Divider
            Divider(height: 1, color: Colors.grey[300]),
            SizedBox(height: 24),

            // Ticket Info Section
            Text(
              'Nama Pesanan',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 4),
            Text(
              '${widget.ticket.nama} - VIP',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Tanggal',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 4),
            Text(
              widget.ticket.tanggal,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 24),

            // Divider
            Divider(height: 1, color: Colors.grey[300]),
            SizedBox(height: 24),

            // Payment Methods Section
            Text(
              'Pilih Metode Pembayaran',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),

            // Payment Method Options
            Column(
              children: [
                // Tunai (Cash)
                PaymentMethodOption(
                  title: 'Tunai (Cash)',
                  isSelected: selectedPaymentMethod == 'Tunai (Cash)',
                  iconUrl: 'https://cdn-icons-png.flaticon.com/512/2703/2703633.png', // Cash icon
                  onTap: () {
                    setState(() {
                      selectedPaymentMethod = 'Tunai (Cash)';
                    });
                  },
                ),
                SizedBox(height: 12),
                
                // Kartu Kredit
                PaymentMethodOption(
                  title: 'Kartu Kredit',
                  isSelected: selectedPaymentMethod == 'Kartu Kredit',
                  iconUrl: 'https://cdn-icons-png.flaticon.com/512/196/196578.png', // Credit card icon
                  onTap: () {
                    setState(() {
                      selectedPaymentMethod = 'Kartu Kredit';
                    });
                  },
                ),
                SizedBox(height: 12),
                
                // QRIS / QR Pay
                PaymentMethodOption(
                  title: 'QRIS / QR Pay',
                  isSelected: selectedPaymentMethod == 'QRIS / QR Pay',
                  iconUrl: 'https://cdn-icons-png.flaticon.com/512/2413/2413019.png', // QR code icon
                  onTap: () {
                    setState(() {
                      selectedPaymentMethod = 'QRIS / QR Pay';
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 24),

            // Divider
            Divider(height: 1, color: Colors.grey[300]),
            SizedBox(height: 24),

            // Help Section
            Row(
              children: [
                Icon(
                  Icons.help_outline,
                  color: Colors.grey[600],
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Punya pertanyaan?',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                SizedBox(width: 28), // To align with the icon above
                Text(
                  '1️⃣ Hubungi Admin untuk bantuan pembayaran.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Pay Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => showPaymentModal(selectedPaymentMethod),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4F46E5),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Bayar Sekarang',
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
    );
  }
}

class PaymentMethodOption extends StatelessWidget {
  final String title;
  final bool isSelected;
  final String iconUrl;
  final VoidCallback onTap;

  const PaymentMethodOption({
    required this.title,
    required this.isSelected,
    required this.iconUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget leadingIcon;
    if (title == 'Tunai (Cash)') {
      // Cash Icon (local)
      leadingIcon = Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: Color(0xFF10B981).withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.payments,
          color: Color(0xFF10B981),
          size: 18,
        ),
      );
    } else if (title == 'Kartu Kredit') {
      // Credit Card Icon (local)
      leadingIcon = Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: Color(0xFF8B5CF6).withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.credit_card,
          color: Color(0xFF8B5CF6),
          size: 18,
        ),
      );
    } else if (title == 'QRIS / QR Pay') {
      // QR Icon (local)
      leadingIcon = Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: Color(0xFFF59E42).withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.qr_code_2,
          color: Color(0xFFF59E42),
          size: 18,
        ),
      );
    } else {
      // Network icon for other payment methods
      leadingIcon = Image.network(
        iconUrl,
        width: 24,
        height: 24,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.payment,
          color: isSelected ? Color(0xFF4F46E5) : Colors.grey,
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Color(0xFF4F46E5) : Colors.grey[300]!,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            leadingIcon,
            SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Spacer(),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? Color(0xFF4F46E5) : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}