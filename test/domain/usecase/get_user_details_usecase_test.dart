
import 'package:flutter_test/flutter_test.dart';
import 'package:green_bank/data/repo_impl/user_details_repo_impl.dart';
import 'package:green_bank/domain/repo/user_details_repo.dart';
import 'package:green_bank/domain/usecase/user_details/get_user_details_usecase.dart';

void main(){
  UserDetailsRepo userDetailsRepo = UserDetailsRepoImpl(delay: const Duration());
  test( "Usecase should return user with name admin" , () async {
    GetUserDetailsUsecase getUserDetailsUsecase = GetUserDetailsUsecase(
        repo: userDetailsRepo,
    );
    final result = await getUserDetailsUsecase.execute();
    expect(result.name,"admin");
  });
}