import 'package:shopping_app/src/dashboard/tab/cart/domain/model/summary_model.dart';
import 'package:shopping_app/src/dashboard/tab/shopping/domain/model/item_model.dart';

abstract class CalculateTotalPriceUseCase {
  Future<SummaryModel> execute(List<Map<ItemModel, int>> productList);
}

class CalculateTotalPriceUseCaseImpl implements CalculateTotalPriceUseCase {
  @override
  Future<SummaryModel> execute(List<Map<ItemModel, int>> productList) async {
    double totalPriceBeforeDiscount = 0.0;
    double totalDiscount = 0.0;
    double totalNetPrice = 0.0;
    List<double> productNetPrices = [];

    for (var productMap in productList) {
      productMap.forEach((item, quantity) {
        double totalItemPriceBeforeDiscount = item.price.toDouble() * quantity;
        totalPriceBeforeDiscount += totalItemPriceBeforeDiscount;

        int numberOfPairs = quantity ~/ 2;
        int remainingItems = quantity % 2;

        double pairPrice = item.price.toDouble() * 2;
        double discountOnPair = pairPrice * 0.05;
        double totalPairPrice = (pairPrice - discountOnPair) * numberOfPairs;
        double totalRemainingPrice = item.price.toDouble() * remainingItems;

        double totalPriceForProduct = totalPairPrice + totalRemainingPrice;
        productNetPrices.add(totalPriceForProduct);

        totalNetPrice += totalPriceForProduct;
        totalDiscount += discountOnPair * numberOfPairs;
      });
    }

    return SummaryModel(totalPriceBeforeDiscount, totalDiscount, totalNetPrice, productNetPrices);
  }
}
