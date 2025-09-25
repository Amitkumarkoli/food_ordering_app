import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/core/error/failures.dart';
import '../../../data/repositories/menu_repository.dart';
import 'menu_event.dart';
import 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MenuRepository repository;

  MenuBloc(this.repository) : super(MenuInitial()) {
    on<LoadMenu>(_onLoadMenu);
    on<RetryLoadMenu>(_onLoadMenu);
  }

  Future<void> _onLoadMenu(MenuEvent event, Emitter<MenuState> emit) async {
    final restaurantId = event is LoadMenu ? event.restaurantId : (event as RetryLoadMenu).restaurantId;
    emit(MenuLoading());
    try {
      final menuItems = await repository.getMenuItems(restaurantId);
      emit(MenuLoaded(menuItems));
    } catch (e) {
      emit(MenuError(e is Failure ? e : ServerFailure()));
    }
  }
}