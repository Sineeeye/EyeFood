import 'package:eyefood/utirity/my_constant.dart';
import 'package:eyefood/utirity/normal_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
//Field
  String name, email, password, address;

//Method
  Widget nameForm() {
    return TextField(
      onChanged: (value) {
        name = value.trim();
      },
      decoration: InputDecoration(
        helperText: 'Type Your Name',
        labelText: 'Name :',
        icon: Icon(
          Icons.face,
          size: 36.0,
        ),
      ),
    );
  }

  Widget emailForm() {
    return TextField(keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        email = value.trim();
      },
      decoration: InputDecoration(
        helperText: 'Type Your Email',
        labelText: 'Email :',
        icon: Icon(
          Icons.email,
          size: 36.0,
        ),
      ),
    );
  }

  Widget passwordForm() {
    return TextField(
      onChanged: (value) {
        password = value.trim();
      },
      decoration: InputDecoration(
        helperText: 'Type Your Password',
        labelText: 'Password :',
        icon: Icon(
          Icons.lock,
          size: 36.0,
        ),
      ),
    );
  }

  Widget signUpButton() {
    return OutlineButton.icon(
      onPressed: () {
        print('You Click SignUp');

        if (name == null ||
            name.isEmpty ||
            email == null ||
            email.isEmpty ||
            password == null ||
            password.isEmpty) {
          print('Have Space');
          normalDialog(context, 'Have Space', 'Please Fill Every Blank');
        } else {
          registerThead();
        }
      },
      icon: Icon(Icons.cloud_upload),
      label: Text('Sign Up'),
    );
  }

  Future<void> registerThead() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((response) {
      print('Register Success');
    }).catchError((response) {
      String title = response.code;
      String message = response.message;
      normalDialog(context, title, message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: ListView(
        padding: EdgeInsets.all(50.0),
        children: <Widget>[
          nameForm(),
          emailForm(),
          passwordForm(),
          MyConstant().mySizebox,
          signUpButton(),
        ],
      ),
    );
  }
}
