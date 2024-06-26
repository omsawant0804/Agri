import 'package:cropinsights2/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:cropinsights2/widget/SlideAnimation.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AddCrop extends StatefulWidget {
  const AddCrop({super.key});

  @override
  State<AddCrop> createState() => _AddCropState();
}

class _AddCropState extends State<AddCrop> {

  final List<String> cropType = [
    'Maize', 'Sugarcane', 'Cotton', 'Tobacco', 'Paddy', 'Barley',
    'Wheat', 'Millets', 'Oil seeds', 'Pulses', 'Ground Nuts'
  ];
  final List<String> SoilType = [
    'Sandy',
    'Clayey',
    'Red',
    'Loamy',
    'Black',

  ];

  String? selectedValueCropType;
  final TextEditingController textEditingControllerCropType = TextEditingController();

  String? selectedValueSoilType;
  final TextEditingController textEditingControllerSoilType = TextEditingController();

  CollectionReference cropsCollection = FirebaseFirestore.instance.collection('crops');
  @override
  void dispose() {
    textEditingControllerCropType.dispose();
    textEditingControllerSoilType.dispose();
    super.dispose();
  }
  void addCropDetails() async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Retrieve the user ID
      String userId = user.uid;

      // Reference to the 'crops' subcollection under the user's document
      CollectionReference cropsCollection = FirebaseFirestore.instance.collection('users').doc(userId).collection('crops');

      // Add the crop details to Firestore
      await cropsCollection.add({
        'cropname': selectedValueCropType,
        'soilType': selectedValueSoilType,
      });

      // Clear selections after adding to Firestore
      setState(() {
        selectedValueCropType = null;
        selectedValueSoilType = null;
      });

      // Show a snackbar to indicate success
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Crop added successfully!'),
      ));

      // Navigate back to the homepage
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false, // Clear the navigation stack
      );
    } else {
      // Handle the case where the user is not authenticated
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('User not authenticated.'),
      ));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xE80B7E1B),
      appBar: AppBar(
        backgroundColor: Color(0xE80B7E1B),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () async {
          },
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),

      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional(0, -0.81),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Enter Your Crop Details",
                    style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Color(0xFFE8EAEC),
                      fontSize: 30,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, -0.52),
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
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Select Crop type',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: cropType
                            .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                            .toList(),
                        value: selectedValueCropType,
                        onChanged: (value) {
                          setState(() {
                            selectedValueCropType = value;
                          });
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: 200,
                        ),
                        dropdownStyleData: const DropdownStyleData(
                          maxHeight: 200,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                        dropdownSearchData: DropdownSearchData(
                          searchController: textEditingControllerCropType,
                          searchInnerWidgetHeight: 50,
                          searchInnerWidget: Container(
                            height: 50,
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 4,
                              right: 8,
                              left: 8,
                            ),
                            child: TextFormField(
                              expands: true,
                              maxLines: null,
                              controller: textEditingControllerCropType,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                hintText: 'Search for an item...',
                                hintStyle: const TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          searchMatchFn: (item, searchValue) {
                            return item.value.toString().contains(searchValue);
                          },
                        ),
                        //This to clear the search value when you close the menu
                        onMenuStateChange: (isOpen) {
                          if (!isOpen) {
                            textEditingControllerCropType.clear();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, -0.28),
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
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Select Soil type',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: SoilType
                            .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                            .toList(),
                        value: selectedValueSoilType,
                        onChanged: (value) {
                          setState(() {
                            selectedValueSoilType = value;
                          });
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: 200,
                        ),
                        dropdownStyleData: const DropdownStyleData(
                          maxHeight: 200,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                        dropdownSearchData: DropdownSearchData(
                          searchController: textEditingControllerSoilType,
                          searchInnerWidgetHeight: 50,
                          searchInnerWidget: Container(
                            height: 50,
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 4,
                              right: 8,
                              left: 8,
                            ),
                            child: TextFormField(
                              expands: true,
                              maxLines: null,
                              controller: textEditingControllerSoilType,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                hintText: 'Search for an item...',
                                hintStyle: const TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          searchMatchFn: (item, searchValue) {
                            return item.value.toString().contains(searchValue);
                          },
                        ),
                        //This to clear the search value when you close the menu
                        onMenuStateChange: (isOpen) {
                          if (!isOpen) {
                            textEditingControllerSoilType.clear();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, 0.10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Container(
                      width: 305,
                      height: 58,
                      decoration: BoxDecoration(
                        color: Color(0xFFE8EAEC),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            if (selectedValueCropType != null && selectedValueSoilType != null) {
                              addCropDetails();

                            } else {
                              // Show error message if selections are not complete
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Please select crop type and soil type.'),
                              ));
                            }

                          },
                          child: Text(
                            "Submit",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF0A0A0B),
                              fontSize: 22,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
