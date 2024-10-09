import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';

import 'aws_iot_cognito.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void _loginUser() async {
    final CognitoUserPool userPool = CognitoUserPool(
      "us-east-1_M8b97NwO8",
      "4tc27hulmfe6ns6f45fevjdumt",
    );

    final credentials = CognitoCredentials(
      "us-east-1:55f2112f-76a3-42ee-ab14-6c0dd1c186f1",
      userPool,
    );

    final cognitoUser = CognitoUser("nihalninu25@gmail.com", userPool);
    final authDetails = AuthenticationDetails(
      username: "nihalninu25@gmail.com",
      password: "nihal@23ktu",
    );
    CognitoUserSession? session;
    try {
      session = await cognitoUser.authenticateUser(authDetails);
      await credentials.getAwsCredentials(session!.getIdToken().getJwtToken());
      debugPrint('Credentials: ${credentials.toString()}');
      await connect(
        accessKey: credentials.accessKeyId!,
        secretKey: credentials.secretAccessKey!,
        sessionToken: credentials.sessionToken!,
        identityId: credentials.userIdentityId!,
      );
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }
    debugPrint("Authenticated: ${session.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _loginUser,
          /* onPressed: () {
            connect();
          }, */
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
