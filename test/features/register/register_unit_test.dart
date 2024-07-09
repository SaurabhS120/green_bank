import 'package:flutter_test/flutter_test.dart';
import 'package:green_bank/features/register/register_bloc.dart';
class RegisterUnitTestHelper{
  static registerValidationFailTest(String testName,
      {required String testPassword,required RegisterPasswordFormatErrorReason reasonEnum}){
    test(testName, (){
      RegisterPasswordValidationError passwordValidationError = RegisterBlocValidations.validatePassword(testPassword);
      expect(passwordValidationError, isA<RegisterPasswordFormatError>());
      RegisterPasswordFormatError registerPasswordFormatErrorReason = passwordValidationError as RegisterPasswordFormatError;
      expect(registerPasswordFormatErrorReason.reason, reasonEnum);
    });
  }
}
void main(){
  group("Register Bloc Validations Unit Tests", ()
  {
    group("Name", () {
      test("Name empty validation success test", () {
        String name = "Peter Parker";
        expect(RegisterBlocValidations.validateName(name),
            isA<RegisterNameNoError>(),
            reason: "There should not be any error for name : $name");
      });
      test("Name empty validation error test", () {
        expect(RegisterBlocValidations.validateName(''),
            isA<RegisterNameEmptyError>(),
            reason: "There should be error for empty name");
      });
      test("Name validation error test", () {
        expect(RegisterBlocValidations.validateName('1234abc%'),
            isA<RegisterNameValidationError>(),
            reason: "There should be error for name validation");
      });
      test("Name should not contain number test", () {
        expect(RegisterBlocValidations.validateName('1234abc'),
            isA<RegisterNameShouldNotContainDigitError>(),
            reason: "There should be error for name representing Name should not contain digits");
      });

      test(
          "Name should not contain special characters error test : ", () {
        List<String> namesWithSpecialCharacters = [
          "Alice!",
          "Bob@",
          "Charlie#",
          "David\$",
          "Eve%",
          "Frank^",
          "Grace&",
          "Hannah*",
          "Ian(",
          "Jack)",
          "Karen-",
          "Leo_",
          "Mia+",
          "Nick=",
          "Olivia{",
          "Paul}",
          "Quincy[",
          "Rachel]",
          "Steve|",
          "Tina\\",
          "Uma:",
          "Victor;",
          "Wendy\"",
          "Xander'",
          "Yara<",
          "Zack>",
          "Ana,",
          "Brian.",
          "Cindy?",
          "Dylan/",
          "Erica~",
          "Fred`",
        ];
        for (var name in namesWithSpecialCharacters) {
          expect(RegisterBlocValidations.validateName(name),
              isA<RegisterNameShouldNotContainSpecialCharacterError>(),
              reason: "There should be special character error for name validation : $name");
        }
      });
    });
    group('Password', () {
      //At least 12 characters long but 14 or more is better.
      //
      // A combination of uppercase letters, lowercase letters, numbers, and symbols.
      RegisterUnitTestHelper.registerValidationFailTest(
          "Password less than 12 characters test", testPassword: '12345',
          reasonEnum: RegisterPasswordFormatErrorReason.length);
      RegisterUnitTestHelper.registerValidationFailTest(
          "Password more than 20 characters test",
          testPassword: '123456789012345678901',
          reasonEnum: RegisterPasswordFormatErrorReason.length);
      RegisterUnitTestHelper.registerValidationFailTest(
          "Password without number test", testPassword: 'abcxyzpqrabc',
          reasonEnum: RegisterPasswordFormatErrorReason.number);
      RegisterUnitTestHelper.registerValidationFailTest(
          "Password without letter test", testPassword: '123456789012',
          reasonEnum: RegisterPasswordFormatErrorReason.lowercase);
      RegisterUnitTestHelper.registerValidationFailTest(
          "Password without uppercase letter test",
          testPassword: '123456abcdef',
          reasonEnum: RegisterPasswordFormatErrorReason.uppercase);
      RegisterUnitTestHelper.registerValidationFailTest(
          "Password without lowercase test", testPassword: '123456789ABC',
          reasonEnum: RegisterPasswordFormatErrorReason.lowercase);
      RegisterUnitTestHelper.registerValidationFailTest(
          "Password without special character test",
          testPassword: '123456AbcXyz',
          reasonEnum: RegisterPasswordFormatErrorReason.spacialCharacter);
    });
  });
}