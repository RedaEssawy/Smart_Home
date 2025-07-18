import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/controler/user_cubit/user_cubit.dart';
import 'package:smart_home/core/api/dio_consumer.dart';
import 'package:smart_home/core/util/app_colors.dart';
import 'package:smart_home/core/util/app_routes.dart';
import 'package:smart_home/views/widgets/lable_with_text_field.dart';
import 'package:smart_home/views/widgets/social_media_botton.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _hiddenPassword = true;
  Widget icon = Icon(Icons.remove_red_eye_outlined);

  late final DioConsumer dio;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    dio = DioConsumer(dio: Dio());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final cubit = BlocProvider.of<AuthCubit>(context);

    return LayoutBuilder(
        builder: (context, constraint) => Scaffold(
              body: SafeArea(
                  child: BlocConsumer<UserCubit, UserState>(
                listener: (context, state) {
                  // Navigator.pushNamed(context, AppRoutes.dashboardRoute);
                  if (state is SignInSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Login Success'),
                    ));
                    //if login success get user data
                    // context.read().getUserData();
                    // if login success navigate to home
                    Navigator.pushNamed(context, AppRoutes.homeRoute);
                  } else if (state is SignInFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)));
                  }
                },
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 18),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Login Account',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: constraint.maxHeight * 0.03,
                            ),
                            Text(
                              'Please, login with registered account',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: AppColors.grey),
                            ),
                            SizedBox(
                              height: constraint.maxHeight * 0.06,
                            ),
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
                            SizedBox(height: constraint.maxHeight * 0.02),
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
                              hintText: 'Enter your password',
                              sufixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _hiddenPassword = !_hiddenPassword;
                                      if (_hiddenPassword == false) {
                                        icon = Icon(Icons.remove_red_eye);
                                      } else {
                                        icon = Icon(
                                            Icons.remove_red_eye_outlined);
                                      }
                                    });
                                  },
                                  icon: icon
                                  //  Icon(Icons.remove_red_eye_outlined)
                                  ),
                            ),
                            SizedBox(height: constraint.maxHeight * 0.01),
                            Align(
                              alignment: Alignment.topRight,
                              child: TextButton(
                                  onPressed: () {},
                                  child: Text('Forgot Password?')),
                            ),
                            SizedBox(height: constraint.maxHeight * 0.03),
                            state is SignInLoading
                                ? CircularProgressIndicator()
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.deepPrple,
                                        minimumSize:
                                            Size(constraint.maxWidth, 50)),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        // await cubit.authServiecs.login(
                                        // emailController.text,
                                        // passwordController.text);
                                        // Navigator.of(context)
                                        //     .pushNamed(AppRoutes.dashboardRoute);
    
                                        context.read<UserCubit>().signIn(usernameOrPhone: emailController.text, password: passwordController.text);
                                      }
                                    },
                                    child: Text('Login',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(
                                                color: AppColors.white)),
                                  ),
                            SizedBox(height: constraint.maxHeight * 0.03),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Don\'t have an account?'),
                                TextButton(
                                    onPressed: () => Navigator.of(context)
                                        .pushNamed(AppRoutes.registerRoute),
                                    child: Text('Sign Up'))
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
                    ),
                  );
                },
              )),
            ));
  }
}
