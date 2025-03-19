class SummaryModel {
  final double totalPriceBeforeDiscount;
  final double totalDiscount;
  final double totalNetPrice;
  final List<double> productNetPrices;

  SummaryModel(
      this.totalPriceBeforeDiscount, this.totalDiscount, this.totalNetPrice, this.productNetPrices);
}
