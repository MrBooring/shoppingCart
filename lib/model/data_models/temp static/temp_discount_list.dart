import '../discount.dart';

List<Discount> discounts = [
  Discount(
    code: "BOGO",
    description: "Buy 2, Get 1 Free (Quantity 3 to get 3rd for free )",
    percentage: 0.0, // Not used for this offer
    minAmount: 0,
    offerType: OfferType.buyOneGetOneFree,
  ),
  Discount(
    code: "DISCOUNT10",
    description: "10% off on orders above \$100",
    percentage: 10.0, // Percentage discount
    minAmount: 100, // Minimum purchase for the discount
    offerType: OfferType.percentageOff,
  ),
];
