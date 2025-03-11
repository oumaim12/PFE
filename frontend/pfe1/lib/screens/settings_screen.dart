import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'Français';
  String _selectedRegion = 'France';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Compte"),
            _buildSettingItem(
              icon: Icons.person,
              title: "Modifier le profil",
              onTap: () {},
            ),
            _buildSettingItem(
              icon: Icons.lock,
              title: "Changer le mot de passe",
              onTap: () {},
            ),
            // _buildSettingItem(
            //   icon: Icons.delete,
            //   title: "Supprimer le compte",
            //   onTap: _showDeleteAccountDialog,
            // ),
            const Divider(),
            _buildSectionTitle("Commandes et Paiements"),
            _buildSettingItem(
              icon: Icons.shopping_cart,
              title: "Historique des commandes",
              onTap: () {},
            ),
            _buildSettingItem(
              icon: Icons.credit_card,
              title: "Méthodes de paiement",
              onTap: () {},
            ),
            _buildSettingItem(
              icon: Icons.receipt,
              title: "Informations de facturation",
              onTap: () {},
            ),
            _buildSettingItem(
              icon: Icons.track_changes,
              title: "Suivi des commandes",
              onTap: () {},
            ),
            const Divider(),
            _buildSectionTitle("Langue et Région"),
            _buildSettingItem(
              icon: Icons.language,
              title: "Langue",
              trailing: DropdownButton<String>(
                value: _selectedLanguage,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLanguage = newValue!;
                  });
                },
                items: <String>['Français', 'English', 'Español']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            _buildSettingItem(
              icon: Icons.location_on,
              title: "Région",
              trailing: DropdownButton<String>(
                value: _selectedRegion,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRegion = newValue!;
                  });
                },
                items: <String>['France', 'Belgique', 'Suisse']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const Divider(),
            _buildSectionTitle("Notifications"),
            SwitchListTile(
              title: const Text("Activer les notifications"),
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
              secondary: const Icon(Icons.notifications),
            ),
            const Divider(),
            _buildSectionTitle("Sécurité et Confidentialité"),
            _buildSettingItem(
              icon: Icons.security,
              title: "Authentification à deux facteurs",
              trailing: Switch(
                value: true,
                onChanged: (bool value) {},
              ),
            ),
            _buildSettingItem(
              icon: Icons.privacy_tip,
              title: "Politique de confidentialité",
              onTap: () {},
            ),
            const Divider(),
            _buildSectionTitle("Assistance et Support"),
            _buildSettingItem(
              icon: Icons.help,
              title: "Centre d'aide",
              onTap: () {},
            ),
            _buildSettingItem(
              icon: Icons.support,
              title: "Contacter le support",
              onTap: () {},
            ),
            _buildSettingItem(
              icon: Icons.bug_report,
              title: "Signaler un problème",
              onTap: () {},
            ),
            const Divider(),
            _buildSectionTitle("À propos"),
            _buildSettingItem(
              icon: Icons.info,
              title: "Version de l'application",
              trailing: const Text("1.0.0"),
            ),
            _buildSettingItem(
              icon: Icons.description,
              title: "Conditions d'utilisation",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: trailing,
      onTap: onTap,
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Supprimer le compte"),
          content: const Text("Êtes-vous sûr de vouloir supprimer votre compte ? Cette action est irréversible."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Annuler"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Supprimer", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}