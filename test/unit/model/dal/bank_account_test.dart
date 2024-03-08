import 'package:test/test.dart';

import 'package:mobile/core/exceptions.dart' show ServerException;
import 'package:mobile/model/poco/bank_account_type.dart';
import 'package:mobile/model/dal/bank_account.dart';

import '../../../../test/data/constant.dart';

void main() {
  group('Create Bank Account', () {
    test('create_bank_account__empty_name__return_user_error_1', () async {
      const name = '';
      final type = BankAccountType.standard.value;
      const balance = 0.0;

      expectLater(
          BankAccount.createBankAccount(name, type, balance),
          throwsA(isA<ServerException>().having(
              (e) => e.body['name'][0], 'name', UserErrors.getUserError1())));
    });

    test('create_bank_account__empty_name__return_http_400', () async {
      const name = '';
      final type = BankAccountType.standard.value;
      const balance = 0.0;

      expectLater(
          BankAccount.createBankAccount(name, type, balance),
          throwsA(isA<ServerException>()
              .having((e) => e.statusCode, 'statusCode', 400)));
    });

    test('create_bank_account__unsupported_type__return_user_error_2',
        () async {
      const name = 'BA1';
      const type = 'WRONG_TYPE';
      const balance = 0.0;

      expectLater(
          BankAccount.createBankAccount(name, type, balance),
          throwsA(isA<ServerException>().having((e) => e.body['type'][0],
              'type', UserErrors.getUserError2(type))));
    });

    test('create_bank_account__unsupported_type__return_http_400', () async {
      const name = 'BA1';
      const type = 'WRONG_TYPE';
      const balance = 0.0;

      expectLater(
          BankAccount.createBankAccount(name, type, balance),
          throwsA(isA<ServerException>()
              .having((e) => e.statusCode, 'statusCode', 400)));
    });

    test('create_bank_account__B1_as_name__create_bank_account_named_B1',
        () async {
      const name = 'BA1';
      final type = BankAccountType.standard.value;
      const balance = 0.0;

      final bankAccount =
          await BankAccount.createBankAccount(name, type, balance);

      expect(bankAccount.name, name);
    });

    test(
        'create_bank_account__100_as_starting_balance__create_account_with_100_as_starting_balance',
        () async {
      const name = 'BA1';
      final type = BankAccountType.standard.value;
      const balance = 100.0;

      final bankAccount =
          await BankAccount.createBankAccount(name, type, balance);

      expect(bankAccount.balance, 100.00);
    });

    test('create_bank_account__standard_account__create_a_standard_account',
        () async {
      const name = 'BA1';
      final type = BankAccountType.standard.value;
      const balance = 0.0;

      final bankAccount =
          await BankAccount.createBankAccount(name, type, balance);

      expect(bankAccount.type, BankAccountType.standard.value);
    });

    test('create_bank_account__savings_account__create_a_savings_account',
        () async {
      const name = 'BA1';
      final type = BankAccountType.savings.value;
      const balance = 0.0;

      final bankAccount =
          await BankAccount.createBankAccount(name, type, balance);

      expect(bankAccount.type, BankAccountType.savings.value);
    });

    test('create_bank_account__trading_account__create_a_trading_account',
        () async {
      const name = 'BA1';
      final type = BankAccountType.trading.value;
      const balance = 0.0;

      final bankAccount =
          await BankAccount.createBankAccount(name, type, balance);

      expect(bankAccount.type, BankAccountType.trading.value);
    });
  });

  group("Delete Bank Account", () {
    test('delete_bank_account__existing_account__delete_the_account', () async {
      const name = 'BA1';
      final type = BankAccountType.standard.value;
      const balance = 0.0;

      final bankAccount =
          await BankAccount.createBankAccount(name, type, balance);

      await BankAccount.deleteBankAccount(bankAccount.id);

      expectLater(
          BankAccount.getBankAccount(bankAccount.id),
          throwsA(isA<ServerException>()
              .having((e) => e.statusCode, 'statusCode', 400)));
    });

    test('delete_bank_account__non_existing_account__return_user_error_6', () async {
      const id = 'non-existing';

      expectLater(
          BankAccount.deleteBankAccount(id),
          throwsA(isA<ServerException>().having(
              (e) => e.body['id'][0], 'id', UserErrors.getUserError6(id))));
    });

    test('delete_bank_account__non_existing_account__return_http_400', () async {
      const id = 'non-existing';

      expectLater(
          BankAccount.deleteBankAccount(id),
          throwsA(isA<ServerException>()
              .having((e) => e.statusCode, 'statusCode', 400)));
    });
  });

  group("Rename Bank Account", () {
    test('rename_bank_account__from_BA1_to_BA2__rename_account_to_BA2', () async {
      const name = 'BA1';
      final type = BankAccountType.standard.value;
      const balance = 0.0;

      final bankAccount =
          await BankAccount.createBankAccount(name, type, balance);

      const newName = 'BA2';

      final renamedBankAccount =
          await BankAccount.renameBankAccount(bankAccount.id, newName);

      expect(renamedBankAccount.name, newName);
    });

    test('rename_bank_account__empty_name__return_user_error_1', () async {
      const name = 'BA1';
      final type = BankAccountType.standard.value;
      const balance = 0.0;

      final bankAccount =
          await BankAccount.createBankAccount(name, type, balance);

      const newName = '';

      expectLater(
          BankAccount.renameBankAccount(bankAccount.id, newName),
          throwsA(isA<ServerException>().having(
              (e) => e.body['name'][0], 'name', UserErrors.getUserError1())));
    });

    test('rename_bank_account__empty_name__return_http_400', () async {
      const name = 'BA1';
      final type = BankAccountType.standard.value;
      const balance = 0.0;

      final bankAccount =
          await BankAccount.createBankAccount(name, type, balance);

      const newName = '';

      expectLater(
          BankAccount.renameBankAccount(bankAccount.id, newName),
          throwsA(isA<ServerException>()
              .having((e) => e.statusCode, 'statusCode', 400)));
    });

    test('rename_bank_account__non_existing_account__return_user_error_6', () async {
      const id = 'non-existing';
      const newName = 'BA2';

      expectLater(
          BankAccount.renameBankAccount(id, newName),
          throwsA(isA<ServerException>().having(
              (e) => e.body['id'][0], 'id', UserErrors.getUserError6(id))));
    });

    test('rename_bank_account__non_existing_account__return_http_400', () async {
      const id = 'non-existing';
      const newName = 'BA2';

      expectLater(
          BankAccount.renameBankAccount(id, newName),
          throwsA(isA<ServerException>()
              .having((e) => e.statusCode, 'statusCode', 400)));
    });
  });

  group("List Bank Account", () {
    test('list_bank_account__BA1_BA2_BA3_created__return_BA1_BA2_BA3', () async {
      const name1 = 'BA1';
      final type1 = BankAccountType.standard.value;
      const balance1 = 0.0;

      final ba1 =
          await BankAccount.createBankAccount(name1, type1, balance1);

      const name2 = 'BA2';
      final type2 = BankAccountType.standard.value;
      const balance2 = 0.0;

      final ba2 =
          await BankAccount.createBankAccount(name2, type2, balance2);

      const name3 = 'BA3';
      final type3 = BankAccountType.standard.value;
      const balance3 = 0.0;

      final ba3 =
          await BankAccount.createBankAccount(name3, type3, balance3);

      final bankAccounts = await BankAccount.listBankAccount();

      expect(bankAccounts.map((b) => b.id), containsAll([ba1.id, ba2.id, ba3.id]));
    });
  });

  group("Get Bank Account", (){
    test('get_bank_account__created_BA1__return_BA1', () async {
      const name = 'BA1';
      final type = BankAccountType.standard.value;
      const balance = 0.0;

      final bankAccount =
          await BankAccount.createBankAccount(name, type, balance);

      final retrievedBankAccount = await BankAccount.getBankAccount(bankAccount.id);

      expect(retrievedBankAccount.id, bankAccount.id);
    });

    test('get_bank_account__non_existing_account__return_user_error_6', () async {
      const id = 'non-existing';

      expectLater(
          BankAccount.getBankAccount(id),
          throwsA(isA<ServerException>().having(
              (e) => e.body['id'][0], 'id', UserErrors.getUserError6(id))));
    });

    test('get_bank_account__non_existing_account__return_http_400', () async {
      const id = 'non-existing';

      expectLater(
          BankAccount.getBankAccount(id),
          throwsA(isA<ServerException>()
              .having((e) => e.statusCode, 'statusCode', 400)));
    });
  });
}
