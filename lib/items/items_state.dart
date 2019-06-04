import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:warehouse_order_pick/models/item.dart';

abstract class ItemsState extends Equatable {
  ItemsState([List props = const []]) : super(props);
}

class ItemsInitial extends ItemsState {
  @override
  String toString() => 'Items initial';
}

class ItemsLoading extends ItemsState {
  @override
  String toString() => 'Loading items';
}

class ItemsLoaded extends ItemsState {
  final List<Item> items;

  ItemsLoaded({@required this.items}) : super([items]);

  @override
  String toString() => 'Items loaded';
}

class ItemsError extends ItemsState {
  final String error;

  ItemsError({@required this.error}) : super([error]);

  @override
  String toString() => 'Items Error { error: $error }';
}