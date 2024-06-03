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
        "account_deleted":
            MessageLookupByLibrary.simpleMessage("Compte supprimé"),
        "account_will_delete": MessageLookupByLibrary.simpleMessage(
            "Toutes les données associées à votre compte seront supprimées. Cette action est irreversible."),
        "activate_button": MessageLookupByLibrary.simpleMessage("Activer"),
        "activation_code_hint":
            MessageLookupByLibrary.simpleMessage("Code d\'activation"),
        "activation_code_label":
            MessageLookupByLibrary.simpleMessage("Code d\'activation"),
        "activation_code_resent":
            MessageLookupByLibrary.simpleMessage("Code d\'activation renvoyé!"),
        "activation_code_send_error": MessageLookupByLibrary.simpleMessage(
            "Erreur lors de la renvoi du code d\'activation."),
        "app_introduction": MessageLookupByLibrary.simpleMessage(
            "Gérons votre solaire intelligent"),
        "are_you_sure_delete": MessageLookupByLibrary.simpleMessage(
            "Êtes-vous sûr de vouloir supprimer votre compte ?"),
        "articles": MessageLookupByLibrary.simpleMessage("Articles"),
        "articles_header":
            MessageLookupByLibrary.simpleMessage("Lire les articles"),
        "back_to_login":
            MessageLookupByLibrary.simpleMessage("Retour à la connexion"),
        "capacity": MessageLookupByLibrary.simpleMessage("Capacité"),
        "co2_reduction": MessageLookupByLibrary.simpleMessage("CO2 Réduction"),
        "confirm_new_password_hint": MessageLookupByLibrary.simpleMessage(
            "Confirmer le nouveau mot de passe"),
        "confirm_new_password_label": MessageLookupByLibrary.simpleMessage(
            "Confirmer le nouveau mot de passe"),
        "connect_button": MessageLookupByLibrary.simpleMessage("Se connecter"),
        "connect_device":
            MessageLookupByLibrary.simpleMessage("Connecter un appareil"),
        "connect_text": MessageLookupByLibrary.simpleMessage("Connect"),
        "connect_to_device":
            MessageLookupByLibrary.simpleMessage("Connect to Device"),
        "connecting": MessageLookupByLibrary.simpleMessage("Connexion..."),
        "connection_instructions": MessageLookupByLibrary.simpleMessage(
            "Pour vous connecter à l\'appareil, suivez les étapes suivantes:\n\n"),
        "connection_step1": MessageLookupByLibrary.simpleMessage(
            "1. assurez-vous que l\'appareil fait clignoter une lumière jaune - si ce n\'est pas le cas, appuyez sur le bouton d\'alimentation jusqu\'à ce qu\'il commence à faire clignoter une lumière jaune.\n\n"),
        "connection_step2": MessageLookupByLibrary.simpleMessage(
            "2. ouvrez les paramètres Wi-Fi de votre appareil.\n\n"),
        "connection_step3": MessageLookupByLibrary.simpleMessage(
            "3. connectez-vous au réseau nommé \'MK117-xxxx\' (Assurez-vous que votre appareil est dans la portée du réseau.)\n\n"),
        "connection_step4": MessageLookupByLibrary.simpleMessage(
            "4. lorsque vous y êtes invité, entrez le mot de passe : "),
        "connection_step5": MessageLookupByLibrary.simpleMessage(
            "5. une fois connecté, revenez à cette application et appuyez sur "),
        "consumption": MessageLookupByLibrary.simpleMessage("Consommation"),
        "create_account_text": MessageLookupByLibrary.simpleMessage(
            "Créer un compte et profiter des services"),
        "day": MessageLookupByLibrary.simpleMessage("Jour"),
        "delete_account":
            MessageLookupByLibrary.simpleMessage("Supprimer le compte"),
        "delete_cancel": MessageLookupByLibrary.simpleMessage("Annuler"),
        "delete_logout": MessageLookupByLibrary.simpleMessage("Se déconnecter"),
        "delete_my_account":
            MessageLookupByLibrary.simpleMessage("Supprimer mon compte"),
        "delete_success": MessageLookupByLibrary.simpleMessage(
            "Votre compte a été supprimé avec succès."),
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
        "email_already_in_use":
            MessageLookupByLibrary.simpleMessage("Email déjà utilisé"),
        "email_hint":
            MessageLookupByLibrary.simpleMessage("Envoyez un courriel ici"),
        "email_label":
            MessageLookupByLibrary.simpleMessage("Tapez votre email"),
        "empty_password_error": MessageLookupByLibrary.simpleMessage(
            "Veuillez entrer le mot de passe"),
        "empty_ssid_error": MessageLookupByLibrary.simpleMessage(
            "Veuillez entrer le nom du réseau"),
        "energy_produced":
            MessageLookupByLibrary.simpleMessage("Énergie produite"),
        "enter_activation_code": MessageLookupByLibrary.simpleMessage(
            "Saisir le code d\'activation"),
        "enter_code_text": MessageLookupByLibrary.simpleMessage(
            "Veuillez saisir le code que nous venons de vous envoyer à votre adresse électronique"),
        "error_can_toString": m1,
        "error_loading_articles": MessageLookupByLibrary.simpleMessage(
            "Erreur lors du chargement des articles. Réessayez plus tard."),
        "error_operation": m2,
        "forgot_password":
            MessageLookupByLibrary.simpleMessage("Mot de passe oublié"),
        "i_understand": MessageLookupByLibrary.simpleMessage("Je comprends"),
        "invalid_activation_code":
            MessageLookupByLibrary.simpleMessage("Code d\'activation invalide"),
        "invalid_email": MessageLookupByLibrary.simpleMessage("Email invalide"),
        "invalid_email_or_password_error": MessageLookupByLibrary.simpleMessage(
            "Courriel ou mot de passe non valide. (401)"),
        "invalid_email_or_password_error_422":
            MessageLookupByLibrary.simpleMessage(
                "Courriel ou mot de passe non valide. (422)"),
        "invalid_verification_code": MessageLookupByLibrary.simpleMessage(
            "Code de vérification invalide"),
        "location_permission_error": MessageLookupByLibrary.simpleMessage(
            "Permission de localisation refusée, veuillez l\'activer dans les paramètres"),
        "location_service_error": MessageLookupByLibrary.simpleMessage(
            "Service de localisation désactivé, veuillez l\'activer dans les paramètres"),
        "month": MessageLookupByLibrary.simpleMessage("Mois"),
        "mqtt_parameters_configuration_error": m3,
        "network_name_label":
            MessageLookupByLibrary.simpleMessage("Nom du réseau (SSID)"),
        "new_password_hint":
            MessageLookupByLibrary.simpleMessage("Nouveau mot de passe"),
        "new_password_label":
            MessageLookupByLibrary.simpleMessage("Nouveau mot de passe"),
        "no_account": MessageLookupByLibrary.simpleMessage(
            "Vous n\'avez pas de compte ?"),
        "no_articles":
            MessageLookupByLibrary.simpleMessage("Aucun article trouvé."),
        "no_code": MessageLookupByLibrary.simpleMessage(
            "Vous n\'avez pas reçu de code ?"),
        "no_wifi_devices":
            MessageLookupByLibrary.simpleMessage("Aucun appareil Wifi"),
        "open_article_in_browser": MessageLookupByLibrary.simpleMessage(
            "Ouvrir l\'article dans le navigateur"),
        "open_settings_button": MessageLookupByLibrary.simpleMessage(
            "Ouvrir la page des paramètres"),
        "password_hint":
            MessageLookupByLibrary.simpleMessage("Mot de passe ici"),
        "password_label":
            MessageLookupByLibrary.simpleMessage("Tapez votre mot de passe"),
        "password_mismatch_error": MessageLookupByLibrary.simpleMessage(
            "Les mots de passe ne correspondent pas"),
        "password_requirements": MessageLookupByLibrary.simpleMessage(
            "Exigences de mot de passe :\n- Doit être égal ou supérieur à 10 caractères\n- Doit contenir un chiffre\n- Doit contenir un caractère minuscule\n- Doit contenir un caractère majuscule\n- Doit contenir un caractère spécial"),
        "password_too_short": MessageLookupByLibrary.simpleMessage(
            "Le mot de passe doit comporter au moins 10 caractères"),
        "password_too_weak": MessageLookupByLibrary.simpleMessage(
            "Le mot de passe doit contenir au moins une lettre majuscule, une lettre minuscule, un caractère spécial et un chiffre"),
        "press_power_button_text": MessageLookupByLibrary.simpleMessage(
            "Appuyer sur le bouton d\'alimentation pour lancer le mode d\'appairage"),
        "production": MessageLookupByLibrary.simpleMessage("Production"),
        "provide_email": MessageLookupByLibrary.simpleMessage(
            "Indiquez votre adresse électronique"),
        "provide_email_text": MessageLookupByLibrary.simpleMessage(
            "Saisissez l\'adresse électronique associée à votre compte. Nous vous enverrons un code de récupération de mots-clés pour votre adresse e-mail, que vous pourrez utiliser pour récupérer vos mots-clés en toute sécurité."),
        "remember_password": MessageLookupByLibrary.simpleMessage(
            "Vous souvenez-vous de votre mot de passe ?"),
        "resend_text": MessageLookupByLibrary.simpleMessage("Renvoyer"),
        "reset_code_resent": MessageLookupByLibrary.simpleMessage(
            "Code de réinitialisation renvoyé"),
        "reset_code_resent_info": MessageLookupByLibrary.simpleMessage(
            "Si vous êtes sûr d\'avoir un compte chez nous et que vous n\'avez pas reçu de code, veuillez vérifier votre dossier de courriers indésirables."),
        "reset_password": MessageLookupByLibrary.simpleMessage(
            "Vérifiez votre e-mail pour obtenir un code d\'activation et saisissez votre nouveau mot de passe ici."),
        "reset_password_button": MessageLookupByLibrary.simpleMessage(
            "Réinitialiser le mot de passe"),
        "save_button": MessageLookupByLibrary.simpleMessage("Save"),
        "scan_start_error": MessageLookupByLibrary.simpleMessage(
            "Échec du démarrage de l\'analyse"),
        "see_all": MessageLookupByLibrary.simpleMessage("Voir tout"),
        "send_code": MessageLookupByLibrary.simpleMessage("Envoyer le code"),
        "settings": MessageLookupByLibrary.simpleMessage("Paramètres"),
        "sign_in_prompt":
            MessageLookupByLibrary.simpleMessage("Se connecter à votre compte"),
        "signin_button": MessageLookupByLibrary.simpleMessage("S\'identifier"),
        "signin_text": MessageLookupByLibrary.simpleMessage("S\'identifier"),
        "signup_button": MessageLookupByLibrary.simpleMessage("S\'inscrire"),
        "signup_text": MessageLookupByLibrary.simpleMessage("S\'inscrire"),
        "solar_energy_produced":
            MessageLookupByLibrary.simpleMessage("Énergie solaire produite"),
        "this_month": MessageLookupByLibrary.simpleMessage("Ce mois-ci"),
        "this_week": MessageLookupByLibrary.simpleMessage("Cette semaine"),
        "this_year": MessageLookupByLibrary.simpleMessage("Cette année"),
        "today": MessageLookupByLibrary.simpleMessage("Aujourd\'hui"),
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
        "validator_enter_email": MessageLookupByLibrary.simpleMessage(
            "Veuillez saisir une adresse email."),
        "validator_enter_password": MessageLookupByLibrary.simpleMessage(
            "Veuillez saisir un mot de passe."),
        "validator_enter_valid_email": MessageLookupByLibrary.simpleMessage(
            "Veuillez saisir une adresse email valide."),
        "validator_enter_valid_password": MessageLookupByLibrary.simpleMessage(
            "Veuillez saisir un mot de passe valide."),
        "validator_password_10_chars": MessageLookupByLibrary.simpleMessage(
            "Le mot de passe doit comporter au moins 10 caractères."),
        "validator_password_lower": MessageLookupByLibrary.simpleMessage(
            "Le mot de passe doit contenir au moins une lettre minuscule."),
        "validator_password_num": MessageLookupByLibrary.simpleMessage(
            "Le mot de passe doit contenir au moins un chiffre."),
        "validator_password_upper": MessageLookupByLibrary.simpleMessage(
            "Le mot de passe doit contenir au moins une lettre majuscule."),
        "validator_special_char": MessageLookupByLibrary.simpleMessage(
            "Le mot de passe doit contenir au moins un caractère spécial."),
        "verify_code": MessageLookupByLibrary.simpleMessage("Vérifier le code"),
        "week": MessageLookupByLibrary.simpleMessage("Semaine"),
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
