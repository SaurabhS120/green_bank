import 'package:green_bank/domain/model/user_details_model.dart';

abstract class UserDetailsRepo{
  Future<UserDetailsModel> getUserDetails();
}