class Summary {
  int balance;
  int productInstore;
  Summary({required this.balance, required this.productInstore});

  factory Summary.fromJson(Map<String, dynamic> json) {
 

    return Summary(
        balance: json["farmerBalance"],
        productInstore: json["farmerProduct"]);
  }
}
