import 'dart:io';
import 'package:desmokrizer/screens/firstStepWizardScreens/smoking_costs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  DateTime _selectedDate = DateTime.now();
  File? userImage;
  final formKey = GlobalKey<FormState>();
  var _username = "";

  String _formatDate() {
    final formatter = DateFormat('yyyy-MM-dd - HH:mm');
    return formatter.format(_selectedDate);
  }

  void _selectTime() async {
    final now = DateTime.now();

    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
    );

    if (selectedTime != null) {
      setState(() {
        _selectedDate = DateTime(_selectedDate.year, _selectedDate.month,
            _selectedDate.day, selectedTime.hour, selectedTime.minute);
      });
    }
  }

  void _showDatePicker() async {
    final now = DateTime.now();

    final firstDate = DateTime(
      now.year - 15,
      now.month,
      now.day,
      now.hour,
      now.minute,
    );

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
      });
    }

    _selectTime();
  }

  void _selectImage() async {
    final imagePicker = ImagePicker();
    final takenImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (takenImage == null) {
      return;
    }

    setState(() {
      userImage = File(takenImage.path);
    });
  }

  ImageProvider _displayImage() {
    if (userImage == null) {
      return const AssetImage("assets/images/user.png");
    }
    return FileImage(userImage!);
  }

  String? _validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return "Name must be set";
    }

    return null;
  }

  void _goToNextScreen() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      final Map<String, dynamic> userInput = {
        "name": _username,
        "image": userImage,
        "start": _selectedDate,
      };

      Navigator.of(context).push<Map<String, dynamic>>(
        MaterialPageRoute(
          builder: (ctx) => SmokingCosts(userInfo: userInput),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Set up your Profile",
          style: TextStyle(
            color: Color.fromARGB(255, 235, 251, 238),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/second-slide.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _selectImage,
                      child: CircleAvatar(
                        backgroundImage: _displayImage(),
                        radius: 70,
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    TextFormField(
                      autocorrect: false,
                      enableSuggestions: false,
                      textCapitalization: TextCapitalization.sentences,
                      maxLength: 20,
                      validator: _validateUserName,
                      onSaved: (newValue) {
                        _username = newValue!;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter your name",
                        counterText: "",
                        labelText: "Name",
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      initialValue: _formatDate(),
                      readOnly: true,
                      onTap: _showDatePicker,
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.calendar_month,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        counterText: "",
                        labelText: "Quit date",
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton.icon(
                      onPressed: _goToNextScreen,
                      icon: const Icon(
                        Icons.arrow_circle_right_outlined,
                        size: 28,
                      ),
                      label: const Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
