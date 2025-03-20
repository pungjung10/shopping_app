import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/domain/model/item_model.dart';
import 'package:shopping_app/src/dashboard/tab/cart/domain/usecase/calculate_total_price_usecase.dart';

void main() {
  late CalculateTotalPriceUseCase calculateTotalPriceUseCase;

  setUp(() {
    calculateTotalPriceUseCase = CalculateTotalPriceUseCaseImpl();
  });

  group('calculate_total_price_usecase_test', () {
    test('Calculate total price, discount, and net price for single product with even quantity', () async {

      final item1 = ItemModel(1, "Item 1", 100);
      final productList = [
        {item1: 4},
      ];

      final result = await calculateTotalPriceUseCase.execute(productList);

      expect(result.totalPriceBeforeDiscount, 400.0);
      expect(result.totalDiscount, 20.0);
      expect(result.totalNetPrice, 380.0);
      expect(result.productNetPrices[0], 380.0);
    });

    test('Calculate total price, discount, and net price for single product with odd quantity', () async {

      final item1 = ItemModel(1, "Item 1", 100);
      final productList = [
        {item1: 5},
      ];

      final result = await calculateTotalPriceUseCase.execute(productList);

      expect(result.totalPriceBeforeDiscount, 500.0);
      expect(result.totalDiscount, 20.0);
      expect(result.totalNetPrice, 480.0);
      expect(result.productNetPrices[0], 480.0);
    });

    test('Calculate total price for multiple products with different quantities', () async {

      final item1 = ItemModel(1, "Item 1", 100);
      final item2 = ItemModel(2, "Item 2", 150);
      final productList = [
        {item1: 4},
        {item2: 3},
      ];

      final result = await calculateTotalPriceUseCase.execute(productList);

      expect(result.totalPriceBeforeDiscount, 850.0); // 400 from item1 + 450 from item2
      expect(result.totalDiscount, 35.0); // 20 from item1 and 15 from item2
      expect(result.totalNetPrice, 815.0); // Total after discount (850 - 35)
      expect(result.productNetPrices[0], 380.0); // Price for item1
      expect(result.productNetPrices[1], 435.0); // Price for item2
    });

    test('Calculate total price for empty product list', () async {

      final result = await calculateTotalPriceUseCase.execute([]);

      expect(result.totalPriceBeforeDiscount, 0.0);
      expect(result.totalDiscount, 0.0);
      expect(result.totalNetPrice, 0.0);
    });
  });
}
