class SoldProduct {
  String productName;
  String typeName;
  String? quality;
  int soldAmount;
  double soldPrice;
  int rentCost;
  DateTime date;
  int netBalance;
  String image;

  SoldProduct(
      {required this.productName,
      required this.typeName,
      this.quality,
      required this.image,
      required this.soldAmount,
      required this.soldPrice,
      required this.rentCost,
      required this.date,
      required this.netBalance});

  factory SoldProduct.fromJson(Map<String, dynamic> json) {
    return SoldProduct(
        productName: json['productName'],
        typeName: json['typeName'],
        image: json["image"],
        soldAmount: json['soldAmount'],
        soldPrice: json['totalBalance'].toDouble(),
        rentCost: json['rentCost'],
        date: DateTime.parse(json['date']),
        netBalance: json['netBalance']);
  }
}
