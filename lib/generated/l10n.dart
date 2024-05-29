// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Localized {
  Localized();

  static Localized? _current;

  static Localized get current {
    assert(_current != null,
        'No instance of Localized was loaded. Try to initialize the Localized delegate before accessing Localized.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Localized> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Localized();
      Localized._current = instance;

      return instance;
    });
  }

  static Localized of(BuildContext context) {
    final instance = Localized.maybeOf(context);
    assert(instance != null,
        'No instance of Localized present in the widget tree. Did you add Localized.delegate in localizationsDelegates?');
    return instance!;
  }

  static Localized? maybeOf(BuildContext context) {
    return Localizations.of<Localized>(context, Localized);
  }

  /// `Password must contain at least one uppercase letter, one lowercase letter, one special character, and one number`
  String get password_too_weak {
    return Intl.message(
      'Password must contain at least one uppercase letter, one lowercase letter, one special character, and one number',
      name: 'password_too_weak',
      desc: '',
      args: [],
    );
  }

  /// `Invalid verification code`
  String get invalid_verification_code {
    return Intl.message(
      'Invalid verification code',
      name: 'invalid_verification_code',
      desc: '',
      args: [],
    );
  }

  /// `Invalid activation code`
  String get invalid_activation_code {
    return Intl.message(
      'Invalid activation code',
      name: 'invalid_activation_code',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get invalid_email {
    return Intl.message(
      'Invalid email',
      name: 'invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `Email already in use`
  String get email_already_in_use {
    return Intl.message(
      'Email already in use',
      name: 'email_already_in_use',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 10 characters long`
  String get password_too_short {
    return Intl.message(
      'Password must be at least 10 characters long',
      name: 'password_too_short',
      desc: '',
      args: [],
    );
  }

  /// `Please enter an email address.`
  String get validator_enter_email {
    return Intl.message(
      'Please enter an email address.',
      name: 'validator_enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address.`
  String get validator_enter_valid_email {
    return Intl.message(
      'Please enter a valid email address.',
      name: 'validator_enter_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid password.`
  String get validator_enter_valid_password {
    return Intl.message(
      'Please enter a valid password.',
      name: 'validator_enter_valid_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a password.`
  String get validator_enter_password {
    return Intl.message(
      'Please enter a password.',
      name: 'validator_enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 10 characters long.`
  String get validator_password_10_chars {
    return Intl.message(
      'Password must be at least 10 characters long.',
      name: 'validator_password_10_chars',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one number.`
  String get validator_password_num {
    return Intl.message(
      'Password must contain at least one number.',
      name: 'validator_password_num',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one lowercase letter.`
  String get validator_password_lower {
    return Intl.message(
      'Password must contain at least one lowercase letter.',
      name: 'validator_password_lower',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one uppercase letter.`
  String get validator_password_upper {
    return Intl.message(
      'Password must contain at least one uppercase letter.',
      name: 'validator_password_upper',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one special character.`
  String get validator_special_char {
    return Intl.message(
      'Password must contain at least one special character.',
      name: 'validator_special_char',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account?`
  String get are_you_sure_delete {
    return Intl.message(
      'Are you sure you want to delete your account?',
      name: 'are_you_sure_delete',
      desc: '',
      args: [],
    );
  }

  /// `All the data associated with your account will be deleted. This action cannot be undone.`
  String get account_will_delete {
    return Intl.message(
      'All the data associated with your account will be deleted. This action cannot be undone.',
      name: 'account_will_delete',
      desc: '',
      args: [],
    );
  }

  /// `Your account has been deleted successfully.`
  String get delete_success {
    return Intl.message(
      'Your account has been deleted successfully.',
      name: 'delete_success',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get delete_cancel {
    return Intl.message(
      'Cancel',
      name: 'delete_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete my account`
  String get delete_my_account {
    return Intl.message(
      'Delete my account',
      name: 'delete_my_account',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get delete_logout {
    return Intl.message(
      'Logout',
      name: 'delete_logout',
      desc: '',
      args: [],
    );
  }

  /// `Account deleted`
  String get account_deleted {
    return Intl.message(
      'Account deleted',
      name: 'account_deleted',
      desc: '',
      args: [],
    );
  }

  /// `Connect Device`
  String get connect_device {
    return Intl.message(
      'Connect Device',
      name: 'connect_device',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get delete_account {
    return Intl.message(
      'Delete Account',
      name: 'delete_account',
      desc: '',
      args: [],
    );
  }

  /// `Reset Code Resent`
  String get reset_code_resent {
    return Intl.message(
      'Reset Code Resent',
      name: 'reset_code_resent',
      desc: '',
      args: [],
    );
  }

  /// `If you are sure that you have an account with us and did not receive a code, please check your spam folder.`
  String get reset_code_resent_info {
    return Intl.message(
      'If you are sure that you have an account with us and did not receive a code, please check your spam folder.',
      name: 'reset_code_resent_info',
      desc: '',
      args: [],
    );
  }

  /// `I understand`
  String get i_understand {
    return Intl.message(
      'I understand',
      name: 'i_understand',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username_hint {
    return Intl.message(
      'Username',
      name: 'username_hint',
      desc: '',
      args: [],
    );
  }

  /// `Type your Username`
  String get username_label {
    return Intl.message(
      'Type your Username',
      name: 'username_label',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid username.`
  String get username_error {
    return Intl.message(
      'Please enter a valid username.',
      name: 'username_error',
      desc: '',
      args: [],
    );
  }

  /// `Email here`
  String get email_hint {
    return Intl.message(
      'Email here',
      name: 'email_hint',
      desc: '',
      args: [],
    );
  }

  /// `Type your email`
  String get email_label {
    return Intl.message(
      'Type your email',
      name: 'email_label',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signup_button {
    return Intl.message(
      'Sign Up',
      name: 'signup_button',
      desc: '',
      args: [],
    );
  }

  /// `Have an account?`
  String get existing_account {
    return Intl.message(
      'Have an account?',
      name: 'existing_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signin_text {
    return Intl.message(
      'Sign In',
      name: 'signin_text',
      desc: '',
      args: [],
    );
  }

  /// `Password here`
  String get password_hint {
    return Intl.message(
      'Password here',
      name: 'password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Type your password`
  String get password_label {
    return Intl.message(
      'Type your password',
      name: 'password_label',
      desc: '',
      args: [],
    );
  }

  /// `User already exists. (400)`
  String get user_exists_error {
    return Intl.message(
      'User already exists. (400)',
      name: 'user_exists_error',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email or password. (401)`
  String get invalid_email_or_password_error {
    return Intl.message(
      'Invalid email or password. (401)',
      name: 'invalid_email_or_password_error',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email or password. (422)`
  String get invalid_email_or_password_error_422 {
    return Intl.message(
      'Invalid email or password. (422)',
      name: 'invalid_email_or_password_error_422',
      desc: '',
      args: [],
    );
  }

  /// `Create account and enjoy services`
  String get create_account_text {
    return Intl.message(
      'Create account and enjoy services',
      name: 'create_account_text',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgot_password {
    return Intl.message(
      'Forgot Password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter Activation Code`
  String get enter_activation_code {
    return Intl.message(
      'Enter Activation Code',
      name: 'enter_activation_code',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back!`
  String get welcome_back {
    return Intl.message(
      'Welcome Back!',
      name: 'welcome_back',
      desc: '',
      args: [],
    );
  }

  /// `Sign In to your account`
  String get sign_in_prompt {
    return Intl.message(
      'Sign In to your account',
      name: 'sign_in_prompt',
      desc: '',
      args: [],
    );
  }

  /// `Don't have account?`
  String get no_account {
    return Intl.message(
      'Don\'t have account?',
      name: 'no_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signup_text {
    return Intl.message(
      'Sign Up',
      name: 'signup_text',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signin_button {
    return Intl.message(
      'Sign In',
      name: 'signin_button',
      desc: '',
      args: [],
    );
  }

  /// `Error during {operationType}: {error}`
  String error_operation(Object operationType, Object error) {
    return Intl.message(
      'Error during $operationType: $error',
      name: 'error_operation',
      desc: '',
      args: [operationType, error],
    );
  }

  /// `Verify Code`
  String get verify_code {
    return Intl.message(
      'Verify Code',
      name: 'verify_code',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the code we just sent to your email address`
  String get enter_code_text {
    return Intl.message(
      'Please enter the code we just sent to your email address',
      name: 'enter_code_text',
      desc: '',
      args: [],
    );
  }

  /// `Activate`
  String get activate_button {
    return Intl.message(
      'Activate',
      name: 'activate_button',
      desc: '',
      args: [],
    );
  }

  /// `Haven’t received a code?`
  String get no_code {
    return Intl.message(
      'Haven’t received a code?',
      name: 'no_code',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend_text {
    return Intl.message(
      'Resend',
      name: 'resend_text',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid 6 digit code`
  String get valid_code_error {
    return Intl.message(
      'Please enter a valid 6 digit code',
      name: 'valid_code_error',
      desc: '',
      args: [],
    );
  }

  /// `There was an error with the connection with the Moko device. - {mokoCode}`
  String device_error(Object mokoCode) {
    return Intl.message(
      'There was an error with the connection with the Moko device. - $mokoCode',
      name: 'device_error',
      desc: '',
      args: [mokoCode],
    );
  }

  /// `Idle`
  String get device_configuration_idle {
    return Intl.message(
      'Idle',
      name: 'device_configuration_idle',
      desc: '',
      args: [],
    );
  }

  /// `Getting Device information...`
  String get device_configuration_enquiry {
    return Intl.message(
      'Getting Device information...',
      name: 'device_configuration_enquiry',
      desc: '',
      args: [],
    );
  }

  /// `Configuring device to connect with the MQTT broker...`
  String get device_configuration_mqtt {
    return Intl.message(
      'Configuring device to connect with the MQTT broker...',
      name: 'device_configuration_mqtt',
      desc: '',
      args: [],
    );
  }

  /// `Authenticating with the MQTT broker...`
  String get device_configuration_authenticating {
    return Intl.message(
      'Authenticating with the MQTT broker...',
      name: 'device_configuration_authenticating',
      desc: '',
      args: [],
    );
  }

  /// `Setting up MQTT topics...`
  String get device_configuration_mqtt_topic {
    return Intl.message(
      'Setting up MQTT topics...',
      name: 'device_configuration_mqtt_topic',
      desc: '',
      args: [],
    );
  }

  /// `Configuring WiFi parameters...`
  String get device_configuration_wifi {
    return Intl.message(
      'Configuring WiFi parameters...',
      name: 'device_configuration_wifi',
      desc: '',
      args: [],
    );
  }

  /// `No Wifi devices`
  String get no_wifi_devices {
    return Intl.message(
      'No Wifi devices',
      name: 'no_wifi_devices',
      desc: '',
      args: [],
    );
  }

  /// `Connecting...`
  String get connecting {
    return Intl.message(
      'Connecting...',
      name: 'connecting',
      desc: '',
      args: [],
    );
  }

  /// `Connect to Device`
  String get connect_to_device {
    return Intl.message(
      'Connect to Device',
      name: 'connect_to_device',
      desc: '',
      args: [],
    );
  }

  /// `Press the power button to start the pairing mode.`
  String get press_power_button_text {
    return Intl.message(
      'Press the power button to start the pairing mode.',
      name: 'press_power_button_text',
      desc: '',
      args: [],
    );
  }

  /// `Connect`
  String get connect_button {
    return Intl.message(
      'Connect',
      name: 'connect_button',
      desc: '',
      args: [],
    );
  }

  /// `Error: {error}`
  String error_can_toString(Object error) {
    return Intl.message(
      'Error: $error',
      name: 'error_can_toString',
      desc: '',
      args: [error],
    );
  }

  /// `Location permission denied, please enable it in the settings.`
  String get location_permission_error {
    return Intl.message(
      'Location permission denied, please enable it in the settings.',
      name: 'location_permission_error',
      desc: '',
      args: [],
    );
  }

  /// `Location service disabled, please enable it in the settings.`
  String get location_service_error {
    return Intl.message(
      'Location service disabled, please enable it in the settings.',
      name: 'location_service_error',
      desc: '',
      args: [],
    );
  }

  /// `Failed to start scan`
  String get scan_start_error {
    return Intl.message(
      'Failed to start scan',
      name: 'scan_start_error',
      desc: '',
      args: [],
    );
  }

  /// `WiFi connection failed. Make sure the device is on and in pairing mode.`
  String get wifi_connection_error {
    return Intl.message(
      'WiFi connection failed. Make sure the device is on and in pairing mode.',
      name: 'wifi_connection_error',
      desc: '',
      args: [],
    );
  }

  /// `Device successfully configured. You can now use it.`
  String get device_configuration_success {
    return Intl.message(
      'Device successfully configured. You can now use it.',
      name: 'device_configuration_success',
      desc: '',
      args: [],
    );
  }

  /// `WiFi Parameters configuration failed: {error}`
  String wifi_parameters_configuration_error(Object error) {
    return Intl.message(
      'WiFi Parameters configuration failed: $error',
      name: 'wifi_parameters_configuration_error',
      desc: '',
      args: [error],
    );
  }

  /// `MQTT Parameters configuration failed: {error}`
  String mqtt_parameters_configuration_error(Object error) {
    return Intl.message(
      'MQTT Parameters configuration failed: $error',
      name: 'mqtt_parameters_configuration_error',
      desc: '',
      args: [error],
    );
  }

  /// `WiFi Setup`
  String get wifi_setup {
    return Intl.message(
      'WiFi Setup',
      name: 'wifi_setup',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save_button {
    return Intl.message(
      'Save',
      name: 'save_button',
      desc: '',
      args: [],
    );
  }

  /// `To connect to the Device, follow these steps: \n\n`
  String get connection_instructions {
    return Intl.message(
      'To connect to the Device, follow these steps: \n\n',
      name: 'connection_instructions',
      desc: '',
      args: [],
    );
  }

  /// `1. Make sure the device is blinking a yellow light - if not, press the power button until it starts flashing a yellow light.\n\n`
  String get connection_step1 {
    return Intl.message(
      '1. Make sure the device is blinking a yellow light - if not, press the power button until it starts flashing a yellow light.\n\n',
      name: 'connection_step1',
      desc: '',
      args: [],
    );
  }

  /// `2. Open the Wi-Fi settings on your device.\n\n`
  String get connection_step2 {
    return Intl.message(
      '2. Open the Wi-Fi settings on your device.\n\n',
      name: 'connection_step2',
      desc: '',
      args: [],
    );
  }

  /// `3. Connect to the network named "MK117-xxxx".\n   (Make sure your device is in the range of the network.)\n`
  String get connection_step3 {
    return Intl.message(
      '3. Connect to the network named "MK117-xxxx".\n   (Make sure your device is in the range of the network.)\n',
      name: 'connection_step3',
      desc: '',
      args: [],
    );
  }

  /// `4. When prompted, enter the password: .`
  String get connection_step4 {
    return Intl.message(
      '4. When prompted, enter the password: .',
      name: 'connection_step4',
      desc: '',
      args: [],
    );
  }

  /// `5. Once connected, return to this app and press `
  String get connection_step5 {
    return Intl.message(
      '5. Once connected, return to this app and press ',
      name: 'connection_step5',
      desc: '',
      args: [],
    );
  }

  /// `Connect`
  String get connect_text {
    return Intl.message(
      'Connect',
      name: 'connect_text',
      desc: '',
      args: [],
    );
  }

  /// `Open Settings Page`
  String get open_settings_button {
    return Intl.message(
      'Open Settings Page',
      name: 'open_settings_button',
      desc: '',
      args: [],
    );
  }

  /// `Network Name (SSID)`
  String get network_name_label {
    return Intl.message(
      'Network Name (SSID)',
      name: 'network_name_label',
      desc: '',
      args: [],
    );
  }

  /// `Welcome 👋`
  String get welcome_text {
    return Intl.message(
      'Welcome 👋',
      name: 'welcome_text',
      desc: '',
      args: [],
    );
  }

  /// `Let's manage your smart solar`
  String get app_introduction {
    return Intl.message(
      'Let\'s manage your smart solar',
      name: 'app_introduction',
      desc: '',
      args: [],
    );
  }

  /// `Energy Produced`
  String get energy_produced {
    return Intl.message(
      'Energy Produced',
      name: 'energy_produced',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get weekly_text {
    return Intl.message(
      'Weekly',
      name: 'weekly_text',
      desc: '',
      args: [],
    );
  }

  /// `Activation Code Resent!`
  String get activation_code_resent {
    return Intl.message(
      'Activation Code Resent!',
      name: 'activation_code_resent',
      desc: '',
      args: [],
    );
  }

  /// `Error sending Activation Code.`
  String get activation_code_send_error {
    return Intl.message(
      'Error sending Activation Code.',
      name: 'activation_code_send_error',
      desc: '',
      args: [],
    );
  }

  /// `Electricity\nCost`
  String get electricity_cost {
    return Intl.message(
      'Electricity\nCost',
      name: 'electricity_cost',
      desc: '',
      args: [],
    );
  }

  /// `This Week`
  String get this_week {
    return Intl.message(
      'This Week',
      name: 'this_week',
      desc: '',
      args: [],
    );
  }

  /// `This Month`
  String get this_month {
    return Intl.message(
      'This Month',
      name: 'this_month',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `This Year`
  String get this_year {
    return Intl.message(
      'This Year',
      name: 'this_year',
      desc: '',
      args: [],
    );
  }

  /// `Solar Energy Produced`
  String get solar_energy_produced {
    return Intl.message(
      'Solar Energy Produced',
      name: 'solar_energy_produced',
      desc: '',
      args: [],
    );
  }

  /// `Total Energy`
  String get total_energy {
    return Intl.message(
      'Total Energy',
      name: 'total_energy',
      desc: '',
      args: [],
    );
  }

  /// `Consumption`
  String get consumption {
    return Intl.message(
      'Consumption',
      name: 'consumption',
      desc: '',
      args: [],
    );
  }

  /// `Capacity`
  String get capacity {
    return Intl.message(
      'Capacity',
      name: 'capacity',
      desc: '',
      args: [],
    );
  }

  /// `CO2 Reduction`
  String get co2_reduction {
    return Intl.message(
      'CO2 Reduction',
      name: 'co2_reduction',
      desc: '',
      args: [],
    );
  }

  /// `Check your email for an activation code and type your new password here.`
  String get reset_password {
    return Intl.message(
      'Check your email for an activation code and type your new password here.',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Activation Code`
  String get activation_code_hint {
    return Intl.message(
      'Activation Code',
      name: 'activation_code_hint',
      desc: '',
      args: [],
    );
  }

  /// `Activation Code`
  String get activation_code_label {
    return Intl.message(
      'Activation Code',
      name: 'activation_code_label',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get new_password_hint {
    return Intl.message(
      'New Password',
      name: 'new_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get new_password_label {
    return Intl.message(
      'New Password',
      name: 'new_password_label',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirm_new_password_hint {
    return Intl.message(
      'Confirm New Password',
      name: 'confirm_new_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirm_new_password_label {
    return Intl.message(
      'Confirm New Password',
      name: 'confirm_new_password_label',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get password_mismatch_error {
    return Intl.message(
      'Passwords do not match',
      name: 'password_mismatch_error',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get reset_password_button {
    return Intl.message(
      'Reset Password',
      name: 'reset_password_button',
      desc: '',
      args: [],
    );
  }

  /// `Remember your password?`
  String get remember_password {
    return Intl.message(
      'Remember your password?',
      name: 'remember_password',
      desc: '',
      args: [],
    );
  }

  /// `Back to Login`
  String get back_to_login {
    return Intl.message(
      'Back to Login',
      name: 'back_to_login',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get see_all {
    return Intl.message(
      'See all',
      name: 'see_all',
      desc: '',
      args: [],
    );
  }

  /// `Total Production Per Day`
  String get total_production_per_day {
    return Intl.message(
      'Total Production Per Day',
      name: 'total_production_per_day',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Week`
  String get week {
    return Intl.message(
      'Week',
      name: 'week',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get year {
    return Intl.message(
      'Year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get day {
    return Intl.message(
      'Day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Production`
  String get production {
    return Intl.message(
      'Production',
      name: 'production',
      desc: '',
      args: [],
    );
  }

  /// `Read the Articles`
  String get articles_header {
    return Intl.message(
      'Read the Articles',
      name: 'articles_header',
      desc: '',
      args: [],
    );
  }

  /// `Password requirements:\n- Must be equal or longer than 10 characters\n- Must contain a number\n- Must contain a lowercase character\n- Must contain an uppercase character\n- Must contain a special character`
  String get password_requirements {
    return Intl.message(
      'Password requirements:\n- Must be equal or longer than 10 characters\n- Must contain a number\n- Must contain a lowercase character\n- Must contain an uppercase character\n- Must contain a special character',
      name: 'password_requirements',
      desc: '',
      args: [],
    );
  }

  /// `Error while loading articles. Try again later.`
  String get error_loading_articles {
    return Intl.message(
      'Error while loading articles. Try again later.',
      name: 'error_loading_articles',
      desc: '',
      args: [],
    );
  }

  /// `No articles found`
  String get no_articles {
    return Intl.message(
      'No articles found',
      name: 'no_articles',
      desc: '',
      args: [],
    );
  }

  /// `Articles`
  String get articles {
    return Intl.message(
      'Articles',
      name: 'articles',
      desc: '',
      args: [],
    );
  }

  /// `Open article in browser`
  String get open_article_in_browser {
    return Intl.message(
      'Open article in browser',
      name: 'open_article_in_browser',
      desc: '',
      args: [],
    );
  }

  /// `Send code`
  String get send_code {
    return Intl.message(
      'Send code',
      name: 'send_code',
      desc: '',
      args: [],
    );
  }

  /// `Provide your email`
  String get provide_email {
    return Intl.message(
      'Provide your email',
      name: 'provide_email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the email address associated with your account. We will send a password reset code to that email address, which you can use to reset your password securely.`
  String get provide_email_text {
    return Intl.message(
      'Please enter the email address associated with your account. We will send a password reset code to that email address, which you can use to reset your password securely.',
      name: 'provide_email_text',
      desc: '',
      args: [],
    );
  }

  String getByErrorType(String errorType, String errorMessage) {
    return Intl.message(
      errorMessage,
      name: errorType,
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Localized> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'pt'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Localized> load(Locale locale) => Localized.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
