import 'package:flutter/material.dart';
import 'package:smart_home/core/util/app_colors.dart';
import 'package:smart_home/core/util/app_routes.dart';
import 'package:smart_home/views/widgets/lable_with_text_field.dart';
import 'package:smart_home/views/widgets/social_media_botton.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _userControler = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraint) => Scaffold(
          body: SafeArea(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Create Account',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: AppColors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: constraint.maxHeight * 0.03,
                      ),
                      Text(
                        'Start, registration and fine!',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: AppColors.grey),
                      ),
                      SizedBox(
                        height: constraint.maxHeight * 0.06,
                      ),
                      LableWithTextField(
                        title: 'UserName',
                        controller: _userControler,
                        prefixIcon: Icons.person,
                        hintText: 'Enter your Name',
                      ),
                      SizedBox(height: constraint.maxHeight * 0.02),
                      LableWithTextField(
                        title: 'Email',
                        controller: emailController,
                        prefixIcon: Icons.email,
                        hintText: 'Enter your email',
                      ),
                      SizedBox(height: constraint.maxHeight * 0.02),
                      LableWithTextField(
                        obscureText: true,
                        title: 'Password',
                        controller: passwordController,
                        prefixIcon: Icons.lock,
                        hintText: 'Enter your password',
                        sufixIcon: IconButton(
                            onPressed: () {
                              setState(() {});
                            },
                            icon: Icon(Icons.remove_red_eye_outlined)),
                      ),

                      SizedBox(height: constraint.maxHeight * 0.03),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.deepPrple,
                            minimumSize: Size(constraint.maxWidth, 50)),
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            Navigator.of(context).pushNamed(AppRoutes.dashboardRoute);
                          }
                        },
                        child: Text('Register',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: AppColors.white)),
                      ),
                      SizedBox(height: constraint.maxHeight * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('You have an account? '),
                          TextButton(onPressed: ()=> Navigator.of(context).pop(), child: Text('Login'))
                        ],
                      ),
                      SizedBox(height: constraint.maxHeight * 0.05),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'Or use other sign in methods',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: AppColors.grey),
                        ),
                      ),
                      SizedBox(height: constraint.maxHeight * 0.02),
                      SocialMediaBotton(
                          title: 'Login with Google',
                          icon: Icons.g_mobiledata,
                          onTap: () {}),
                      SizedBox(height: constraint.maxHeight * 0.02),
                      SocialMediaBotton(
                        title: 'Login with Facebook',
                        icon: Icons.facebook,
                        onTap: () {},
                      )
                    ],
                  ),
                ),
              )),
        ));
  }
}
