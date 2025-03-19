part of 'check_out_bloc.dart';

@immutable
abstract class CheckOutState {}

class CheckOutInitial extends CheckOutState {}

class CheckOutError extends CheckOutState {}

class CheckOutSuccess extends CheckOutState {}
