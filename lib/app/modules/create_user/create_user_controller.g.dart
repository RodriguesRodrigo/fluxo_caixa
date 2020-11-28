// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_user_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $CreateUserController = BindInject(
  (i) => CreateUserController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CreateUserController on _CreateUserControllerBase, Store {
  final _$loginWithFirebaseAsyncAction =
      AsyncAction('_CreateUserControllerBase.loginWithFirebase');

  @override
  Future<dynamic> loginWithFirebase(dynamic email, dynamic password) {
    return _$loginWithFirebaseAsyncAction
        .run(() => super.loginWithFirebase(email, password));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
