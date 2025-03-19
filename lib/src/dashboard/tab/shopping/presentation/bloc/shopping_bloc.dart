import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'shopping_event.dart';

part 'shopping_state.dart';

class ShoppingBloc extends Bloc<ShoppingEvent, ShoppingState> {

  ShoppingBloc() : super(ShoppingInitial()) {

  }
}