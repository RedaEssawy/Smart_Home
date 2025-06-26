import 'package:flutter/material.dart';
import 'package:smart_home/views/widgets/lable_with_text_field.dart';

class SettingPage extends StatefulWidget {

  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  child:Icon(Icons.person),
                ),
                LableWithTextField(title: "change name", controller: nameController, prefixIcon: Icons.person, hintText: "Name",),
                SizedBox(height: 20,),
                LableWithTextField(title: "change email", controller: emailController, prefixIcon: Icons.email, hintText: "Email",),
                SizedBox(height: 20,),
                LableWithTextField(title: "change password", controller: passwordController, prefixIcon: Icons.password, obscureText: true, hintText: "Password",), 
                SizedBox(height: 20,),
                LableWithTextField(title: "change phone number", controller: phoneController, prefixIcon: Icons.phone, hintText: "Phone Number",),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}