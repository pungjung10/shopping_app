part of 'checkout_bloc.dart';

@immutable
abstract class CheckoutEvent {}

class CheckOut extends CheckoutEvent {
  final ProductRequest product;

  CheckOut(this.product);
}

class InitCart extends CheckoutEvent {
  InitCart();
}
