import 'package:email_otp/email_otp.dart';

import '/core/_core.dart' show AppConfig;

abstract class ISendEmailOtpService {
  dynamic config({
    String? appName,
    String? appEmail,
    int? otpLength,
    OTPType? otpType,
    int? expiry,
    EmailTheme? emailTheme,
  });

  dynamic setSMTP({
    required EmailPort emailPort,
    required SecureType secureType,
    required String host,
    required String username,
    required String password,
  });

  Future<bool> sendOTP({required String email});
  bool verifyEmailOTP({required String otp});
  String? getOTP();
  bool isOtpExpired();
  dynamic setTemplate({required String? template});
}

class SendEmailOtpServiceImpl implements ISendEmailOtpService {
  @override
  config({
    String? appName,
    String? appEmail,
    int? otpLength,
    OTPType? otpType,
    int? expiry,
    EmailTheme? emailTheme,
  }) {
    EmailOTP.config(
      appName: AppConfig.appName,
      appEmail: AppConfig.appEmail,
      otpType: OTPType.numeric,
      expiry: expiry ?? 60000,
      emailTheme: emailTheme ?? EmailTheme.v6,
      otpLength: otpLength ?? 4,
    );
  }

  @override
  Future<bool> sendOTP({required String email}) async =>
      await EmailOTP.sendOTP(email: email.trim());

  @override
  bool verifyEmailOTP({required String otp}) => EmailOTP.verifyOTP(otp: otp);

  @override
  String? getOTP() => EmailOTP.getOTP();

  @override
  bool isOtpExpired() => EmailOTP.isOtpExpired();

  @override
  setSMTP({
    required EmailPort emailPort,
    required SecureType secureType,
    required String host,
    required String username,
    required String password,
  }) {
    // TODO: implement setSMTP
    EmailOTP.setSMTP(
      host: 'mail.rohitchouhan.com',
      emailPort: EmailPort.port25,
      secureType: SecureType.tls,
      username: 'test@rohitchouhan.com',
      password: 'm9eFxuBQ4hbD5XGP3TEdWN',
    );
  }

  @override
  setTemplate({required String? template}) {
    EmailOTP.setTemplate(
      template:
          template ??
          '''
    <div style="background-color: #f4f4f4; padding: 20px; font-family: Arial, sans-serif;">
      <div style="background-color: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);">
        <h1 style="color: #333;">{{appName}}</h1>
        <p style="color: #333;">Your OTP is <strong>{{otp}}</strong></p>
        <p style="color: #333;">This OTP is valid for 5 minutes.</p>
        <p style="color: #333;">Thank you for using our service.</p>
      </div>
    </div>
    ''',
    );
  }
}
