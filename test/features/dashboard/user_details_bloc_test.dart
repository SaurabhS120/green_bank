import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:green_bank/domain/model/user_details_model.dart';
import 'package:green_bank/domain/usecase/user_details/get_user_details_usecase.dart';
import 'package:green_bank/features/dashboard/user_details_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'user_details_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GetUserDetailsUsecase>()])
void main(){
  late MockGetUserDetailsUsecase mockGetUserDetailsUsecase;
  blocTest( "Fetch user details" ,
      setUp: (){
        mockGetUserDetailsUsecase= MockGetUserDetailsUsecase();
        when(mockGetUserDetailsUsecase.execute()).thenAnswer((params)=>Future.value(UserDetailsModel(name: "admin")));
      },
      build: () => UserDetailsBloc(getUserDetailsUsecase: mockGetUserDetailsUsecase),
    expect: () => [
      isA<UserDetailsLoadingBlocState>(),
      isA<UserDetailsSuccessBlocState>(),
    ],
    act: (bloc){
      bloc.add(FetchUserDetailsBlocEvent());
    },
    verify: (bloc){
      expect(bloc.state, isA<UserDetailsSuccessBlocState>());
      final successState = bloc.state as UserDetailsSuccessBlocState;
      expect(successState.name, "admin");
    }
  );
  blocTest( "User details bloc initial state test" ,
      setUp: (){
        mockGetUserDetailsUsecase= MockGetUserDetailsUsecase();
        when(mockGetUserDetailsUsecase.execute()).thenAnswer((params)=>Future.value(UserDetailsModel(name: "admin")));
      },
      build: () => UserDetailsBloc(getUserDetailsUsecase: mockGetUserDetailsUsecase),
      verify: (bloc){
        expect(bloc.state, isA<UserDetailsInitialBlocState>());
      }
  );
  blocTest( "User details bloc logout test" ,
      setUp: (){
        mockGetUserDetailsUsecase= MockGetUserDetailsUsecase();
        when(mockGetUserDetailsUsecase.execute()).thenAnswer((params)=>Future.value(const UserDetailsModel(name: "admin")));
      },
      build: () => UserDetailsBloc(getUserDetailsUsecase: mockGetUserDetailsUsecase),
      act: (bloc){
        bloc.add(FetchUserDetailsBlocEvent());
        bloc.add(LogoutUserDetailsBlocEvent());
      },
      verify: (bloc){
        expect(bloc.state, isA<UserDetailsInitialBlocState>());
      }
  );
}