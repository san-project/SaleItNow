import 'dart:math';

import '../models/cost_model.dart';
import '../models/type_model.dart';

final rand = Random();

final List<double> weeklyselling = [
  rand.nextDouble() * 100,
  rand.nextDouble() * 100,
  rand.nextDouble() * 100,
  rand.nextDouble() * 100,
  rand.nextDouble() * 100,
  rand.nextDouble() * 100,
  rand.nextDouble() * 100,
];

_generateExpenses() {
  List<CostModel> costModel = [
    CostModel(name: 'Item 0', cost: rand.nextDouble() * 90),
    CostModel(name: 'Item 1', cost: rand.nextDouble() * 90),
    CostModel(name: 'Item 2', cost: rand.nextDouble() * 90),
    CostModel(name: 'Item 3', cost: rand.nextDouble() * 90),
    CostModel(name: 'Item 4', cost: rand.nextDouble() * 90),
    CostModel(name: 'Item 5', cost: rand.nextDouble() * 90),
  ];
  return costModel;
}

List<TypeModel> typeNames = [
  TypeModel(name: 'Clothings', maxAmount: 2000, expenses: _generateExpenses()),
  TypeModel(name: 'Mobiles', maxAmount: 200, expenses: _generateExpenses()),
  TypeModel(name: 'Telivision', maxAmount: 400, expenses: _generateExpenses()),
  TypeModel(
      name: 'Refrigerator', maxAmount: 200, expenses: _generateExpenses()),
  TypeModel(
      name: 'Entertainment', maxAmount: 100, expenses: _generateExpenses()),
  TypeModel(name: 'Transport', maxAmount: 100, expenses: _generateExpenses()),
];
