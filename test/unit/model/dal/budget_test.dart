import 'package:test/test.dart';

import 'package:mobile/core/exceptions.dart' show ServerException;
import 'package:mobile/model/dal/budget.dart';

import '../../../../test/data/constant.dart';

void main() {
  group('Create Budget', () {
    test('create_budget__blank_name__return_user_error_1', () async {
      const name = '';

      expectLater(
          Budget.createBudget(name),
          throwsA(isA<ServerException>().having(
              (e) => e.body['name'][0], 'name', UserErrors.getUserError1())));
    });

    test('create_budget__empty_name__return_http_400', () async {
      const name = '';

      expectLater(
          Budget.createBudget(name),
          throwsA(isA<ServerException>()
              .having((e) => e.statusCode, 'statusCode', 400)));
    });

    test('create_budget__B1_as_name__create_budget_named_B1', () async {
      const name = 'B1';

      final budget = await Budget.createBudget(name);

      expect(budget.name, name);
    });
  });

  group('Delete Budget', () {
    test('delete_budget__non_existing_budget__return_user_error_3', () async {
      const id = 'non-existing-id';

      expectLater(
          Budget.deleteBudget(id),
          throwsA(isA<ServerException>().having(
              (e) => e.body['id'][0], 'id', UserErrors.getUserError5(id))));
    });

    test('delete_budget__non_existing_budget__return_http_404', () async {
      const id = 'non-existing-id';

      expectLater(
          Budget.deleteBudget(id),
          throwsA(isA<ServerException>()
              .having((e) => e.statusCode, 'statusCode', 400)));
    });

    test('delete_budget__created_B1__delete_B1', () async {
      const name = 'B1';
      final budget = await Budget.createBudget(name);

      await Budget.deleteBudget(budget.id);

      expectLater(
          Budget.getBudget(budget.id),
          throwsA(isA<ServerException>()
              .having((e) => e.statusCode, 'statusCode', 400)));
    });
  });

  group('Rename Budget', () {
    test('rename_budget__non_existing_budget__return_user_error_3', () async {
      const id = 'non-existing-id';
      const name = 'B1';

      expectLater(
          Budget.renameBudget(id, name),
          throwsA(isA<ServerException>().having(
              (e) => e.body['id'][0], 'id', UserErrors.getUserError5(id))));
    });

    test('rename_budget__non_existing_budget__return_http_404', () async {
      const id = 'non-existing-id';
      const name = 'B1';

      expectLater(
          Budget.renameBudget(id, name),
          throwsA(isA<ServerException>()
              .having((e) => e.statusCode, 'statusCode', 400)));
    });

    test('rename_budget__empty_name__return_user_error_1', () async {
      const name = '';
      final budget = await Budget.createBudget('B1');

      expectLater(
          Budget.renameBudget(budget.id, name),
          throwsA(isA<ServerException>().having(
              (e) => e.body['name'][0], 'name', UserErrors.getUserError1())));
    });

    test('rename_budget__empty_name__return_http_400', () async {
      const name = '';
      final budget = await Budget.createBudget('B1');

      expectLater(
          Budget.renameBudget(budget.id, name),
          throwsA(isA<ServerException>()
              .having((e) => e.statusCode, 'statusCode', 400)));
    });

    test('rename_budget__created_B1__rename_B1_to_B2', () async {
      const name = 'B1';
      final budget = await Budget.createBudget(name);
      const newName = 'B2';

      final renamedBudget = await Budget.renameBudget(budget.id, newName);

      expect(renamedBudget.name, newName);
    });
  });

  group('List Budget', () {
    test('list_budget__created_B1_B2_B3__return_B1_B2_B3', () async {
      const name1 = 'B1';
      const name2 = 'B2';
      const name3 = 'B3';

      final b1 = await Budget.createBudget(name1);
      final b2 = await Budget.createBudget(name2);
      final b3 = await Budget.createBudget(name3);

      final budgets = await Budget.listBudget();

      expect(budgets.map((b) => b.id), containsAll([b1.id, b2.id, b3.id]));
    });
  });

  group('Get Budget', () {
    test('get_budget__non_existing_budget__return_user_error_3', () async {
      const id = 'non-existing-id';

      expectLater(
          Budget.getBudget(id),
          throwsA(isA<ServerException>().having(
              (e) => e.body['id'][0], 'id', UserErrors.getUserError5(id))));
    });

    test('get_budget__non_existing_budget__return_http_404', () async {
      const id = 'non-existing-id';

      expectLater(
          Budget.getBudget(id),
          throwsA(isA<ServerException>()
              .having((e) => e.statusCode, 'statusCode', 400)));
    });

    test('get_budget__created_B1__return_B1', () async {
      const name = 'B1';
      final budget = await Budget.createBudget(name);

      final fetchedBudget = await Budget.getBudget(budget.id);

      expect(fetchedBudget.id, budget.id);
    });
  });
}
