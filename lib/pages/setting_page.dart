import 'package:exp_app/widgets/setting_page_wt/dark_mode_switch.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: ListView(
        children: const [
          DarkModeSwitch()
        ],
      ),
    );
  }
}
