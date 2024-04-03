import 'package:cropinsights2/AddCrop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cropinsights2/LoginPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cropinsights2/widget/SlideAnimation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = 'Loading...';

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  void fetchUserInfo() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userData.exists) {
          setState(() {
            userName = userData['email'];
          });
        } else {
          setState(() {
            userName = 'User Data Not Found';
          });
          print('User data does not exist');
        }
      } else {
        setState(() {
          userName = 'User Not Authenticated';
        });
        print('User not authenticated');
      }
    } catch (e) {
      setState(() {
        userName = 'Error Fetching Data: $e';
      });
      print('Error fetching user info: $e');
    }
  }

  void logout() async {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginModule()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional(0, -1.11),
              child: Container(
                width: 413,
                height: 202,
                decoration: BoxDecoration(
                  color: Color(0xE80B7E1B),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(-0.88, -0.29),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: Text(
                          userName,
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFFE8EAEC),
                            fontSize: 35,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.94, -0.81),
                      child: IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {
                          logout();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-0.11, -0.64),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(18, 0, 18, 0),
                child: Material(
                  color: Colors.transparent,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Container(
                    width: 362,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-0.92, 0.66),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFFA640E8),
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20, 18, 0, 0),
                              child: FaIcon(
                                FontAwesomeIcons.temperatureLow,
                                color: Color(0xFF151616),
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-0.47, 0.55),
                          child: Text(
                            "Temp",
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF0A0A0B),
                              fontSize: 18,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.26, -0.46),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFF0099FD),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.83, -0.38),
                          child: Text(
                            "Soil Type",
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF0A0A0B),
                              fontSize: 18,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.27, 0.66),
                          child: Container(
                            width: 63,
                            height: 63,
                            decoration: BoxDecoration(
                              color: Color(0xFFE2DF31),
                              shape: BoxShape.circle,
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Icon(
                                Icons.hub,
                                color: Color(0xFF151616),
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.87, 0.54),
                          child: Text(
                            "Humidity",
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF0A0A0B),
                              fontSize: 18,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-0.91, -0.47),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFF2FF44A),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-0.43, -0.38),
                          child: Text(
                            "Location",
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF0A0A0B),
                              fontSize: 18,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.22, -0.43),
                          child: Icon(
                            Icons.landscape_sharp,
                            color: Color(0xFF151616),
                            size: 30,
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-0.82, -0.39),
                          child: Icon(
                            Icons.location_on,
                            color: Color(0xFF151616),
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-0.18, -0.04),
              child: GestureDetector(
                child: Container(
                  width: 370,
                  height: 60,
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                  color: Color(0xE80B7E1B),
                  child: Center(
                    child: Text("Add Crop",
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.of(context).push(SlideAnimation(child: AddCrop(),
                      direction: AxisDirection.left));
                },
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.7, -0.04),
              child: Icon(
                Icons.arrow_forward,
                color: Color(0xFFE1E5E5),
                size: 33,
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-0.09, 0.43),
              child: Text(
                "Currently No Monitoring...",
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  color: Color(0xFF515151),
                  fontSize: 20,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
