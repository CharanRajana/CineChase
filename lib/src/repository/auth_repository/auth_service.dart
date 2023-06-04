import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:cinechase/src/core/failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import 'client.dart';

final authenticationProvider = Provider(
  (ref) => Authentication(
    account: ref.watch(accountProvider),
  ),
);

final accountProvider = Provider(
  (ref) => Account(
    ref.watch(clientProvider),
  ),
);

class Authentication {
  final Account _account;

  Authentication({required Account account}) : _account = account;

  //Current User Data
  Future<model.User?> currentUserAccount() async {
    try {
      return await _account.get();
    } on AppwriteException {
      return null;
    } catch (e) {
      return null;
    }
  }

  //User Sign Up
  Future<Either<Failure, model.User>> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final user = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );

      return right(user);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(
          e.message.toString(),
          stackTrace,
        ),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(
          e.toString(),
          stackTrace,
        ),
      );
    }
  }

  //User Login In
  Future<Either<Failure, model.Session>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final session =
          await _account.createEmailSession(email: email, password: password);
      debugPrint(session.userId);

      return right(session);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(
          e.message.toString(),
          stackTrace,
        ),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(
          e.toString(),
          stackTrace,
        ),
      );
    }
  }

  //User Log Out
  Future<Either<Failure, void>> logOut() async {
    try {
      await _account.deleteSession(sessionId: 'current');
      return right(null);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(
          e.message.toString(),
          stackTrace,
        ),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(
          e.toString(),
          stackTrace,
        ),
      );
    }
  }
}
