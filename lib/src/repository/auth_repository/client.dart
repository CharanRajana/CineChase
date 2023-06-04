import 'package:appwrite/appwrite.dart';
import 'package:cinechase/src/constants/secrets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clientProvider = Provider<Client>(
  (ref) {
    Client client = Client();

    return client
        .setEndpoint(Secrets.endPoint)
        .setProject(Secrets.projectId)
        .setSelfSigned(status: true);
  },
);
