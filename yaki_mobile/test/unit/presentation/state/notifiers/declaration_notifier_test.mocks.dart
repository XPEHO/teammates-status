// Mocks generated by Mockito 5.4.0 from annotations
// in yaki/test/unit/presentation/state/notifiers/declaration_notifier_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:retrofit/retrofit.dart' as _i12;
import 'package:yaki/data/models/declaration_model.dart' as _i6;
import 'package:yaki/data/models/team_model.dart' as _i11;
import 'package:yaki/data/models/user.dart' as _i9;
import 'package:yaki/data/repositories/declaration_respository.dart' as _i4;
import 'package:yaki/data/repositories/login_repository.dart' as _i7;
import 'package:yaki/data/repositories/team_repository.dart' as _i10;
import 'package:yaki/data/sources/remote/team_api.dart' as _i3;
import 'package:yaki/domain/entities/declaration_status.dart' as _i2;
import 'package:yaki/domain/entities/logged_user.dart' as _i8;

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

class _FakeTeamApi_1 extends _i1.SmartFake implements _i3.TeamApi {
  _FakeTeamApi_1(
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
    implements _i4.DeclarationRepository {
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
  _i5.Future<List<String>> getLatestDeclaration(String? teamMateId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getLatestDeclaration,
          [teamMateId],
        ),
        returnValue: _i5.Future<List<String>>.value(<String>[]),
      ) as _i5.Future<List<String>>);
  @override
  _i5.Future<void> createFullDay(_i6.DeclarationModel? declaration) =>
      (super.noSuchMethod(
        Invocation.method(
          #createFullDay,
          [declaration],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> createHalfDay(List<_i6.DeclarationModel>? declarations) =>
      (super.noSuchMethod(
        Invocation.method(
          #createHalfDay,
          [declarations],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  void setFullDayStatus(String? status) => super.noSuchMethod(
        Invocation.method(
          #setFullDayStatus,
          [status],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setHalfDayStatus(
    String? morningStatus,
    String? afternoonStatus,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #setHalfDayStatus,
          [
            morningStatus,
            afternoonStatus,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setMorningStatus(String? status) => super.noSuchMethod(
        Invocation.method(
          #setMorningStatus,
          [status],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [LoginRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginRepository extends _i1.Mock implements _i7.LoginRepository {
  MockLoginRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set loggedUser(_i8.LoggedUser? _loggedUser) => super.noSuchMethod(
        Invocation.setter(
          #loggedUser,
          _loggedUser,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.Future<bool> userAuthentication(
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
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
  @override
  bool isCaptain() => (super.noSuchMethod(
        Invocation.method(
          #isCaptain,
          [],
        ),
        returnValue: false,
      ) as bool);
  @override
  void setSharedPreference(_i9.User? user) => super.noSuchMethod(
        Invocation.method(
          #setSharedPreference,
          [user],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setLoggedUser(_i9.User? user) => super.noSuchMethod(
        Invocation.method(
          #setLoggedUser,
          [user],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [TeamRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTeamRepository extends _i1.Mock implements _i10.TeamRepository {
  MockTeamRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.TeamApi get teamApi => (super.noSuchMethod(
        Invocation.getter(#teamApi),
        returnValue: _FakeTeamApi_1(
          this,
          Invocation.getter(#teamApi),
        ),
      ) as _i3.TeamApi);
  @override
  _i5.Future<List<_i11.TeamModel>> getTeam() => (super.noSuchMethod(
        Invocation.method(
          #getTeam,
          [],
        ),
        returnValue: _i5.Future<List<_i11.TeamModel>>.value(<_i11.TeamModel>[]),
      ) as _i5.Future<List<_i11.TeamModel>>);
  @override
  List<_i11.TeamModel> setTeamModelList(_i12.HttpResponse<dynamic>? response) =>
      (super.noSuchMethod(
        Invocation.method(
          #setTeamModelList,
          [response],
        ),
        returnValue: <_i11.TeamModel>[],
      ) as List<_i11.TeamModel>);
}
