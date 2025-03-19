part of 'check_out_bloc.dart';

@immutable
abstract class CheckOutEvent {}

class CheckOut extends CheckOutEvent {
  final ProductRequest product;

  CheckOut(this.product);
}