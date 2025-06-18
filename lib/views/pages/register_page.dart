import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/controler/user_cubit/user_cubit.dart';
import 'package:smart_home/core/util/app_colors.dart';
import 'package:smart_home/views/widgets/lable_with_text_field.dart';
import 'package:smart_home/views/widgets/sign_up_picture.dart';
import 'package:smart_home/views/widgets/social_media_botton.dart';

import '../../core/api/dio_consumer.dart';

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
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(DioConsumer(dio: Dio())),
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if(state is SignUpSuccess){
            ScaffoldMessenger.of(context).showSnackBar( SnackBar(
              content: Text(state.message),
            ));
          }else if(state is SignUpFailure){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
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
                              SignUpPicture(),
                              SizedBox(height: constraint.maxHeight * 0.01),
                              LableWithTextField(
                                title: 'UserName',
                                controller: _userControler,
                                prefixIcon: Icons.person,
                                hintText: 'Enter your Name',
                              ),
                              SizedBox(height: constraint.maxHeight * 0.01),
                              LableWithTextField(
                                title: "Phone Number",
                                controller: phoneController,
                                prefixIcon: Icons.phone,
                                hintText: 'Enter your phone number',
                              ),
                              SizedBox(height: constraint.maxHeight * 0.01),
                              LableWithTextField(
                                title: 'Email',
                                controller: emailController,
                                prefixIcon: Icons.email,
                                hintText: 'Enter your email',
                              ),
                              SizedBox(height: constraint.maxHeight * 0.01),
                              LableWithTextField(
                                obscureText: true,
                                title: 'Password',
                                controller: passwordController,
                                prefixIcon: Icons.lock,
                                hintText: 'your password',
                                sufixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {});
                                    },
                                    icon: Icon(Icons.remove_red_eye_outlined)),
                              ),
                              SizedBox(height: constraint.maxHeight * 0.01),
                              LableWithTextField(
                                obscureText: true,
                                title: 'Confirm Password',
                                controller: passwordController,
                                prefixIcon: Icons.lock,
                                hintText: 'Confirm your password',
                                sufixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {});
                                    },
                                    icon: Icon(Icons.remove_red_eye_outlined)),
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
                                            
                                          );
                                          // Navigator.of(context).pushNamed(
                                          //     AppRoutes.dashboardRoute);
                                        }
                                      },
                                      child: Text('Register',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                  color: AppColors.white)),
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
      ),
    );
  }
}
