class Budget {
  final String id;
  final String name;

  Budget({required this.id, required this.name});

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      id: json['id'],
      name: json['name'],
    );
  }
}
