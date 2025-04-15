part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    required this.profile,
    required this.error,
    required this.statusCode,
    required this.isLoading,
  });

  final Profile profile;
  final String error;
  final int statusCode;
  final bool isLoading;

  ProfileState copyWith({
    Profile? profile,
    String? error,
    int? statusCode,
    bool? isLoading,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      error: error ?? this.error,
      statusCode: statusCode ?? this.statusCode,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [profile, error, statusCode, isLoading];
}
