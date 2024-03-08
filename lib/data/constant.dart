class ApiUrl {
  static const String API_BASE_URL = 'http://127.0.0.1:3000';
  static const String API_VERSION = 'v1';

  // Budgets API
  static String createBudgetUrl() => '$API_BASE_URL/budgets/';
  static String deleteBudgetUrl(String id) => '$API_BASE_URL/budgets/$id';
  static String renameBudgetUrl(String id) => '$API_BASE_URL/budgets/$id/name';
  static String listBudgetUrl() => '$API_BASE_URL/budgets/';
  static String getBudgetUrl(String id) => '$API_BASE_URL/budgets/$id';
  static String getBankAccountsByBudgetUrl(String id) => '$API_BASE_URL/budgets/$id/bank-accounts';
  static String getBudgetGroupsByBudgetUrl(String id) => '$API_BASE_URL/budgets/$id/budget-groups';
  static String getTransactionsByBudgetUrl(String id) => '$API_BASE_URL/budgets/$id/transactions';

  // Bank Accounts API
  static String createBankAccountUrl() => '$API_BASE_URL/bank-accounts/';
  static String deleteBankAccountUrl(String id) => '$API_BASE_URL/bank-accounts/$id';
  static String renameBankAccountUrl(String id) => '$API_BASE_URL/bank-accounts/$id/name';
  static String listBankAccountUrl() => '$API_BASE_URL/bank-accounts/';
  static String getBankAccountUrl(String id) => '$API_BASE_URL/bank-accounts/$id';
  static String getTransactionsByBankAccountUrl(String id) => '$API_BASE_URL/bank-accounts/$id/transactions';

  // Budget Groups API
  static String createBudgetGroupUrl() => '$API_BASE_URL/budget-groups/';
  static String deleteBudgetGroupUrl(String id) => '$API_BASE_URL/budget-groups/$id';
  static String renameBudgetGroupUrl(String id) => '$API_BASE_URL/budget-groups/$id/name';
  static String listBudgetGroupUrl() => '$API_BASE_URL/budget-groups/';
  static String getBudgetGroupUrl(String id) => '$API_BASE_URL/budget-groups/$id';
  static String getAssignedCategoriesByBudgetGroupUrl(String id) => '$API_BASE_URL/budget-groups/$id/budget-categories';

  // Budget Categories API
  static String createBudgetCategoryUrl() => '$API_BASE_URL/budget-categories/';
  static String deleteBudgetCategoryUrl(String id) => '$API_BASE_URL/budget-categories/$id';
  static String renameBudgetCategoryUrl(String id) => '$API_BASE_URL/budget-categories/$id/name';
  static String listBudgetCategoryUrl() => '$API_BASE_URL/budget-categories/';
  static String getBudgetCategoryUrl(String id) => '$API_BASE_URL/budget-categories/$id';
  static String assignBudgetGroupUrl(String id) => '$API_BASE_URL/budget-categories/$id/budget-group-id';

  // Transactions API
  static String recordTransactionUrl() => '$API_BASE_URL/transactions/';
  static String deleteTransactionUrl(String id) => '$API_BASE_URL/transactions/$id';
  static String getTransactionUrl(String id) => '$API_BASE_URL/transactions/$id';
  static String updateTransactionUrl(String id) => '$API_BASE_URL/transactions/$id';

  // Reports API
  static String getNetWorthReportUrl() => '$API_BASE_URL/reports/net-worth/';
}