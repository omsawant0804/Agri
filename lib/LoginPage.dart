import 'package:cropinsights2/HomePage.dart';
import 'package:cropinsights2/SignUpPage.dart';
import 'package:cropinsights2/widget/SlideAnimation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
class LoginModule extends StatefulWidget {
  const LoginModule({super.key});

  @override
  State<LoginModule> createState() => _LoginModuleState();
}

class _LoginModuleState extends State<LoginModule> {
  final _formKey=GlobalKey<FormState>();
  final emailController=TextEditingController();
  final passController=TextEditingController();
  
  final emailFocusNode=FocusNode();
  final passFocusNode=FocusNode();
  var _isObscured=true;

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isEmpty || !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }
  Future<void> login(String email, String password) async {
    try {
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Exception: ${e.message}'); // Print the error message
      if (e.code == 'user-not-found') {
        // Email is not registered
        Fluttertoast.showToast(
          msg: "No account found with this email. Please sign up.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      } else if (e.code == 'wrong-password') {
        // Incorrect password
        Fluttertoast.showToast(
          msg: "Invalid credentials. Please try again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      } else {
        // Other Firebase Auth exceptions
        Fluttertoast.showToast(
          msg: "An error occurred (${e.code}). Please try again later.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      // Handle other exceptions
      print('Error: $e');
      Fluttertoast.showToast(
        msg: "An error occurred. Please try again later.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
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
            alignment: AlignmentDirectional(-0.08, -0.80),
            child: Text("Welcome to",

              style: TextStyle(
                fontFamily: 'Readex Pro',
                color: Color(0xFFE8EAEC),
                fontSize: 34,
                letterSpacing: 0,
              ),
            ),
          ),

          // Logo...
          Align(
            alignment: AlignmentDirectional(-110.07, -0.60),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/logo.png',
                width: 411,
                height: 244,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // continue with google BTN

          Align(
            alignment: AlignmentDirectional(0, -0.10),
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
                              child: FaIcon(FontAwesomeIcons.google,
                                  color: Color(0xFF0A0A0B),
                                  size: 24,
                                ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.17, 0.01),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(6, 0, 0, 0),
                                child:TextButton(
                                  child: Text(
                                    "Login with google",
                                    style:
                                    TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFF0A0A0B),
                                      fontSize: 18,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  onPressed: (){

                                  },
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
            alignment: AlignmentDirectional(0, 0.12),
           child: Form(
             key: _formKey,
             child:Stack(
               children: [
                 Align(
                   alignment: AlignmentDirectional(0, 0.12),
                   child: Row(
                     mainAxisSize: MainAxisSize.max,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Container(
                         width: 365,
                         height: 58,
                         decoration: BoxDecoration(
                           color: Color(0xE8297F35),
                           borderRadius: BorderRadius.circular(12),
                         ),
                         child: Padding(
                           padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                           child: TextFormField(
                             focusNode: emailFocusNode,
                             controller: emailController,
                             validator: validateEmail,
                             keyboardType: TextInputType.emailAddress,
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
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),


                 Align(
                   alignment: AlignmentDirectional(0, 0.3),
                   child: Row(
                     mainAxisSize: MainAxisSize.max,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Container(
                         width: 365,
                         height: 58,
                         decoration: BoxDecoration(
                           color: Color(0xE8297F35),
                           borderRadius: BorderRadius.circular(12),
                         ),
                         child: Padding(
                           padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                           child: TextFormField(
                             autofocus: true,
                             controller: passController,
                             obscureText: _isObscured,
                             validator: (value){
                               if(value == null || value.length<6){
                                  return "enter 8 length password";
                               }
                             },
                             decoration: InputDecoration(
                               suffixIcon: GestureDetector(
                                 onTap: (){
                                   setState(() {
                                     _isObscured = !_isObscured;
                                   });
                                 },
                                 child: _isObscured ? const Icon(Icons.visibility_off,color: Colors.white,):const Icon(Icons.visibility,color: Colors.white,),
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
              // email



//LoginBtn

          Align(
            alignment: AlignmentDirectional(0, 0.62),
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
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: TextButton(
                                  child: Text(
                                    "Login",
                                    style:
                                    TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Color(0xFF0A0A0B),
                                      fontSize: 20,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: (){
                           if (_formKey.currentState!.validate()) {
                             login(
                               emailController.text.toString(),
                               passController.text.toString(),
                             );
                           }
                                  },
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
            alignment: AlignmentDirectional(0, 0.42),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Color(0xFFE8EAEC),
                      fontSize: 16,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Align(
            alignment: AlignmentDirectional(0, 0.83),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                 "Don't have an account",
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
                       "SignUp",
                        style: TextStyle(
                          fontFamily: 'Readex Pro',
                          color: Color(0xFFE2DF31),
                          fontSize: 16,
                          letterSpacing: 0,
                        ),
                      ),
                      onPressed: (){
                        Navigator.of(context).push(SlideAnimation(child: SignUpModule(),
                            direction: AxisDirection.left));
                      },
                    ),
                  ),
                ),
              ],
            ),
          )




        ],
      ),
    );
  }
}
