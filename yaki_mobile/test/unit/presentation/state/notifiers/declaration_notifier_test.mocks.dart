// Mocks generated by Mockito 5.3.2 from annotations
// in yaki/test/unit/presentation/state/notifiers/declaration_notifier_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:yaki/data/models/declaration_model.dart' as _i5;
import 'package:yaki/data/models/user.dart' as _i8;
import 'package:yaki/data/repositories/declaration_respository.dart' as _i3;
import 'package:yaki/data/repositories/login_repository.dart' as _i6;
import 'package:yaki/domain/entities/declaration_status.dart' as _i2;
import 'package:yaki/domain/entities/logged_user.dart' as _i7;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDeclarationStatus_0 extends _i1.SmartFake
    implements _i2.DeclarationStatus {
  _FakeDeclarationStatus_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [DeclarationRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeclarationRepository extends _i1.Mock
    implements _i3.DeclarationRepository {
  MockDeclarationRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.DeclarationStatus get declarationStatus => (super.noSuchMethod(
        Invocation.getter(#declarationStatus),
        returnValue: _FakeDeclarationStatus_0(
          this,
          Invocation.getter(#declarationStatus),
        ),
      ) as _i2.DeclarationStatus);
  @override
  set declarationStatus(_i2.DeclarationStatus? _declarationStatus) =>
      super.noSuchMethod(
        Invocation.setter(
          #declarationStatus,
          _declarationStatus,
        ),
        returnValueForMissingStub: null,
      );
  @override
  String get statusAllDay => (super.noSuchMethod(
        Invocation.getter(#statusAllDay),
        returnValue: '',
      ) as String);
  @override
  String get statusMorning => (super.noSuchMethod(
        Invocation.getter(#statusMorning),
        returnValue: '',
      ) as String);
  @override
  _i2.DeclarationStatus get allDeclarations => (super.noSuchMethod(
        Invocation.getter(#allDeclarations),
        returnValue: _FakeDeclarationStatus_0(
          this,
          Invocation.getter(#allDeclarations),
        ),
      ) as _i2.DeclarationStatus);
  @override
  _i4.Future<String> getDeclaration(String? teamMateId) => (super.noSuchMethod(
        Invocation.method(
          #getDeclaration,
          [teamMateId],
        ),
        returnValue: _i4.Future<String>.value(''),
      ) as _i4.Future<String>);
  @override
  _i4.Future<void> createAllDay(_i5.DeclarationModel? declaration) =>
      (super.noSuchMethod(
        Invocation.method(
          #createAllDay,
          [declaration],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> createHalfDay(List<_i5.DeclarationModel>? declarations) =>
      (super.noSuchMethod(
        Invocation.method(
          #createHalfDay,
          [declarations],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  void setAllDayDeclaration(String? status) => super.noSuchMethod(
        Invocation.method(
          #setAllDayDeclaration,
          [status],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setHalfDayDeclaration(
    String? morningStatus,
    String? afternoonStatus,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #setHalfDayDeclaration,
          [
            morningStatus,
            afternoonStatus,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setMorningDeclaration(String? status) => super.noSuchMethod(
        Invocation.method(
          #setMorningDeclaration,
          [status],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [LoginRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginRepository extends _i1.Mock implements _i6.LoginRepository {
  MockLoginRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set loggedUser(_i7.LoggedUser? _loggedUser) => super.noSuchMethod(
        Invocation.setter(
          #loggedUser,
          _loggedUser,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i4.Future<bool> userAuthentication(
    String? login,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #userAuthentication,
          [
            login,
            password,
          ],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  void setSharedPreference(_i8.User? user) => super.noSuchMethod(
        Invocation.method(
          #setSharedPreference,
          [user],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setLoggedUser(_i8.User? user) => super.noSuchMethod(
        Invocation.method(
          #setLoggedUser,
          [user],
        ),
        returnValueForMissingStub: null,
      );
  @override
  String hashPassword(String? password) => (super.noSuchMethod(
        Invocation.method(
          #hashPassword,
          [password],
        ),
        returnValue: '',
      ) as String);
}
