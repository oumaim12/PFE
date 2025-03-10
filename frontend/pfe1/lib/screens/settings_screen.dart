import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Import your ApiService

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'Français';
  String _selectedRegion = 'France';

  // Controllers for profile update
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  // Controllers for password change
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  // Define the dark theme colors
  final Color _primaryColor = Colors.red;
  final Color _backgroundColor = Colors.grey[900]!;
  final Color _cardColor = Colors.grey[850]!;
  final Color _textColor = Colors.white;
  final Color _dividerColor = Colors.red.withOpacity(0.5);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
        primaryColor: _primaryColor,
        colorScheme: ColorScheme.dark(
          primary: _primaryColor,
          secondary: _primaryColor,
          surface: _cardColor,
          background: _backgroundColor,
        ),
        scaffoldBackgroundColor: _backgroundColor,
        dividerColor: _dividerColor,
        appBarTheme: AppBarTheme(
          backgroundColor: _backgroundColor,
          foregroundColor: _textColor,
          elevation: 0,
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return _primaryColor;
              }
              return Colors.grey;
            },
          ),
          trackColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return _primaryColor.withOpacity(0.5);
              }
              return Colors.grey.withOpacity(0.5);
            },
          ),
        ),
        dialogTheme: DialogTheme(
          backgroundColor: _cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: _primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: _primaryColor, width: 2),
          ),
          labelStyle: TextStyle(color: Colors.grey[400]),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Paramètres"),
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
                onTap: _showUpdateProfileDialog,
              ),
              _buildSettingItem(
                icon: Icons.lock,
                title: "Changer le mot de passe",
                onTap: _showChangePasswordDialog,
              ),
              _buildSettingItem(
                icon: Icons.delete,
                title: "Supprimer le compte",
                onTap: _showDeleteAccountDialog,
              ),
              Divider(color: _dividerColor),
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
              Divider(color: _dividerColor),
              _buildSectionTitle("Langue et Région"),
              _buildSettingItem(
                icon: Icons.language,
                title: "Langue",
                trailing: DropdownButton<String>(
                  value: _selectedLanguage,
                  dropdownColor: _cardColor,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedLanguage = newValue!;
                    });
                  },
                  items: <String>[
                    'Français',
                    'English',
                    'Español',
                  ].map<DropdownMenuItem<String>>((String value) {
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
                  dropdownColor: _cardColor,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRegion = newValue!;
                    });
                  },
                  items: <String>[
                    'France',
                    'Belgique',
                    'Suisse',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Divider(color: _dividerColor),
              _buildSectionTitle("Notifications"),
              SwitchListTile(
                title: const Text("Activer les notifications"),
                value: _notificationsEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
                secondary: Icon(Icons.notifications, color: _primaryColor),
              ),
              Divider(color: _dividerColor),
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
              Divider(color: _dividerColor),
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
              Divider(color: _dividerColor),
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
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: _primaryColor,
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
    return Card(
      color: _cardColor,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey[800]!),
      ),
      child: ListTile(
        leading: Icon(icon, color: _primaryColor),
        title: Text(title),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }

  // Show dialog for updating profile
  void _showUpdateProfileDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Modifier le profil",
            style: TextStyle(color: _primaryColor),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nom'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Téléphone'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'Adresse'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Annuler", style: TextStyle(color: Colors.grey[400])),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
              ),
              onPressed: () async {
                final result = await ApiService.updateProfile(
                  1, // Replace with actual userId
                  _nameController.text,
                  _emailController.text,
                  phone: _phoneController.text,
                  address: _addressController.text,
                );

                if (result["success"]) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("Profil mis à jour avec succès"),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Échec de la mise à jour: ${result["message"]}",
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
                Navigator.of(context).pop();
              },
              child: const Text("Enregistrer"),
            ),
          ],
        );
      },
    );
  }

  // Show dialog for changing password
  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Changer le mot de passe",
            style: TextStyle(color: _primaryColor),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _currentPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Mot de passe actuel',
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _newPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Nouveau mot de passe',
                  ),
                  obscureText: true,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Annuler", style: TextStyle(color: Colors.grey[400])),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
              ),
              onPressed: () async {
                final result = await ApiService.changePassword(
                  1, // Replace with actual userId
                  _currentPasswordController.text,
                  _newPasswordController.text,
                );

                if (result["success"]) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("Mot de passe changé avec succès"),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Échec du changement: ${result["message"]}",
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }

                Navigator.of(context).pop();
              },
              child: const Text("Enregistrer"),
            ),
          ],
        );
      },
    );
  }

  // Show dialog for deleting account
  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Supprimer le compte",
            style: TextStyle(color: Colors.red),
          ),
          content: const Text(
            "Êtes-vous sûr de vouloir supprimer votre compte ? Cette action est irréversible.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Annuler", style: TextStyle(color: Colors.grey[400])),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () async {
                final result = await ApiService.deleteAccount(
                  1,
                ); // Replace with actual userId

                if (result["success"]) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Compte supprimé avec succès"),
                      backgroundColor: Colors.green,
                    ),
                  );
                  // Navigate to login screen or perform logout
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Échec de la suppression: ${result["message"]}",
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }

                Navigator.of(context).pop();
              },
              child: const Text(
                "Supprimer",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}