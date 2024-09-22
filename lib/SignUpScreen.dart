import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void login(String email, String password) async {
    try {
      http.Response response = await http.post(
        Uri.parse('https://reqres.in/api/register'),
        body: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('Account created successfully');
      } else {
        print('Failed to create account');
      }
    } catch (e) {
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up API'),
      ),
      body: SingleChildScrollView(  // Wrap in SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                login(
                  emailController.text.toString(),
                  passwordController.text.toString(),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Center(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}







CREATE TABLE UserDim
(
UserID INT NOT NULL,
UserName VARCHAR(50) NOT NULL,
Gender VARCHAR(10) NOT NULL,
Age INT NOT NULL,
Location VARCHAR(255) NOT NULL,
PRIMARY KEY (UserID)
);

CREATE TABLE VideoDim
(
VideoID INT NOT NULL,
VideoTitle VARCHAR(100) NOT NULL,
Channel VARCHAR(50) NOT NULL,
Category VARCHAR(50) NOT NULL,
UploadDate DATE NOT NULL,
PRIMARY KEY (VideoID)
);

CREATE TABLE TimeDim
(
DateViewed DATE NOT NULL,
DayOfWeek VARCHAR(20) NOT NULL,
Month VARCHAR(20) NOT NULL,
Year INT NOT NULL,
PRIMARY KEY (DateViewed)
);


CREATE TABLE DeviceDim
(
DeviceID INT NOT NULL,
DeviceName VARCHAR(100) NOT NULL,
DeviceType VARCHAR(20) NOT NULL,
OperatingSystem VARCHAR(50) NOT NULL,
PRIMARY KEY (DeviceID)
);

CREATE TABLE VideoViewsFacts
(
ViewID INT NOT NULL,
Duration INT NOT NULL,
UserID INT NOT NULL,
DeviceID INT NOT NULL,
VideoID INT NOT NULL,
DateViewed DATE NOT NULL,
PRIMARY KEY (ViewID),
FOREIGN KEY (UserID) REFERENCES UserDim(UserID),
FOREIGN KEY (DeviceID) REFERENCES DeviceDim(DeviceID),
FOREIGN KEY (VideoID) REFERENCES VideoDim(VideoID),
FOREIGN KEY (DateViewed) REFERENCES TimeDim(DateViewed)
);