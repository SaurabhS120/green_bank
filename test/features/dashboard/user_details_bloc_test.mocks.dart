// Mocks generated by Mockito 5.4.4 from annotations
// in green_bank/test/features/dashboard/user_details_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:green_bank/domain/model/user_details_model.dart' as _i3;
import 'package:green_bank/domain/repo/user_details_repo.dart' as _i2;
import 'package:green_bank/domain/usecase/user_details/get_user_details_usecase.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeUserDetailsRepo_0 extends _i1.SmartFake
    implements _i2.UserDetailsRepo {
  _FakeUserDetailsRepo_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUserDetailsModel_1 extends _i1.SmartFake
    implements _i3.UserDetailsModel {
  _FakeUserDetailsModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetUserDetailsUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetUserDetailsUsecase extends _i1.Mock
    implements _i4.GetUserDetailsUsecase {
  @override
  _i2.UserDetailsRepo get repo => (super.noSuchMethod(
        Invocation.getter(#repo),
        returnValue: _FakeUserDetailsRepo_0(
          this,
          Invocation.getter(#repo),
        ),
        returnValueForMissingStub: _FakeUserDetailsRepo_0(
          this,
          Invocation.getter(#repo),
        ),
      ) as _i2.UserDetailsRepo);

  @override
  _i5.Future<_i3.UserDetailsModel> execute() => (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue:
            _i5.Future<_i3.UserDetailsModel>.value(_FakeUserDetailsModel_1(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.UserDetailsModel>.value(_FakeUserDetailsModel_1(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i5.Future<_i3.UserDetailsModel>);
}
