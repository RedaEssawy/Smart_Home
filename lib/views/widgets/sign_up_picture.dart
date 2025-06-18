import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_home/controler/user_cubit/user_cubit.dart';
import 'package:smart_home/core/util/app_colors.dart';

class SignUpPicture extends StatelessWidget {
  const SignUpPicture({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
                          listener: (context, state) {
                            // TODO: implement listener
                          },
                          builder: (context, state) {
                            return SizedBox(
                                height: 75,
                                width:75,
                                child: context.read<UserCubit>().profilePic ==
                                        null
                                    ? CircleAvatar(
                                        backgroundColor: AppColors.grey,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                                top: 5,
                                                right: 5,
                                                child: GestureDetector(
                                                  onTap: () async {},
                                                  child: Container(
                                                    height:
                                                        15,
                                                    width:
                                                        
                                                            15,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppColors.deepPrple,
                                                      border: Border.all(
                                                          color:
                                                              AppColors.white,
                                                          ),
                                                      borderRadius: BorderRadius
                                                          .circular(20
                                                                
                                                              ),
                                                    ),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        ImagePicker()
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .gallery)
                                                            .then((value) => context
                                                                .read<
                                                                    UserCubit>()
                                                                .uploadProfilePic(
                                                                    value!));
                                                      },
                                                      child: Icon(
                                                        size: 30,
                                                        Icons.camera_alt_sharp,
                                                        color: AppColors.grey3,
                                                      ),
                                                    ),
                                                  ),
                                                ))
                                          ],
                                        ))
                                    : CircleAvatar(
                                        backgroundImage: FileImage(File(context
                                            .read<UserCubit>()
                                            .profilePic!
                                            .path)),
                                      ));
                          },
                        );
  }
}