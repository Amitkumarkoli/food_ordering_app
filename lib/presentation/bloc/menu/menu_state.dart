import 'package:equatable/equatable.dart';
import '../../../data/models/menu_item.dart';
import '../../../core/error/failures.dart';

abstract class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object> get props => [];
}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final List<MenuItem> menuItems;

  const MenuLoaded(this.menuItems);

  @override
  List<Object> get props => [menuItems];
}

class MenuError extends MenuState {
  final Failure failure;

  const MenuError(this.failure);

  @override
  List<Object> get props => [failure];
}