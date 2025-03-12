import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Import your ApiService

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // User information
  String _firstName = "Marie";
  String _lastName = "Dupont";
  String _userEmail = "marie.dupont@example.com";
  String _userPhone = "+33 6 12 34 56 78";
  String _userAddress = "123 Rue de Paris, 75001 Paris";
  String _userCni = "1234567890"; // Added CNI field
  bool _isLoading = false;

  // Controllers for profile update
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cniController = TextEditingController(); // Added CNI controller

  // Controllers for password change
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  // Define the dark theme colors
  final Color _primaryColor = Colors.red;
  final Color _backgroundColor = Colors.grey[900]!;
  final Color _cardColor = Colors.grey[850]!;
  final Color _textColor = Colors.white;
  final Color _dividerColor = Colors.red.withOpacity(0.5);

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Replace this with actual API call
      final userData = await ApiService.getUserProfile(1); // Use actual userId

      setState(() {
        _firstName = userData['first_name'] ?? "Prénom non disponible";
        _lastName = userData['last_name'] ?? "Nom non disponible";
        _userEmail = userData['email'] ?? "Email non disponible";
        _userPhone = userData['phone'] ?? "Téléphone non disponible";
        _userAddress = userData['address'] ?? "Adresse non disponible";
        _userCni = userData['cni'] ?? "CNI non disponible"; // Added CNI

        // Pre-fill controllers
        _firstNameController.text = _firstName;
        _lastNameController.text = _lastName;
        _emailController.text = _userEmail;
        _phoneController.text = _userPhone;
        _addressController.text = _userAddress;
        _cniController.text = _userCni; // Pre-fill CNI
      });
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erreur lors du chargement du profil"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
        dialogTheme: DialogTheme(
          backgroundColor: _cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          labelStyle: TextStyle(color: Colors.grey[400]),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profil"),
          centerTitle: true,
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User profile header
                    _buildUserProfileHeader(),
                    const SizedBox(height: 24),
                    _buildSectionTitle("Informations Personnelles"),
                    _buildUserInfoCard(
                      icon: Icons.person,
                      title: "Prénom",
                      value: _firstName,
                    ),
                    _buildUserInfoCard(
                      icon: Icons.person_outline,
                      title: "Nom de famille",
                      value: _lastName,
                    ),
                    _buildUserInfoCard(
                      icon: Icons.email,
                      title: "Email",
                      value: _userEmail,
                    ),
                    _buildUserInfoCard(
                      icon: Icons.credit_card,
                      title: "CNI",
                      value: _userCni, // Added CNI
                    ),
                    _buildUserInfoCard(
                      icon: Icons.phone,
                      title: "Téléphone",
                      value: _userPhone,
                    ),
                    _buildUserInfoCard(
                      icon: Icons.home,
                      title: "Adresse",
                      value: _userAddress,
                    ),
                    const SizedBox(height: 16),
                    _buildSectionTitle("Actions"),
                    _buildSettingItem(
                      icon: Icons.edit,
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
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildUserProfileHeader() {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: _primaryColor,
            child: Text(
              _firstName.isNotEmpty
                  ? _firstName.substring(0, 1).toUpperCase()
                  : "?",
              style: const TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "$_firstName $_lastName", // Display full name
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _userEmail,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      color: _cardColor,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: _primaryColor),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
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
      ),
      child: ListTile(
        leading: Icon(icon, color: _primaryColor),
        title: Text(title),
        trailing: trailing ??
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey[600],
            ),
        onTap: onTap,
      ),
    );
  }

  // Show dialog for updating profile
  void _showUpdateProfileDialog() {
    // Pre-fill with current values
    _firstNameController.text = _firstName;
    _lastNameController.text = _lastName;
    _emailController.text = _userEmail;
    _phoneController.text = _userPhone;
    _addressController.text = _userAddress;
    _cniController.text = _userCni; // Pre-fill CNI

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
                  controller: _firstNameController,
                  decoration: const InputDecoration(labelText: 'Prénom'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(labelText: 'Nom de famille'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _cniController,
                  decoration: const InputDecoration(labelText: 'CNI'),
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
                  _firstNameController.text,
                  _lastNameController.text,
                  _emailController.text,
                  phone: _phoneController.text,
                  address: _addressController.text,
                );

                if (result["success"]) {
                  // Update the local state
                  setState(() {
                    _firstName = _firstNameController.text;
                    _lastName = _lastNameController.text;
                    _userEmail = _emailController.text;
                    _userPhone = _phoneController.text;
                    _userAddress = _addressController.text;
                    _userCni = _cniController.text; // Update CNI
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Profil mis à jour avec succès"),
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
    _currentPasswordController.clear();
    _newPasswordController.clear();

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
                    const SnackBar(
                      content: Text("Mot de passe changé avec succès"),
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
                  1, // Replace with actual userId
                );

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
