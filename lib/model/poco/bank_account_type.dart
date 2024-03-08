class BankAccountType {
  final String value;

  const BankAccountType._(this.value);

  static const BankAccountType standard = BankAccountType._('STANDARD');
  static const BankAccountType savings = BankAccountType._('SAVING');
  static const BankAccountType trading = BankAccountType._('TRADING');
}