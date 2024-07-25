import 'package:green_bank/domain/model/user_details_model.dart';
import 'package:green_bank/domain/repo/user_details_repo.dart';

class UserDetailsRepoImpl extends UserDetailsRepo{
  final Duration delay;

  UserDetailsRepoImpl({this.delay = const Duration(seconds: 1)});
  @override
  Future<UserDetailsModel> getUserDetails() async{
    await Future.delayed(delay);
    return const UserDetailsModel(name: "admin");
  }

}