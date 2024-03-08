class UserErrors {
  static String getUserError1() => 'Name should not be blank.';
  static String getUserError2(String type) =>
      'Bank account type $type is not supported. Should be one of [\'STANDARD\', \'SAVING\', \'TRADING\'].';
  static String getUserError4(String id) => 'Budget group ID $id not found.';
  static String getUserError5(String id) => 'Budget ID $id not found.';
  static String getUserError6(String id) => 'Bank account ID $id not found.';
  static String getUserError7(String date) =>
      'Invalid date format $date. Date should be of the form AAAA-MM-DD.';
  static String getUserError8(String startDate, String endDate) =>
      'start_date $startDate occurs after end_date $endDate.';
}
