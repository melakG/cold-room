class ProductType {
  final String image;
  final String name;
  final int remainQty;
  final int soldQty;
  final DateTime addedDate;

  ProductType(
      {required this.image,
      required this.name,
      required this.remainQty,
      required this.soldQty,
      required this.addedDate});

  factory ProductType.fromJson(Map<String, dynamic> json) {
    return ProductType(
        image: json["image"],
        name: json["name"],
        remainQty: json["remainingQuantity"],
        soldQty: json["soldQuantity"],
        addedDate: DateTime.now());
  }
}
