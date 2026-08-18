class QuotationItemModel {
  final String id;
  final String title;
  final String description;
  final int quantity;
  final int days;
  final double rate;
  final double amount;

  QuotationItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.quantity,
    required this.days,
    required this.rate,
    required this.amount,
  });
}
