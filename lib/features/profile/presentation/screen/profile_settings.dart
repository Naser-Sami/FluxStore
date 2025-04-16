import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_store/features/profile/presentation/controllers/_controllers.dart';
import 'package:go_router/go_router.dart';

import '/config/_config.dart'
    show
        CustomButton,
        TPadding,
        TRadius,
        TSize,
        TextFormFieldComponent,
        TextWidget;
import '/core/_core.dart'
    show
        BuildContextExtensions,
        LocaleKeys,
        TValidator,
        errorDialog,
        showLoadingDialog;
import '/features/_features.dart'
    show
        AddProfileImage,
        ProfileBloc,
        ProfileState,
        UpdateProfileEvent,
        UpdateProfileParams;

class ProfileSettingsScreen extends StatefulWidget {
  static const routeName = '/profile/settings';
  static const String name = 'Profile Settings';
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  String gender = 'Other';

  @override
  void initState() {
    super.initState();
    initializeProfileData();
  }

  void initializeProfileData() {
    final state = context.read<ProfileBloc>().state;
    _firstNameController.text = state.profile.firstName;
    _lastNameController.text = state.profile.lastName;
    _emailController.text = state.profile.email;

    log('Phone Number: ${state.profile.phoneNumber}');
    _phoneController.text = state.profile.phoneNumber;
    if (state.profile.gender == '') {
      gender = 'Other';
    } else {
      gender = state.profile.gender;
    }
  }

  void _updateProfile() {
    final state = context.read<ProfileBloc>().state;

    if (_formKey.currentState!.validate()) {
      context.read<ProfileBloc>().add(
        UpdateProfileEvent(
          params: UpdateProfileParams(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            gender: gender,
            email: _emailController.text,
            phoneNumber: _phoneController.text,
            imageUrl: state.profile.imageUrl,
            address: state.profile.address,
          ),
        ),
      );

      context.pop();
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;

    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is LoadingState) {
          showLoadingDialog(context);
          context.pop();
        }

        if (state is ErrorState) {
          errorDialog(context, message: state.error);
        }

        if (state is LoadedState) {
          // context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Profile Settings')),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: TPadding.p24,
              horizontal: TPadding.p32,
            ),
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                return Column(
                  children: [
                    const AddProfileImage(),
                    const Spacer(),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: TextFormFieldComponent(
                              controller: _firstNameController,
                              hintText: LocaleKeys.Profile_firstName,
                              labelText: LocaleKeys.Profile_firstName,
                              onChanged: (value) {},
                              validator:
                                  (value) => TValidator.validateEmptyText(
                                    LocaleKeys.Profile_firstName,
                                    value,
                                  ),
                            ),
                          ),
                          const SizedBox(width: TPadding.p16),
                          Expanded(
                            flex: 4,
                            child: TextFormFieldComponent(
                              controller: _lastNameController,
                              hintText: LocaleKeys.Profile_lastName,
                              labelText: LocaleKeys.Profile_lastName,
                              onChanged: (value) {},
                              validator:
                                  (value) => TValidator.validateEmptyText(
                                    LocaleKeys.Profile_lastName,
                                    value,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: TSize.s30),
                    TextFormFieldComponent(
                      controller: _emailController,
                      hintText: LocaleKeys.Profile_email,
                      labelText: LocaleKeys.Profile_email,
                      onChanged: (value) {},
                      // readOnly: true,
                      validator: TValidator.validateEmail,
                    ),
                    const SizedBox(height: TSize.s30),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: 54,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: color.outline,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: DropdownButton(
                                isExpanded: true,
                                value: gender,
                                icon: const SizedBox(),
                                underline: const SizedBox(),
                                borderRadius: BorderRadius.circular(
                                  TRadius.r12,
                                ),
                                items: [
                                  const DropdownMenuItem(
                                    value: "Male",
                                    child: TextWidget('Male'),
                                  ),
                                  const DropdownMenuItem(
                                    value: 'Female',
                                    child: TextWidget('Female'),
                                  ),
                                  const DropdownMenuItem(
                                    value: 'Other',
                                    child: TextWidget('Other'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: TPadding.p16),
                          Expanded(
                            flex: 7,
                            child: TextFormFieldComponent(
                              controller: _phoneController,
                              hintText: LocaleKeys.Profile_phonNumber,
                              labelText: LocaleKeys.Profile_phonNumber,
                              onChanged: (value) {},
                              validator:
                                  (value) => TValidator.validateEmptyText(
                                    LocaleKeys.Profile_phonNumber,
                                    value,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),
                    CustomButton(
                      backgroundColor: color.secondary,
                      onTap: _updateProfile,
                      text: LocaleKeys.Profile_saveChanges,
                    ),
                    const Spacer(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
