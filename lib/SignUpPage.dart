import 'package:cropinsights2/HomePage.dart';
import 'package:cropinsights2/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cropinsights2/widget/SlideAnimation.dart';
import 'package:fluttertoast/fluttertoast.dart';


class SignUpModule extends StatefulWidget {
  const SignUpModule({Key? key});

  @override
  State<SignUpModule> createState() => _SignUpModuleState();
}

class _SignUpModuleState extends State<SignUpModule> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final cpassController = TextEditingController();
  final passController = TextEditingController();

  final emailFocusNode = FocusNode();
  final cpassFocusNode = FocusNode();
  final passFocusNode = FocusNode();
  var _isObscured = true;

  String? validateEmail(String? value) {
    const pattern =
        r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"
        r"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*)@"
        r"(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|"
        r"(?:2[0-4]|1\d|[1-9])?\d(?:\.(?:25[0-5]|(?:2[0-4]|1\d|[1-9])?\d){3}))|(?:(?:[a-z0-9](?:[a-z0-9-]*"
        r"[a-z0-9])?\.)*(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?))))";

    final regex = RegExp(pattern);

    return value!.isEmpty || !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  Future<void> signUp(String email, String password, String confirmPassword) async {
    if (email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty) {
      if (password != confirmPassword) {
        // Passwords do not match
        Fluttertoast.showToast(
          msg: "Passwords do not match",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return;
      }
      try {
        final userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      } on FirebaseAuthException catch (e) {
        // Handle specific firebase auth exceptions here
        print('Firebase Auth Exception: ${e.message}');
      } catch (e) {
        // Handle other exceptions
        print('Error: $e');
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xE80B7E1B),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(-0.01, -0.82),
            child: Text(
              "SignUp",
              style: TextStyle(
                fontFamily: 'Readex Pro',
                color: Color(0xFFE8EAEC),
                fontSize: 40,
                letterSpacing: 0,
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0, -0.5),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 340,
                  height: 58,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 340,
                        height: 58,
                        child: Stack(
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-0.56, 0.13),
                              child: FaIcon(
                                FontAwesomeIcons.google,
                                color: Color(0xFF0A0A0B),
                                size: 24,
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.28, 0.07),
                              child: Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: TextButton(
                                  child: Text(
                                    "SignUp with google",
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFF0A0A0B),
                                      fontSize: 18,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0, 7),
            child: Form(
              key: _formKey,
              child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, -0.24),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 368,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Color(0xE8297F35),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: TextFormField(
                              controller: emailController,
                              focusNode: emailFocusNode,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                                hintText: "Enter email",
                                hintStyle: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                  fontSize: 18,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                letterSpacing: 0,
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              minLines: null,
                              validator: validateEmail,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0, -0.01),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 365,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Color(0xE8297F35),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 12, 8, 12),
                    child: TextFormField(
                      controller: passController,
                      focusNode: passFocusNode,
                      autofocus: true,
                      obscureText: _isObscured,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                          child: _isObscured
                              ? const Icon(Icons.visibility_off,
                              color: Colors.white)
                              : const Icon(Icons.visibility,
                              color: Colors.white),
                        ),
                        labelStyle: TextStyle(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0,
                        ),
                        hintText: "Enter Password",
                        hintStyle: TextStyle(
                          fontFamily: 'Readex Pro',
                          color: Colors.white,
                          fontSize: 18,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      minLines: null,
                      validator: (value) {
                        if (value == null || value.length < 8) {
                          return "Enter 8 characters minimum";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0, 0.21),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 365,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Color(0xE8297F35),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 12, 8, 12),
                    child: TextFormField(
                      controller: cpassController,
                      focusNode: cpassFocusNode,
                      autofocus: true,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0,
                        ),
                        hintText: "Enter Confirm Password",
                        hintStyle: TextStyle(
                          fontFamily: 'Readex Pro',
                          color: Colors.white,
                          fontSize: 18,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      minLines: null,
                      validator: (value) {
                        if (value != passController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0, 0.46),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 340,
                  height: 58,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 340,
                        height: 58,
                        child: Stack(
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: TextButton(
                                child: Text(
                                  "SignUp",
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Color(0xFF0A0A0B),
                                    fontSize: 20,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    signUp(
                                      emailController.text.toString(),
                                      passController.text.toString(),
                                      cpassController.text.toString(), // Pass confirm password here
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0, 0.75),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account ?",
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    color: Color(0xFFE8EAEC),
                    fontSize: 16,
                    letterSpacing: 0,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: TextButton(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          color: Color(0xFFE2DF31),
                          fontSize: 16,
                          letterSpacing: 0,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          SlideAnimation(
                            child: LoginModule(),
                            direction: AxisDirection.right,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
