class TiketModel {
  final String id;
  final String nama;
  final String kategori;
  final int harga;
  final String tanggal;

  TiketModel({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.tanggal,
  });

  factory TiketModel.fromJson(Map<String, dynamic> json) {
    return TiketModel(
      id: json['id'] ?? '',
      nama: json['nama'] ?? '',
      kategori: json['kategori'] ?? '',
      harga: json['harga'] ?? 0,
      tanggal: json['tanggal'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'kategori': kategori,
      'harga': harga,
      'tanggal': tanggal,
    };
  }
}