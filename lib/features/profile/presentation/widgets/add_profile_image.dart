import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_store/core/_core.dart' show ApiEndpoints;

import '/config/shared/_shared.dart';
import '/core/utils/_utils.dart';
import '/features/_features.dart'
    show
        LoadedState,
        LoadingState,
        ProfileBloc,
        ProfileState,
        UpdateProfileImageEvent;

class AddProfileImage extends StatefulWidget {
  const AddProfileImage({super.key});

  @override
  State<AddProfileImage> createState() => _AddProfileImageState();
}

class _AddProfileImageState extends State<AddProfileImage> {
  Future<void> _updateProfileImage() async {
    File? file = await TFunctions.pickAndUploadProfileImage(context);

    if (file != null) {
      if (mounted) {
        context.read<ProfileBloc>().add(UpdateProfileImageEvent(file: file));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme;

    return Center(
      child: OnTapScaler(
        onTap: _updateProfileImage,
        child: SizedBox(
          width: 120,
          height: 120,
          child: Stack(
            alignment: Alignment.center,
            children: [
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return const CircularProgressIndicator();
                  }

                  if (state is LoadedState) {
                    final profile = state.profile;
                    final image = '${ApiEndpoints.imageUrl}${profile.imageUrl}';

                    return SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(image, fit: BoxFit.cover),
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: OnTapScaler(
                  onTap: _updateProfileImage,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: color.secondary,
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: color.onSecondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
