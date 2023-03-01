import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/login.dart';
import 'package:yaki/data/repositories/login_repository.dart';
import 'package:crypt/crypt.dart';

class LoginNotifier extends StateNotifier<Login> {
  final LoginRepository repository;

  LoginNotifier(
    this.repository,
  ) : super(
          Login(login: '', password: ''),
        );

  void changeLogin(String newLogin, String newPassword) async {
    final hashPass = Crypt.sha256(newPassword,
        rounds: 10000, salt: const String.fromEnvironment('CRED_HASH_PASS'),
    );
    final newLog = Login(login: newLogin, password: hashPass.toString());
    state = newLog;
    repository.postLogin(newLog);
    print(newLog.toJson());
  }
}
