import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_ordering_app/presentation/bloc/restaurants/restaurants_bloc.dart';
import 'package:food_ordering_app/presentation/bloc/restaurants/restaurants_event.dart';
import 'package:food_ordering_app/presentation/bloc/restaurants/restaurants_state.dart';
import 'package:mockito/mockito.dart';
import 'package:food_ordering_app/core/error/failures.dart';
import 'package:food_ordering_app/data/models/restaurant.dart';
import 'mocks.dart';
import 'mocks.mocks.dart';

void main() {
  late MockRestaurantRepository mockRepo;
  late RestaurantsBloc bloc;

  setUp(() {
    mockRepo = MockRestaurantRepository();
    bloc = RestaurantsBloc(mockRepo);
  });

  const restaurant = Restaurant(
    id: '1',
    name: 'Pizza Palace',
    cuisine: 'Italian',
    rating: 4.5,
    imageUrl: '',
    deliveryTimeMinutes: 30,
  );

  group('RestaurantsBloc', () {
    blocTest<RestaurantsBloc, RestaurantsState>(
      'emits [Loading, Loaded] when LoadRestaurants succeeds',
      build: () {
        when(mockRepo.getRestaurants()).thenAnswer((_) async {
          print('Mock getRestaurants called for LoadRestaurants');
          return [restaurant];
        });
        return bloc;
      },
      act: (bloc) => bloc.add(LoadRestaurants()),
      expect: () => [
        RestaurantsLoading(),
        RestaurantsLoaded([restaurant]),
      ],
    );

    blocTest<RestaurantsBloc, RestaurantsState>(
      'emits [Loading, Error] when LoadRestaurants fails',
      build: () {
        when(mockRepo.getRestaurants()).thenAnswer((_) async {
          print('Mock getRestaurants called for LoadRestaurants failure');
          throw ServerFailure();
        });
        return bloc;
      },
      act: (bloc) => bloc.add(LoadRestaurants()),
      expect: () => [
        RestaurantsLoading(),
        isA<RestaurantsError>(),
      ],
    );

    blocTest<RestaurantsBloc, RestaurantsState>(
      'emits [Loading, Loaded] when RetryLoadRestaurants succeeds',
      build: () {
        when(mockRepo.getRestaurants()).thenAnswer((_) async {
          print('Mock getRestaurants called for RetryLoadRestaurants');
          return [restaurant];
        });
        return bloc;
      },
      act: (bloc) => bloc.add(RetryLoadRestaurants()),
      expect: () => [
        RestaurantsLoading(),
        RestaurantsLoaded([restaurant]),
      ],
    );
  });
}