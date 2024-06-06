// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
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
  String get localeName => 'pt';

  static String m0(mokoCode) =>
      "Ocorreu um erro na ligação com o dispositivo Moko. - ${mokoCode}";

  static String m1(error) => "Erro: ${error}";

  static String m2(operationType, error) =>
      "Erro durante ${operationType}: ${error}";

  static String m3(error) =>
      "Falha na configuração dos parâmetros MQTT: ${error}";

  static String m4(error) =>
      "Falha na configuração dos parâmetros WiFi: ${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "account_deleted":
            MessageLookupByLibrary.simpleMessage("Conta excluída"),
        "account_will_delete": MessageLookupByLibrary.simpleMessage(
            "Todos os dados associados à sua conta serão excluídos. Esta ação não pode ser desfeita."),
        "activate_button": MessageLookupByLibrary.simpleMessage("Ativar"),
        "activation_code_hint":
            MessageLookupByLibrary.simpleMessage("Código de ativação"),
        "activation_code_label":
            MessageLookupByLibrary.simpleMessage("Código de ativação"),
        "activation_code_resent": MessageLookupByLibrary.simpleMessage(
            "Código de ativação reenviado!"),
        "activation_code_send_error": MessageLookupByLibrary.simpleMessage(
            "Erro ao reenviar o código de ativação."),
        "app_introduction": MessageLookupByLibrary.simpleMessage(
            "Vamos gerir a sua energia solar"),
        "are_you_sure_delete": MessageLookupByLibrary.simpleMessage(
            "Tem certeza de que deseja excluir sua conta?"),
        "articles": MessageLookupByLibrary.simpleMessage("Artigos"),
        "articles_header":
            MessageLookupByLibrary.simpleMessage("Ler os artigos"),
        "back_to_login":
            MessageLookupByLibrary.simpleMessage("Voltar para login"),
        "capacity": MessageLookupByLibrary.simpleMessage("Capacidade"),
        "co2_reduction": MessageLookupByLibrary.simpleMessage("Redução CO2"),
        "confirm_new_password_hint":
            MessageLookupByLibrary.simpleMessage("Confirmar nova senha"),
        "confirm_new_password_label":
            MessageLookupByLibrary.simpleMessage("Confirmar nova senha"),
        "connect_button": MessageLookupByLibrary.simpleMessage("Ligar"),
        "connect_device":
            MessageLookupByLibrary.simpleMessage("Conectar dispositivo"),
        "connect_text": MessageLookupByLibrary.simpleMessage("Ligar"),
        "connect_to_device":
            MessageLookupByLibrary.simpleMessage("Ligar ao dispositivo"),
        "connecting": MessageLookupByLibrary.simpleMessage("A ligar..."),
        "connection_instructions": MessageLookupByLibrary.simpleMessage(
            "Para ligar ao Dispositivo, siga estes passos:\n\n"),
        "connection_step1": MessageLookupByLibrary.simpleMessage(
            "1. Certifique-se de que o dispositivo está a piscar uma luz amarela - se não estiver, prima o botão de alimentação até começar a piscar uma luz amarela.\n\n"),
        "connection_step2": MessageLookupByLibrary.simpleMessage(
            "2. abra as definições de Wi-Fi no seu dispositivo.\n\n"),
        "connection_step3": MessageLookupByLibrary.simpleMessage(
            "3. Ligue-se à rede denominada \"MK117-xxxx\".\n (Certifique-se de que o seu dispositivo está dentro do alcance da rede.)\n\n"),
        "connection_step4": MessageLookupByLibrary.simpleMessage(
            "4. Quando solicitado, introduza a palavra-passe: "),
        "connection_step5": MessageLookupByLibrary.simpleMessage(
            "5. Uma vez ligado, regresse a esta aplicação e prima "),
        "consumption": MessageLookupByLibrary.simpleMessage("Consumo"),
        "create_account_text": MessageLookupByLibrary.simpleMessage(
            "Criar conta e usufruir dos serviços"),
        "day": MessageLookupByLibrary.simpleMessage("Dia"),
        "delete_account": MessageLookupByLibrary.simpleMessage("Excluir conta"),
        "delete_cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "delete_logout": MessageLookupByLibrary.simpleMessage("Sair"),
        "delete_my_account":
            MessageLookupByLibrary.simpleMessage("Excluir minha conta"),
        "delete_success": MessageLookupByLibrary.simpleMessage(
            "Sua conta foi excluída com sucesso."),
        "device_configuration_authenticating":
            MessageLookupByLibrary.simpleMessage(
                "Autenticação com o corretor MQTT..."),
        "device_configuration_enquiry": MessageLookupByLibrary.simpleMessage(
            "Obter informações sobre o dispositivo..."),
        "device_configuration_idle":
            MessageLookupByLibrary.simpleMessage("Inativo"),
        "device_configuration_mqtt": MessageLookupByLibrary.simpleMessage(
            "Configurar o dispositivo para estabelecer ligação ao corretor MQTT..."),
        "device_configuration_mqtt_topic": MessageLookupByLibrary.simpleMessage(
            "Configuração de tópicos MQTT..."),
        "device_configuration_success": MessageLookupByLibrary.simpleMessage(
            "Dispositivo configurado com êxito. Já o pode utilizar."),
        "device_configuration_wifi": MessageLookupByLibrary.simpleMessage(
            "Configurar parâmetros WiFi..."),
        "device_error": m0,
        "electricity_cost":
            MessageLookupByLibrary.simpleMessage("Eletricidade\nCusto"),
        "email_already_in_use":
            MessageLookupByLibrary.simpleMessage("E-mail já está em uso"),
        "email_hint":
            MessageLookupByLibrary.simpleMessage("Envie um e-mail aqui"),
        "email_label":
            MessageLookupByLibrary.simpleMessage("Introduza o seu e-mail"),
        "empty_password_error": MessageLookupByLibrary.simpleMessage(
            "Por favor, insira a palavra-passe"),
        "empty_ssid_error": MessageLookupByLibrary.simpleMessage(
            "Por favor, insira o nome da rede"),
        "energy_produced":
            MessageLookupByLibrary.simpleMessage("Energia Produzida"),
        "enter_activation_code": MessageLookupByLibrary.simpleMessage(
            "Introduzir código de ativação"),
        "enter_code_text": MessageLookupByLibrary.simpleMessage(
            "Introduza o código que acabámos de enviar para o seu endereço de correio eletrónico"),
        "error_can_toString": m1,
        "error_loading_articles": MessageLookupByLibrary.simpleMessage(
            "Erro ao carregar artigos. Tente novamente mais tarde."),
        "error_operation": m2,
        "existing_account":
            MessageLookupByLibrary.simpleMessage("Tem uma conta?"),
        "failed_to_load_devices": MessageLookupByLibrary.simpleMessage(
            "Falha ao carregar dispositivos"),
        "forgot_password": MessageLookupByLibrary.simpleMessage(
            "Esqueceu-se da palavra-passe?"),
        "i_understand": MessageLookupByLibrary.simpleMessage("Eu entendo"),
        "invalid_activation_code":
            MessageLookupByLibrary.simpleMessage("Código de ativação inválido"),
        "invalid_email":
            MessageLookupByLibrary.simpleMessage("E-mail inválido"),
        "invalid_email_or_password_error": MessageLookupByLibrary.simpleMessage(
            "E-mail ou palavra-passe inválidos. (401)"),
        "invalid_email_or_password_error_422":
            MessageLookupByLibrary.simpleMessage(
                "E-mail ou palavra-passe inválidos. (422)"),
        "invalid_verification_code": MessageLookupByLibrary.simpleMessage(
            "Código de verificação inválido"),
        "location_permission_error": MessageLookupByLibrary.simpleMessage(
            "Permissão de localização negada, active-a nas definições"),
        "location_service_error": MessageLookupByLibrary.simpleMessage(
            "Serviço de localização desativado, active-o nas definições."),
        "month": MessageLookupByLibrary.simpleMessage("Mês"),
        "mqtt_parameters_configuration_error": m3,
        "network_name_label":
            MessageLookupByLibrary.simpleMessage("Nome da rede (SSID)"),
        "new_password_hint": MessageLookupByLibrary.simpleMessage("Nova senha"),
        "new_password_label":
            MessageLookupByLibrary.simpleMessage("Nova senha"),
        "no_account": MessageLookupByLibrary.simpleMessage("Não tem conta?"),
        "no_articles": MessageLookupByLibrary.simpleMessage(
            "Não foram encontrados artigos."),
        "no_code":
            MessageLookupByLibrary.simpleMessage("Não recebeu um código?"),
        "no_devices_found": MessageLookupByLibrary.simpleMessage(
            "Nenhum dispositivo encontrado"),
        "no_wifi_devices":
            MessageLookupByLibrary.simpleMessage("Nenhum dispositivo Wifi"),
        "open_article_in_browser":
            MessageLookupByLibrary.simpleMessage("Abrir artigo no navegador"),
        "open_settings_button":
            MessageLookupByLibrary.simpleMessage("Abrir página de definições"),
        "password_hint":
            MessageLookupByLibrary.simpleMessage("Palavra-passe aqui"),
        "password_label": MessageLookupByLibrary.simpleMessage(
            "Introduza a sua palavra-passe"),
        "password_mismatch_error":
            MessageLookupByLibrary.simpleMessage("As senhas não coincidem"),
        "password_requirements": MessageLookupByLibrary.simpleMessage(
            "Requisitos de senha:\n- Deve ter 10 caracteres ou mais\n- Deve conter um número\n- Deve conter um caractere minúsculo\n- Deve conter um caractere maiúsculo\n- Deve conter um caractere especial"),
        "password_too_short": MessageLookupByLibrary.simpleMessage(
            "A senha deve ter pelo menos 10 caracteres"),
        "password_too_weak": MessageLookupByLibrary.simpleMessage(
            "A senha deve conter pelo menos uma letra maiúscula, uma letra minúscula, um caractere especial e um número"),
        "please_add_new_device": MessageLookupByLibrary.simpleMessage(
            "Adicione um novo dispositivo"),
        "press_power_button_text": MessageLookupByLibrary.simpleMessage(
            "Prima o botão de ligar/desligar para iniciar o modo de emparelhamento"),
        "production": MessageLookupByLibrary.simpleMessage("Produção"),
        "provide_email":
            MessageLookupByLibrary.simpleMessage("Forneça o seu email"),
        "provide_email_text": MessageLookupByLibrary.simpleMessage(
            "Insira o endereço email associado à sua conta. Enviaremos um código de recuperação de palavra-passe para o seu email o qual poderá utilizar para recuperar a sua palavra-passe em segurança."),
        "remember_password":
            MessageLookupByLibrary.simpleMessage("Lembrar senha"),
        "resend_text": MessageLookupByLibrary.simpleMessage("Reenviar"),
        "reset_code_resent": MessageLookupByLibrary.simpleMessage(
            "Código de redefinição reenviado"),
        "reset_code_resent_info": MessageLookupByLibrary.simpleMessage(
            "Se você tem certeza de que tem uma conta conosco e não recebeu um código, verifique sua pasta de spam."),
        "reset_password": MessageLookupByLibrary.simpleMessage(
            "Verifique seu e-mail para obter um código de ativação e digite sua nova senha aqui."),
        "reset_password_button":
            MessageLookupByLibrary.simpleMessage("Redefinir senha"),
        "save_button": MessageLookupByLibrary.simpleMessage("Guardar"),
        "scan_start_error": MessageLookupByLibrary.simpleMessage(
            "Falha ao iniciar a verificação"),
        "see_all": MessageLookupByLibrary.simpleMessage("Ver todos"),
        "send_code": MessageLookupByLibrary.simpleMessage("Enviar o código"),
        "settings": MessageLookupByLibrary.simpleMessage("Configurações"),
        "sign_in_prompt":
            MessageLookupByLibrary.simpleMessage("Iniciar sessão na sua conta"),
        "signin_button": MessageLookupByLibrary.simpleMessage("Iniciar sessão"),
        "signin_text": MessageLookupByLibrary.simpleMessage("Iniciar sessão"),
        "signup_button": MessageLookupByLibrary.simpleMessage("Inscrever-se"),
        "signup_text": MessageLookupByLibrary.simpleMessage("Inscrever-se"),
        "solar_energy_produced":
            MessageLookupByLibrary.simpleMessage("Energia solar produzida"),
        "this_month": MessageLookupByLibrary.simpleMessage("Este mês"),
        "this_week": MessageLookupByLibrary.simpleMessage("Esta semana"),
        "this_year": MessageLookupByLibrary.simpleMessage("Este ano"),
        "today": MessageLookupByLibrary.simpleMessage("Hoje"),
        "total_energy": MessageLookupByLibrary.simpleMessage("Energia total"),
        "total_production_per_day":
            MessageLookupByLibrary.simpleMessage("Produção total por dia"),
        "user_exists_error": MessageLookupByLibrary.simpleMessage(
            "O utilizador já existe. (400)"),
        "username_error": MessageLookupByLibrary.simpleMessage(
            "Por favor, introduza um nome de utilizador válido"),
        "username_hint":
            MessageLookupByLibrary.simpleMessage("Nome de utilizador"),
        "username_label": MessageLookupByLibrary.simpleMessage(
            "Introduza o seu nome de utilizador"),
        "valid_code_error": MessageLookupByLibrary.simpleMessage(
            "Introduza um código de 6 dígitos válido"),
        "validator_enter_email": MessageLookupByLibrary.simpleMessage(
            "Por favor, insira um endereço de e-mail."),
        "validator_enter_password": MessageLookupByLibrary.simpleMessage(
            "Por favor, insira uma senha."),
        "validator_enter_valid_email": MessageLookupByLibrary.simpleMessage(
            "Por favor, insira um endereço de e-mail válido."),
        "validator_enter_valid_password": MessageLookupByLibrary.simpleMessage(
            "Por favor, insira uma senha válida."),
        "validator_password_10_chars": MessageLookupByLibrary.simpleMessage(
            "A senha deve ter pelo menos 10 caracteres."),
        "validator_password_lower": MessageLookupByLibrary.simpleMessage(
            "A senha deve conter pelo menos uma letra minúscula."),
        "validator_password_num": MessageLookupByLibrary.simpleMessage(
            "A senha deve conter pelo menos um número."),
        "validator_password_upper": MessageLookupByLibrary.simpleMessage(
            "A senha deve conter pelo menos uma letra maiúscula."),
        "validator_special_char": MessageLookupByLibrary.simpleMessage(
            "A senha deve conter pelo menos um caractere especial."),
        "verify_code": MessageLookupByLibrary.simpleMessage("Verificar código"),
        "week": MessageLookupByLibrary.simpleMessage("Semana"),
        "weekly_text": MessageLookupByLibrary.simpleMessage("Semanalmente"),
        "welcome_back":
            MessageLookupByLibrary.simpleMessage("Bem-vindo de volta!"),
        "welcome_text": MessageLookupByLibrary.simpleMessage("Bem-vindo 👋"),
        "wifi_connection_error": MessageLookupByLibrary.simpleMessage(
            "Falha na ligação WiFi. Certifique-se de que o dispositivo está ligado e em modo de emparelhamento"),
        "wifi_parameters_configuration_error": m4,
        "wifi_setup":
            MessageLookupByLibrary.simpleMessage("Configuração de WiFi"),
        "year": MessageLookupByLibrary.simpleMessage("Ano")
      };
}
