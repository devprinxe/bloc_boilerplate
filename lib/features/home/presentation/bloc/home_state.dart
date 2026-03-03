import 'package:equatable/equatable.dart';

import '../../domain/entities/product_entities.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<ProductEntities> products;

  const HomeLoadedState(this.products);
  @override
  List<Object> get props => [products];
}

class HomeErrorState extends HomeState {
  final String message;

  const HomeErrorState(this.message);
  @override
  List<Object> get props => [message];
}
