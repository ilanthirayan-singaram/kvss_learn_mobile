import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final response = await ApiService.fetchProfile();
    if (response['status'] == 'success') {
      setState(() {
        _formData.addAll(response['data']);
        _loading = false;
      });
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final response = await ApiService.updateProfile(_formData);
    if (response['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'] ?? 'Update failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField('name', 'Name'),
              _buildTextField('parent_name', 'Parent Name'),
              _buildTextField('class_name', 'Class'),
              _buildTextField('dob', 'Date of Birth'),
              _buildTextField('school_name', 'School Name'),
              _buildTextField('street', 'Street'),
              _buildTextField('area', 'Area'),
              _buildTextField('city', 'City'),
              _buildTextField('pincode', 'Pincode'),
              _buildTextField('parent_mobile', 'Parent Mobile'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String field, String label) {
    return TextFormField(
      initialValue: _formData[field]?.toString() ?? '',
      decoration: InputDecoration(labelText: label),
      onSaved: (val) => _formData[field] = val ?? '',
    );
  }
}
