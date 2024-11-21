enum OfferType {
  percentageOff,
  buyOneGetOneFree,
}

class Discount {
  final String code;
  final String description;
  final double percentage;
  final int minAmount;
  final OfferType offerType;

  Discount({
    required this.code,
    required this.description,
    required this.percentage,
    required this.minAmount,
    required this.offerType,
  });
}
