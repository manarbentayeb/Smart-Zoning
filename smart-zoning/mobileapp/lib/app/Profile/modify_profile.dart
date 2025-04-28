import 'package:flutter/material.dart';
import 'package:myapp/app/Widgets/inputfieldformat.dart';


class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  // Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _genderController.dispose();
    _addressController.dispose();
    _jobTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier le profil'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              InputField(
                controller: _nameController,
                label: 'Nom complet',
                hintText: 'Shivam Kumar',
                 keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              InputField(
                controller: _emailController,
                label: 'Email',
                hintText: 'youremail@domain.com',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              InputField(
                controller: _phoneController,
                label: 'Numéro de téléphone',
                hintText: '123-456-7890',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              InputField(
                controller: _genderController,
                label: 'Genre',
                hintText: 'Female',
                 keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              InputField(
                controller: _addressController,
                label: 'Adresse',
                hintText: '45 New Avenue, New York',
                 keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              InputField(
                controller: _jobTitleController,
                label: 'Nom du Manager',
                hintText: 'John Doe',
                 keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // Add your registration logic here
                  print('Form submitted');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'ENREGISTRER',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
