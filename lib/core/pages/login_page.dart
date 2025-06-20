import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/controler/user_cubit/user_cubit.dart';
import 'package:smart_home/core/api/dio_consumer.dart';
import 'package:smart_home/core/util/app_colors.dart';
import 'package:smart_home/core/util/app_routes.dart';
import 'package:smart_home/core/widgets/lable_with_text_field.dart';
import 'package:smart_home/core/widgets/social_media_botton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(DioConsumer(dio:Dio())),
      child: LayoutBuilder(
          builder: (context, constraint) => Scaffold(
                body: SafeArea(
                    child: BlocConsumer<UserCubit, UserState>(
                  listener: (context, state) {
                    // if (state is SignInSuccess) {
                    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    //     content: Text('Login Success'),
                    //   ));
                    // } else if (state is SignInFailure) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(content: Text(state.errorMessage)));
                    // }
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 18),
                      child: Form(
                        key: _formKey,
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
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        Navigator.of(context)
                                            .pushNamed(AppRoutes.dashboardRoute);

                                        // context.read<UserCubit>().signIn();
                                      }
                                    },
                                    child: Text('Login',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: AppColors.white)),
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
                    );
                  },
                )),
              )),
    );
  }
}
