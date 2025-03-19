part of 'checkout_bloc.dart';

@immutable
abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutError extends CheckoutState {}

class CheckoutSuccess extends CheckoutState {}
