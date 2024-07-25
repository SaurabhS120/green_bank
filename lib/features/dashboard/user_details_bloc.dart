import 'package:bloc/bloc.dart';
import 'package:green_bank/domain/usecase/user_details/get_user_details_usecase.dart';

/// BLoC to fetch user details
/// FetchUserDetailsBlocEvent event will be added to fetch details
class UserDetailsBloc extends Bloc<UserDetailsBlocEvent,UserDetailsBlocState>{
  final GetUserDetailsUsecase getUserDetailsUsecase;

  UserDetailsBloc({required this.getUserDetailsUsecase}):super(UserDetailsInitialBlocState()){
    on<UserDetailsBlocEvent>((event,emit)async{
      emit(UserDetailsLoadingBlocState());
      final result = await getUserDetailsUsecase.execute();
      emit(UserDetailsSuccessBlocState(name: result.name));
    });
  }

}

// ---------------States---------------
/// Base class for user details bloc state
abstract class UserDetailsBlocState{

}
/// Initial state for user details BLoC state
class UserDetailsInitialBlocState extends UserDetailsBlocState{

}
/// Loading state for user details BLoC state
class UserDetailsLoadingBlocState extends UserDetailsBlocState{

}
/// Success state for user details BLoC state
class UserDetailsSuccessBlocState extends UserDetailsBlocState{
  final String name;

  UserDetailsSuccessBlocState({required this.name});

}
/// Failure state for user details BLoC state
/// Will be used for network and server errors
class UserDetailsFailureBlocState extends UserDetailsBlocState{

}
// ---------------States---------------

// ---------------Events---------------
/// Base class for user details
abstract class UserDetailsBlocEvent{

}
/// Event to fetch user details from backend
class FetchUserDetailsBlocEvent extends UserDetailsBlocEvent{

}
// ---------------Events---------------
