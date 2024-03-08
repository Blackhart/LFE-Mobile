class BankAccount {
  final String id;
  final String name;
  final String type;
  final double balance;

  BankAccount({
    required this.id,
    required this.name,
    required this.type,
    required this.balance
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) {
    return BankAccount(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      balance: json['balance'] as double
    );
  }
}