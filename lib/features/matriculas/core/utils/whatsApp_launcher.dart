import 'package:url_launcher/url_launcher.dart';

class WhatsappLauncher {
  whatsAppLauncher(String telefone) async {
    var whatsappUrl = "https://api.whatsapp.com/send/?phone=$telefone";
    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl));
    } else {
      throw ('Não foi possível iniciar $whatsappUrl');
    }
  }
}
