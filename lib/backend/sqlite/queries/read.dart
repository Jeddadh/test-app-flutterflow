import '/backend/sqlite/queries/sqlite_row.dart';
import 'package:sqflite/sqflite.dart';

Future<List<T>> _readQuery<T>(
  Database database,
  String query,
  T Function(Map<String, dynamic>) create,
) =>
    database.rawQuery(query).then((r) => r.map((e) => create(e)).toList());

/// BEGIN GET LIST OF INGREDIENTS
Future<List<GetListOfIngredientsRow>> performGetListOfIngredients(
  Database database,
) {
  const query = '''
SELECT Ingredient.IngredientName
FROM Ingredient
''';
  return _readQuery(database, query, (d) => GetListOfIngredientsRow(d));
}

class GetListOfIngredientsRow extends SqliteRow {
  GetListOfIngredientsRow(super.data);

  String? get ingredientName => data['IngredientName'] as String?;
}

/// END GET LIST OF INGREDIENTS

/// BEGIN GETLISTOFINGREDIENTS FROM MEAL
Future<List<GetListOfIngredientsFromMealRow>>
    performGetListOfIngredientsFromMeal(
  Database database, {
  String? mealName,
}) {
  final query = '''
SELECT Ingredient.IngredientName, DimMealIngredients.Quantity
FROM DimMealIngredients
LEFT JOIN Meal on Meal.Id = DimMealIngredients.MealId
LEFT JOIN Ingredient on Ingredient.Id = DimMealIngredients.IngredientId
WHERE MealName=$mealName
''';
  return _readQuery(database, query, (d) => GetListOfIngredientsFromMealRow(d));
}

class GetListOfIngredientsFromMealRow extends SqliteRow {
  GetListOfIngredientsFromMealRow(super.data);

  String? get ingredientName => data['IngredientName'] as String?;
  int? get quantity => data['Quantity'] as int?;
}

/// END GETLISTOFINGREDIENTS FROM MEAL

/// BEGIN LIST OF MEALS
Future<List<ListOfMealsRow>> performListOfMeals(
  Database database,
) {
  const query = '''
SELECT MealName
FROM Meal
''';
  return _readQuery(database, query, (d) => ListOfMealsRow(d));
}

class ListOfMealsRow extends SqliteRow {
  ListOfMealsRow(super.data);

  String? get mealName => data['MealName'] as String?;
}

/// END LIST OF MEALS
