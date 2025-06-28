import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home/controler/user_cubit/user_cubit.dart';
import 'package:smart_home/core/api/dio_consumer.dart';
import 'package:smart_home/core/util/app_colors.dart';
import 'package:smart_home/core/util/app_routes.dart';

class ProfilePage extends StatelessWidget {
  final DioConsumer api;
  const ProfilePage({super.key, required this.api});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is GetUserDataFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is GetUserDataLoading
              ? CircularProgressIndicator()
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text("Account",
                              style: Theme.of(context).textTheme.headlineLarge),
                          SizedBox(height: 20),
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                              // state
                                    // is GetUserDataSuccess
                                // ? state.user.profilePic
                                // : 
                                'https://cdn-icons-png.flaticon.com/512/149/149071.png'),
                          ),
                          Text(
                            state is GetUserDataSuccess
                                ? state.userModel.username.toString()
                                : 'User Name',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(height: 20),
                          ProfileItemInfo(
                            title: state is GetUserDataSuccess
                                ? state.userModel.username.toString()
                                : 'User Name',
                            iconType: Icons.person,
                          ),
                          SizedBox(height: 20),
                          ProfileItemInfo(
                              title: state is GetUserDataSuccess
                                  ? state.userModel.email.toString()
                                  : 'email',
                              iconType: Icons.email),
                          SizedBox(height: 20),
                          ProfileItemInfo(
                            title: state is GetUserDataSuccess
                                ? state.userModel.phoneNumber.toString()
                                : 'phone number',
                            iconType: Icons.phone,
                          ),
                          SizedBox(height: 20),
                          ProfileItemInfo(
                            title: state is GetUserDataSuccess
                                ? state.userModel.homeAddress.toString()
                                : 'address',
                            iconType: Icons.location_on,
                          ),
                          SizedBox(height: 20),
                          ProfileItemInfo(
                            title: 'Settings',
                            iconType: Icons.settings,
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.settingRoute);
                              
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class ProfileItemInfo extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final IconData iconType;
  const ProfileItemInfo({
    this.onTap,
    required this.iconType,
    required this.title,
    super.key,                      

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.grey3,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(iconType, color: AppColors.blue),
        title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
      ),
    );
  }
}
