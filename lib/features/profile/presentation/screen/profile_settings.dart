import 'package:flutter/material.dart';
import 'package:flux_store/core/utils/_utils.dart';

import '/config/_config.dart'
    show
        CustomButton,
        TPadding,
        TRadius,
        TSize,
        TextFormFieldComponent,
        TextWidget;
import '/core/_core.dart' show BuildContextExtensions, LocaleKeys;
import '/features/_features.dart' show AddProfileImage;

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

    return Scaffold(
      appBar: AppBar(title: const Text('Profile Settings')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: TPadding.p24,
            horizontal: TPadding.p32,
          ),
          child: Column(
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
                validator: TValidator.validateEmail,
              ),
              const SizedBox(height: TSize.s30),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: color.outline, width: 1),
                          ),
                        ),
                        child: DropdownButton(
                          isExpanded: true,
                          // value: LocaleKeys.Profile_male,
                          icon: const SizedBox(),
                          underline: const SizedBox(),
                          borderRadius: BorderRadius.circular(TRadius.r12),
                          items: [
                            // DropdownMenuItem(
                            //   value: "Male",
                            //   child: TextWidget(LocaleKeys.Profile_male),
                            // ),
                            // DropdownMenuItem(
                            //   value: 'Female',
                            //   child: TextWidget(LocaleKeys.Profile_female),
                            // ),
                            // DropdownMenuItem(
                            //   value: LocaleKeys.Profile_other,
                            //   child: const TextWidget('Other'),
                            // ),
                          ],
                          onChanged: (value) {},
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
                onTap: () {},
                text: LocaleKeys.Profile_saveChanges,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
