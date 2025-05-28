import '../models/tiket_model.dart';

class FirebaseService {
  // Simulasi data tiket
  static List<TiketModel> getDummyTickets() {
    return [
      TiketModel(
        id: '1',
        nama: 'Tiket untuk dewasa',
        kategori: 'Regular',
        harga: 300000,
        tanggal: '22 Mei 2025',
      ),
      TiketModel(
        id: '2',
        nama: 'Tiket untuk dewasa',
        kategori: 'Regular',
        harga: 450000,
        tanggal: '22 Mei 2025',
      ),
      TiketModel(
        id: '3',
        nama: 'Tiket untuk Anak',
        kategori: 'Regular',
        harga: 150000,
        tanggal: '22 Mei 2025',
      ),
      TiketModel(
        id: '4',
        nama: 'Tiket untuk Anak',
        kategori: 'Regular',
        harga: 250000,
        tanggal: '22 Mei 2025',
      ),
    ];
  }

  // Simulasi proses pembayaran
  static Future<bool> processPayment(String paymentMethod, int amount) async {
    await Future.delayed(Duration(seconds: 2));
    return true; // Simulasi berhasil
  }
}