import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/controler/user_cubit/user_cubit.dart';
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
  bool _hiddenPassword = true;
  Widget icon=Icon(Icons.remove_red_eye_outlined);
  final confirmPasswordController = TextEditingController();
  final  fullNameControler = TextEditingController();
  final _userControler = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
          Navigator.pushNamed(context, AppRoutes.homeRoute);
        } else if (state is SignUpFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        return LayoutBuilder(
            builder: (context, constraint) => Scaffold(
                  body: SafeArea(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 18),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Create Account',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold),
                            ),
                            // SignUpPicture(),
                            SizedBox(height: constraint.maxHeight * 0.01),
                            LableWithTextField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'User name is required';
                                }
                                return null;
                              },
                              title: 'UserName',
                              controller: _userControler,
                              prefixIcon: Icons.person,
                              hintText: 'Enter your Name',
                            ),
                            SizedBox(height: constraint.maxHeight * 0.01),
                            LableWithTextField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Full name is required';
                                }
                                return null;
                              },
                              title: 'Full Name',
                              controller: fullNameControler,
                              prefixIcon: Icons.person,
                              hintText: 'Enter your Full Name',
                            ),
                            SizedBox(height: constraint.maxHeight * 0.01),
                            LableWithTextField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Phone number is required';
                                }
                                return null;
                              },
                              title: "Phone Number",
                              controller: phoneController,
                              prefixIcon: Icons.phone,
                              hintText: 'Enter your phone number',
                            ),
                            SizedBox(height: constraint.maxHeight * 0.01),
                            LableWithTextField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email is required';
                                }
                                return null;
                              },
                              title: 'Email',
                              controller: emailController,
                              prefixIcon: Icons.email,
                              hintText: 'Enter your email',
                            ),
                            SizedBox(height: constraint.maxHeight * 0.01),
                            LableWithTextField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                }
                                return null;
                              },
                              obscureText: _hiddenPassword,
                              title: 'Password',
                              controller: passwordController,
                              prefixIcon: Icons.lock,
                              hintText: 'your password',
                              sufixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _hiddenPassword = !_hiddenPassword;
                                      if(_hiddenPassword==false){
                                        icon=Icon(Icons.remove_red_eye);
                                      }
                                    });
                                  },
                                  icon:icon
                                  //  Icon(Icons.remove_red_eye_outlined)
                                   ),
                            ),
                            SizedBox(height: constraint.maxHeight * 0.01),
                            LableWithTextField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Confirm Password is required';
                                }else if(value!=passwordController.text){
                                  return 'Password does not match';
                                }
                                return null;
                              },
                              obscureText: _hiddenPassword,
                              title: 'Confirm Password',
                              controller: confirmPasswordController,
                              prefixIcon: Icons.lock,
                              hintText: 'Confirm your password',
                              sufixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _hiddenPassword = !_hiddenPassword;
                                      if(_hiddenPassword==false){
                                        icon=Icon(Icons.remove_red_eye);
                                      }
                                    });
                                  },
                                  icon:icon
                                  //  Icon(Icons.remove_red_eye_outlined)
                                   ),
                            ),
                            SizedBox(height: constraint.maxHeight * 0.02),
                            state is SignUpLoading
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.deepPrple,
                                        minimumSize:
                                            Size(constraint.maxWidth, 50)),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<UserCubit>().signUp(
                                            fullName: fullNameControler.text,
                                            email: emailController.text,
                                            password: passwordController.text,
                                            confirmPassword:
                                                confirmPasswordController.text,
                                            name: _userControler.text,
                                            phoneNumber: phoneController.text);
                                        Navigator.of(context).pushNamed(
                                            AppRoutes.dashboardRoute);
                                      }
                                    },
                                    child: Text('Register',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: AppColors.white)),
                                  ),
                            SizedBox(height: constraint.maxHeight * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('You have an account? '),
                                TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text('Login'))
                              ],
                            ),
                            SizedBox(height: constraint.maxHeight * 0.03),
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
                            SizedBox(height: constraint.maxHeight * 0.01),
                            SocialMediaBotton(
                                title: 'Login with Google',
                                icon: Icons.g_mobiledata,
                                onTap: () {}),
                            SizedBox(height: constraint.maxHeight * 0.01),
                            SocialMediaBotton(
                              title: 'Login with Facebook',
                              icon: Icons.facebook,
                              onTap: () {},
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
                ));
      },
    );
  }
}
