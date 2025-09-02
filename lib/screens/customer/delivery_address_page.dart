import 'package:flutter/material.dart';

class DeliveryAddressPage extends StatefulWidget {
  const DeliveryAddressPage({super.key});

  @override
  State<DeliveryAddressPage> createState() => _DeliveryAddressPageState();
}

class _DeliveryAddressPageState extends State<DeliveryAddressPage> {
  // Brand colors
  final Color primaryColor = const Color(0xFFF05E23); // Orange flame color
  final Color secondaryColor = const Color(0xFF333333); // Dark gray
  final Color accentColor = const Color(0xFFFFD700); // Gold/yellow accent
  final Color lightBackground = const Color(0xFFF8F9FA); // Light background

  final List<Map<String, dynamic>> _addresses = [
    {
      'id': 1,
      'title': 'Home',
      'address': '123 Main Street, Nairobi',
      'isDefault': true,
    },
    {
      'id': 2,
      'title': 'Work',
      'address': '456 Office Road, Westlands',
      'isDefault': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Addresses'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addNewAddress,
            tooltip: 'Add new address',
          ),
        ],
      ),
      backgroundColor: lightBackground,
      body: _addresses.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _addresses.length,
              itemBuilder: (context, index) {
                final address = _addresses[index];
                return _buildAddressCard(address);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewAddress,
        backgroundColor: primaryColor,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 80,
            color: secondaryColor.withOpacity(0.3),
          ),
          const SizedBox(height: 20),
          Text(
            'No addresses yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: secondaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first delivery address',
            style: TextStyle(
              color: secondaryColor.withOpacity(0.6),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _addNewAddress,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Add Address'),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(Map<String, dynamic> address) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    address['title'] == 'Home' ? Icons.home : Icons.work,
                    color: primaryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        address['title'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: secondaryColor,
                        ),
                      ),
                      if (address['isDefault'])
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'DEFAULT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const Text('Edit'),
                      onTap: () => _editAddress(address),
                    ),
                    PopupMenuItem(
                      child: const Text('Delete'),
                      onTap: () => _deleteAddress(address),
                    ),
                    if (!address['isDefault'])
                      PopupMenuItem(
                        child: const Text('Set as Default'),
                        onTap: () => _setAsDefault(address),
                      ),
                  ],
                  icon: Icon(Icons.more_vert,
                      color: secondaryColor.withOpacity(0.6)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              address['address'],
              style: TextStyle(
                color: secondaryColor.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _editAddress(address),
                style: OutlinedButton.styleFrom(
                  foregroundColor: primaryColor,
                  side: BorderSide(color: primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Edit Address'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addNewAddress() {
    showDialog(
      context: context,
      builder: (context) => AddressDialog(
        onSave: (newAddress) {
          setState(() {
            // If new address is set as default, remove default from others
            if (newAddress['isDefault']) {
              for (var address in _addresses) {
                address['isDefault'] = false;
              }
            }
            _addresses.add(newAddress);
          });
        },
      ),
    );
  }

  void _editAddress(Map<String, dynamic> address) {
    showDialog(
      context: context,
      builder: (context) => AddressDialog(
        address: address,
        onSave: (updatedAddress) {
          setState(() {
            final index =
                _addresses.indexWhere((a) => a['id'] == address['id']);
            if (index != -1) {
              // If updated address is set as default, remove default from others
              if (updatedAddress['isDefault']) {
                for (var addr in _addresses) {
                  if (addr['id'] != address['id']) {
                    addr['isDefault'] = false;
                  }
                }
              }
              _addresses[index] = updatedAddress;
            }
          });
        },
      ),
    );
  }

  void _deleteAddress(Map<String, dynamic> address) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Address'),
        content: Text('Are you sure you want to delete "${address['title']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _addresses.removeWhere((a) => a['id'] == address['id']);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Address "${address['title']}" deleted'),
                  backgroundColor: primaryColor,
                ),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _setAsDefault(Map<String, dynamic> address) {
    setState(() {
      for (var addr in _addresses) {
        addr['isDefault'] = addr['id'] == address['id'];
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"${address['title']}" set as default address'),
        backgroundColor: primaryColor,
      ),
    );
  }
}

class AddressDialog extends StatefulWidget {
  final Map<String, dynamic>? address;
  final Function(Map<String, dynamic>) onSave;

  const AddressDialog({super.key, this.address, required this.onSave});

  @override
  State<AddressDialog> createState() => _AddressDialogState();
}

class _AddressDialogState extends State<AddressDialog> {
  // Brand colors
  final Color primaryColor = const Color(0xFFF05E23);
  final Color secondaryColor = const Color(0xFF333333);
  final Color lightBackground = const Color(0xFFF8F9FA);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool _isDefault = false;

  @override
  void initState() {
    super.initState();
    if (widget.address != null) {
      _titleController.text = widget.address!['title'];
      _addressController.text = widget.address!['address'];
      _isDefault = widget.address!['isDefault'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.address == null ? 'Add New Address' : 'Edit Address',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: secondaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Enter your delivery address details',
              style: TextStyle(
                color: secondaryColor.withOpacity(0.6),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(
                    controller: _titleController,
                    label: 'Address Title (e.g., Home, Work)',
                    icon: Icons.title,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _addressController,
                    label: 'Full Address',
                    icon: Icons.location_on,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Set as default address',
                      style: TextStyle(color: secondaryColor),
                    ),
                    value: _isDefault,
                    onChanged: (value) =>
                        setState(() => _isDefault = value ?? false),
                    activeColor: primaryColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: secondaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveAddress,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
      style: TextStyle(color: secondaryColor),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: secondaryColor.withOpacity(0.6)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        prefixIcon: Icon(icon, color: primaryColor),
        filled: true,
        fillColor: lightBackground,
      ),
    );
  }

  void _saveAddress() {
    if (_formKey.currentState!.validate()) {
      final address = {
        'id': widget.address?['id'] ?? DateTime.now().millisecondsSinceEpoch,
        'title': _titleController.text,
        'address': _addressController.text,
        'isDefault': _isDefault,
      };
      widget.onSave(address);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
