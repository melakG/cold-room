class Withdraw {
  int id;
  int balance;
  DateTime dateTime;

  Withdraw({required this.id, required this.balance, required this.dateTime});

  factory Withdraw.fromJson(Map<String, dynamic> json) {
    var dateTime = DateTime.parse(json["updatedAt"]);
    return Withdraw(
        id: json["id"], balance: json["balanceAmount"], dateTime: dateTime);
  }
}
