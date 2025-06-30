import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/controler/user_cubit/user_cubit.dart';
import 'package:smart_home/core/api/dio_consumer.dart';
import 'package:smart_home/core/errors/exceptions.dart';
import 'package:smart_home/core/util/app_colors.dart';
import 'package:smart_home/core/util/app_routes.dart';
import 'package:smart_home/views/widgets/lable_with_text_field.dart';
import 'package:smart_home/views/widgets/social_media_botton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _hiddenPassword = true;
  Widget icon = Icon(Icons.remove_red_eye_outlined);

  late final DioConsumer dio;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    dio = DioConsumer(dio: Dio());
    super.initState();
  }


void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }

void _handleSignIn() async {
    if (_isLoading) return; // Prevent multiple clicks

    setState(() {
      _isLoading = true; // Start loading
    });

    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      // Basic client-side validation
      if (email.isEmpty || password.isEmpty) {
        _showSnackBar('Please fill in all fields');
        return;
      }

      // Call backend API
      final result = await context.read<UserCubit>().signIn(usernameOrPhone: email,password:  password);

      if (result['success']) {
        _showSnackBar('Sign-in successful!');
        // Navigate to the next screen or perform other actions
      } else {
        // Handle specific backend errors
        final errorMessage = result['error'].toString().toLowerCase();
        if (errorMessage.contains('password')) {
          _showSnackBar('Incorrect password');
        } else if (errorMessage.contains('user') || errorMessage.contains('email')) {
          _showSnackBar('User not found');
        } else {
          _showSnackBar('Sign-in failed: ${result['error']}');
        }
      }
    } on ServerException catch (e) {
      _showSnackBar('An unexpected error occurred: ${e.errorModel.errorMessage}');
    } finally {
      setState(() {
        _isLoading = false; // Always stop loadingmessage
      });
    }
  }  

  @override
  Widget build(BuildContext context) {
      

    final cubit = BlocProvider.of<UserCubit>(context);
    

    return LayoutBuilder(
        builder: (context, constraint) => Scaffold(
              body: SafeArea(
                  child: BlocConsumer<UserCubit, UserState>(
                listener: (context, state) {
                  // Navigator.pushNamed(context, AppRoutes.dashboardRoute);
                  if (state is SignInSuccess)  {
                    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    //   content: Text('Login Success'),
                    // ));
                    // //if login success get user data
                    
                   cubit.getUserProfile();
                    // if login success navigate to home
                    // print('success');
                    Navigator.pushNamed(context, AppRoutes.dashboardRoute);
                  } else if (state is SignInFailure) {
                    // _showSnackBar(state.errorMessage);
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(
                    //       duration: Duration(seconds: 3),
                    //       content: Text(state.errorMessage)));
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
                              title: 'Name',
                              controller: emailController,
                              prefixIcon: Icons.person,
                              hintText: 'Enter your name or phone number',
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
                            _isLoading
                                ? CircularProgressIndicator()
                                :  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.deepPrple,
                                        minimumSize:
                                            Size(constraint.maxWidth, 50)),
                                    onPressed:_handleSignIn,
                                  // () async {
                                  //     if (_formKey.currentState!.validate()) {
                                  //       // await cubit.authServiecs.login(
                                  //       // emailController.text,
                                  //       // passwordController.text);
                                  //       // Navigator.of(context)
                                  //       //     .pushNamed(AppRoutes.dashboardRoute);
    
                                  //  final result =    await context.read<UserCubit>().signIn(usernameOrPhone: 
                                  //  emailController.text, password: passwordController.text);

                                  //     }
                                  //   },
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
