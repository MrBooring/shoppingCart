class TransactionModel {
  final int? id;
  final String date;
  final double total;
  final double discount;
  final String items;

  TransactionModel({
    this.id,
    required this.date,
    required this.total,
    required this.discount,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'total': total,
      'discount': discount,
      'items': items,
    };
  }

  static TransactionModel fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      date: map['date'],
      total: map['total'],
      discount: map['discount'],
      items: map['items'],
    );
  }
}
