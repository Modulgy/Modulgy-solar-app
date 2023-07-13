// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(mokoCode) =>
      "There was an error with the connection with the Moko device. - ${mokoCode}";

  static String m1(error) => "Error: ${error}";

  static String m2(operationType, error) =>
      "Error during ${operationType}: ${error}";

  static String m3(error) => "MQTT Parameters configuration failed: ${error}";

  static String m4(error) => "WiFi Parameters configuration failed: ${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "activate_button": MessageLookupByLibrary.simpleMessage("Activate"),
        "activation_code_hint":
            MessageLookupByLibrary.simpleMessage("Activation Code"),
        "activation_code_label":
            MessageLookupByLibrary.simpleMessage("Activation Code"),
        "activation_code_resent":
            MessageLookupByLibrary.simpleMessage("Activation Code Resent!"),
        "activation_code_send_error": MessageLookupByLibrary.simpleMessage(
            "Error sending Activation Code."),
        "app_introduction": MessageLookupByLibrary.simpleMessage(
            "Let\'s manage your smart solar"),
        "articles_header":
            MessageLookupByLibrary.simpleMessage("Read the Articles"),
        "back_to_login": MessageLookupByLibrary.simpleMessage("Back to Login"),
        "capacity": MessageLookupByLibrary.simpleMessage("Capacity"),
        "co2_reduction": MessageLookupByLibrary.simpleMessage("CO2 Reduction"),
        "confirm_new_password_hint":
            MessageLookupByLibrary.simpleMessage("Confirm New Password"),
        "confirm_new_password_label":
            MessageLookupByLibrary.simpleMessage("Confirm New Password"),
        "connect_button": MessageLookupByLibrary.simpleMessage("Connect"),
        "connect_text": MessageLookupByLibrary.simpleMessage("Connect"),
        "connect_to_device":
            MessageLookupByLibrary.simpleMessage("Connect to Device"),
        "connecting": MessageLookupByLibrary.simpleMessage("Connecting..."),
        "connection_instructions": MessageLookupByLibrary.simpleMessage(
            "To connect to the Device, follow these steps: \n\n"),
        "connection_step1": MessageLookupByLibrary.simpleMessage(
            "1. Make sure the device is blinking a yellow light - if not, press the power button until it starts flashing a yellow light.\n\n"),
        "connection_step2": MessageLookupByLibrary.simpleMessage(
            "2. Open the Wi-Fi settings on your device.\n\n"),
        "connection_step3": MessageLookupByLibrary.simpleMessage(
            "3. Connect to the network named \"MK117-xxxx\".\n   (Make sure your device is in the range of the network.)\n"),
        "connection_step4": MessageLookupByLibrary.simpleMessage(
            "4. When prompted, enter the password: ."),
        "connection_step5": MessageLookupByLibrary.simpleMessage(
            "5. Once connected, return to this app and press "),
        "consumption": MessageLookupByLibrary.simpleMessage("Consumption"),
        "create_account_text": MessageLookupByLibrary.simpleMessage(
            "Create account and enjoy services"),
        "day": MessageLookupByLibrary.simpleMessage("Day"),
        "device_configuration_authenticating":
            MessageLookupByLibrary.simpleMessage(
                "Authenticating with the MQTT broker..."),
        "device_configuration_enquiry": MessageLookupByLibrary.simpleMessage(
            "Getting Device information..."),
        "device_configuration_idle":
            MessageLookupByLibrary.simpleMessage("Idle"),
        "device_configuration_mqtt": MessageLookupByLibrary.simpleMessage(
            "Configuring device to connect with the MQTT broker..."),
        "device_configuration_mqtt_topic":
            MessageLookupByLibrary.simpleMessage("Setting up MQTT topics..."),
        "device_configuration_success": MessageLookupByLibrary.simpleMessage(
            "Device successfully configured. You can now use it."),
        "device_configuration_wifi": MessageLookupByLibrary.simpleMessage(
            "Configuring WiFi parameters..."),
        "device_error": m0,
        "electricity_cost":
            MessageLookupByLibrary.simpleMessage("Electricity\nCost"),
        "email_hint": MessageLookupByLibrary.simpleMessage("Email here"),
        "email_label": MessageLookupByLibrary.simpleMessage("Type your email"),
        "energy_produced":
            MessageLookupByLibrary.simpleMessage("Energy Produced"),
        "enter_activation_code":
            MessageLookupByLibrary.simpleMessage("Enter Activation Code"),
        "enter_code_text": MessageLookupByLibrary.simpleMessage(
            "Please enter the code we just sent to your email address"),
        "error_can_toString": m1,
        "error_operation": m2,
        "existing_account":
            MessageLookupByLibrary.simpleMessage("Have an account?"),
        "forgot_password":
            MessageLookupByLibrary.simpleMessage("Forgot Password?"),
        "invalid_email_or_password_error": MessageLookupByLibrary.simpleMessage(
            "Invalid email or password. (401)"),
        "invalid_email_or_password_error_422":
            MessageLookupByLibrary.simpleMessage(
                "Invalid email or password. (422)"),
        "location_permission_error": MessageLookupByLibrary.simpleMessage(
            "Location permission denied, please enable it in the settings."),
        "location_service_error": MessageLookupByLibrary.simpleMessage(
            "Location service disabled, please enable it in the settings."),
        "month": MessageLookupByLibrary.simpleMessage("Month"),
        "mqtt_parameters_configuration_error": m3,
        "network_name_label":
            MessageLookupByLibrary.simpleMessage("Network Name (SSID)"),
        "new_password_hint":
            MessageLookupByLibrary.simpleMessage("New Password"),
        "new_password_label":
            MessageLookupByLibrary.simpleMessage("New Password"),
        "no_account":
            MessageLookupByLibrary.simpleMessage("Don\'t have account?"),
        "no_code":
            MessageLookupByLibrary.simpleMessage("Haven’t received a code?"),
        "no_wifi_devices":
            MessageLookupByLibrary.simpleMessage("No Wifi devices"),
        "open_settings_button":
            MessageLookupByLibrary.simpleMessage("Open Settings Page"),
        "password_hint": MessageLookupByLibrary.simpleMessage("Password here"),
        "password_label":
            MessageLookupByLibrary.simpleMessage("Type your password"),
        "password_mismatch_error":
            MessageLookupByLibrary.simpleMessage("Passwords do not match"),
        "password_requirements": MessageLookupByLibrary.simpleMessage(
            "Password requirements:\n- Must be equal or longer than 10 characters\n- Must contain a number\n- Must contain an uppercase character"),
        "press_power_button_text": MessageLookupByLibrary.simpleMessage(
            "Press the power button to start the pairing mode."),
        "production": MessageLookupByLibrary.simpleMessage("Production"),
        "remember_password":
            MessageLookupByLibrary.simpleMessage("Remember your password?"),
        "resend_text": MessageLookupByLibrary.simpleMessage("Resend"),
        "reset_password": MessageLookupByLibrary.simpleMessage(
            "Check your email for an activation code and type your new password here."),
        "reset_password_button":
            MessageLookupByLibrary.simpleMessage("Reset Password"),
        "save_button": MessageLookupByLibrary.simpleMessage("Save"),
        "scan_start_error":
            MessageLookupByLibrary.simpleMessage("Failed to start scan"),
        "sign_in_prompt":
            MessageLookupByLibrary.simpleMessage("Sign In to your account"),
        "signin_button": MessageLookupByLibrary.simpleMessage("Sign In"),
        "signin_text": MessageLookupByLibrary.simpleMessage("Sign In"),
        "signup_button": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "signup_text": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "solar_energy_produced":
            MessageLookupByLibrary.simpleMessage("Solar Energy Produced"),
        "this_month": MessageLookupByLibrary.simpleMessage("This Month"),
        "this_week": MessageLookupByLibrary.simpleMessage("This Week"),
        "this_year": MessageLookupByLibrary.simpleMessage("This Year"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "total_energy": MessageLookupByLibrary.simpleMessage("Total Energy"),
        "total_production_per_day":
            MessageLookupByLibrary.simpleMessage("Total Production Per Day"),
        "user_exists_error":
            MessageLookupByLibrary.simpleMessage("User already exists. (400)"),
        "username_error": MessageLookupByLibrary.simpleMessage(
            "Please enter a valid username."),
        "username_hint": MessageLookupByLibrary.simpleMessage("Username"),
        "username_label":
            MessageLookupByLibrary.simpleMessage("Type your Username"),
        "valid_code_error": MessageLookupByLibrary.simpleMessage(
            "Please enter a valid 6 digit code"),
        "verify_code": MessageLookupByLibrary.simpleMessage("Verify Code"),
        "week": MessageLookupByLibrary.simpleMessage("Week"),
        "weekly_text": MessageLookupByLibrary.simpleMessage("Weekly"),
        "welcome_back": MessageLookupByLibrary.simpleMessage("Welcome Back!"),
        "welcome_text": MessageLookupByLibrary.simpleMessage("Welcome 👋"),
        "wifi_connection_error": MessageLookupByLibrary.simpleMessage(
            "WiFi connection failed. Make sure the device is on and in pairing mode."),
        "wifi_parameters_configuration_error": m4,
        "wifi_setup": MessageLookupByLibrary.simpleMessage("WiFi Setup"),
        "year": MessageLookupByLibrary.simpleMessage("Year")
      };
}
