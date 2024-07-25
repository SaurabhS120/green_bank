import 'package:green_bank/domain/model/user_details_model.dart';
import 'package:green_bank/domain/repo/user_details_repo.dart';

/// Usecase to fetch user details
class GetUserDetailsUsecase{

  final UserDetailsRepo repo;

  GetUserDetailsUsecase({required this.repo});

  /// Usecase to fetch user details
  Future<UserDetailsModel> execute(){
    return repo.getUserDetails();
  }
}