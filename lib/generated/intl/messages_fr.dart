// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static String m0(mokoCode) =>
      "Une erreur s\'est produite lors de la connexion avec l\'appareil Moko. - ${mokoCode}";

  static String m1(error) => "Erreur : ${error}";

  static String m2(operationType, error) =>
      "Erreur pendant ${operationType} : ${error}";

  static String m3(error) =>
      "Échec de la configuration des paramètres MQTT : ${error}";

  static String m4(error) =>
      "La configuration des paramètres WiFi a échoué : ${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "activate_button": MessageLookupByLibrary.simpleMessage("Activer"),
        "app_introduction": MessageLookupByLibrary.simpleMessage(
            "Gérons votre solaire intelligent"),
        "capacity": MessageLookupByLibrary.simpleMessage("Capacité"),
        "co2_reduction":
            MessageLookupByLibrary.simpleMessage("Réduction de CO2"),
        "connect_button": MessageLookupByLibrary.simpleMessage("Se connecter"),
        "connect_text": MessageLookupByLibrary.simpleMessage("Connect"),
        "connect_to_device":
            MessageLookupByLibrary.simpleMessage("Connect to Device"),
        "connecting": MessageLookupByLibrary.simpleMessage("Connexion..."),
        "connection_instructions": MessageLookupByLibrary.simpleMessage(
            "Pour vous connecter à l\'appareil, suivez les étapes suivantes:\n"),
        "connection_step1": MessageLookupByLibrary.simpleMessage(
            "1. assurez-vous que l\'appareil fait clignoter une lumière jaune - si ce n\'est pas le cas, appuyez sur le bouton d\'alimentation jusqu\'à ce qu\'il commence à faire clignoter une lumière jaune.\n"),
        "connection_step2": MessageLookupByLibrary.simpleMessage(
            "2. ouvrez les paramètres Wi-Fi de votre appareil.\n"),
        "connection_step3": MessageLookupByLibrary.simpleMessage(
            "3. connectez-vous au réseau nommé \'MK117-xxxx\'.\n- (Assurez-vous que votre appareil est dans la portée du réseau.)\n"),
        "connection_step4": MessageLookupByLibrary.simpleMessage(
            "4. lorsque vous y êtes invité, entrez le mot de passe : .\n"),
        "connection_step5": MessageLookupByLibrary.simpleMessage(
            "5. une fois connecté, revenez à cette application et appuyez sur "),
        "consumption": MessageLookupByLibrary.simpleMessage("Consommation"),
        "create_account_text": MessageLookupByLibrary.simpleMessage(
            "Créer un compte et profiter des services"),
        "day": MessageLookupByLibrary.simpleMessage("Jour"),
        "device_configuration_authenticating":
            MessageLookupByLibrary.simpleMessage(
                "Authentification auprès du courtier MQTT..."),
        "device_configuration_enquiry": MessageLookupByLibrary.simpleMessage(
            "Obtenir des informations sur l\'appareil..."),
        "device_configuration_idle":
            MessageLookupByLibrary.simpleMessage("Idle"),
        "device_configuration_mqtt": MessageLookupByLibrary.simpleMessage(
            "Configurer l\'appareil pour qu\'il se connecte au courtier MQTT..."),
        "device_configuration_mqtt_topic": MessageLookupByLibrary.simpleMessage(
            "Configuration des sujets MQTT..."),
        "device_configuration_success": MessageLookupByLibrary.simpleMessage(
            "L\'appareil a été configuré avec succès. Vous pouvez maintenant l\'utiliser"),
        "device_configuration_wifi": MessageLookupByLibrary.simpleMessage(
            "Configuration des paramètres WiFi..."),
        "device_error": m0,
        "electricity_cost":
            MessageLookupByLibrary.simpleMessage("Coût de l\'électricité"),
        "email_hint":
            MessageLookupByLibrary.simpleMessage("Envoyez un courriel ici"),
        "email_label":
            MessageLookupByLibrary.simpleMessage("Tapez votre email"),
        "energy_produced":
            MessageLookupByLibrary.simpleMessage("Énergie produite"),
        "enter_activation_code": MessageLookupByLibrary.simpleMessage(
            "Saisir le code d\'activation"),
        "enter_code_text": MessageLookupByLibrary.simpleMessage(
            "Veuillez saisir le code que nous venons de vous envoyer à votre adresse électronique"),
        "error_can_toString": m1,
        "error_operation": m2,
        "invalid_email_or_password_error": MessageLookupByLibrary.simpleMessage(
            "Courriel ou mot de passe non valide. (401)"),
        "invalid_email_or_password_error_422":
            MessageLookupByLibrary.simpleMessage(
                "Courriel ou mot de passe non valide. (422)"),
        "location_permission_error": MessageLookupByLibrary.simpleMessage(
            "Permission de localisation refusée, veuillez l\'activer dans les paramètres"),
        "location_service_error": MessageLookupByLibrary.simpleMessage(
            "Service de localisation désactivé, veuillez l\'activer dans les paramètres"),
        "month": MessageLookupByLibrary.simpleMessage("Mois"),
        "mqtt_parameters_configuration_error": m3,
        "network_name_label":
            MessageLookupByLibrary.simpleMessage("Nom du réseau (SSID)"),
        "no_account": MessageLookupByLibrary.simpleMessage(
            "Vous n\'avez pas de compte ?"),
        "no_code": MessageLookupByLibrary.simpleMessage(
            "Vous n\'avez pas reçu de code ?"),
        "no_wifi_devices":
            MessageLookupByLibrary.simpleMessage("Aucun appareil Wifi"),
        "open_settings_button": MessageLookupByLibrary.simpleMessage(
            "Ouvrir la page des paramètres"),
        "password_hint":
            MessageLookupByLibrary.simpleMessage("Mot de passe ici"),
        "password_label":
            MessageLookupByLibrary.simpleMessage("Tapez votre mot de passe"),
        "press_power_button_text": MessageLookupByLibrary.simpleMessage(
            "Appuyer sur le bouton d\'alimentation pour lancer le mode d\'appairage"),
        "resend_text": MessageLookupByLibrary.simpleMessage("Renvoyer"),
        "save_button": MessageLookupByLibrary.simpleMessage("Save"),
        "scan_start_error": MessageLookupByLibrary.simpleMessage(
            "Échec du démarrage de l\'analyse"),
        "sign_in_prompt":
            MessageLookupByLibrary.simpleMessage("Se connecter à votre compte"),
        "signin_button": MessageLookupByLibrary.simpleMessage("S\'identifier"),
        "signin_text": MessageLookupByLibrary.simpleMessage("S\'identifier"),
        "signup_button": MessageLookupByLibrary.simpleMessage("S\'inscrire"),
        "signup_text": MessageLookupByLibrary.simpleMessage("S\'inscrire"),
        "solar_energy_produced":
            MessageLookupByLibrary.simpleMessage("Énergie solaire produite"),
        "this_week": MessageLookupByLibrary.simpleMessage("Cette semaine"),
        "total_energy": MessageLookupByLibrary.simpleMessage("Énergie totale"),
        "total_production_per_day":
            MessageLookupByLibrary.simpleMessage("Production totale par jour"),
        "user_exists_error": MessageLookupByLibrary.simpleMessage(
            "L\'utilisateur existe déjà. (400)"),
        "username_error": MessageLookupByLibrary.simpleMessage(
            "Veuillez saisir un nom d\'utilisateur valide"),
        "username_hint":
            MessageLookupByLibrary.simpleMessage("Nom d\'utilisateur"),
        "username_label": MessageLookupByLibrary.simpleMessage(
            "Tapez votre nom d\'utilisateur"),
        "valid_code_error": MessageLookupByLibrary.simpleMessage(
            "Veuillez saisir un code valide à 6 chiffres"),
        "verify_code": MessageLookupByLibrary.simpleMessage("Vérifier le code"),
        "weekly_text": MessageLookupByLibrary.simpleMessage("Hebdomadaire"),
        "welcome_back":
            MessageLookupByLibrary.simpleMessage("Bienvenue à nouveau !"),
        "welcome_text": MessageLookupByLibrary.simpleMessage("Bonjour 👋"),
        "wifi_connection_error": MessageLookupByLibrary.simpleMessage(
            "Échec de la connexion WiFi. Assurez-vous que l\'appareil est allumé et en mode d\'appairage"),
        "wifi_parameters_configuration_error": m4,
        "wifi_setup": MessageLookupByLibrary.simpleMessage("WiFi Setup"),
        "year": MessageLookupByLibrary.simpleMessage("Année")
      };
}
