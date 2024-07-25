import 'package:equatable/equatable.dart';

///Model class for user details response
class UserDetailsModel extends Equatable{
  final String name;

  const UserDetailsModel({required this.name});

  @override
  List<Object?> get props => [name];

}