import 'package:flutter/material.dart';

class DeliveryAddressPage extends StatefulWidget {
  const DeliveryAddressPage({super.key});

  @override
  State<DeliveryAddressPage> createState() => _DeliveryAddressPageState();
}

class _DeliveryAddressPageState extends State<DeliveryAddressPage> {
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
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addNewAddress,
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _addresses.length,
        itemBuilder: (context, index) {
          final address = _addresses[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: Icon(
                address['title'] == 'Home' ? Icons.home : Icons.work,
                color: const Color(0xFFF05E23),
              ),
              title: Text(address['title']),
              subtitle: Text(address['address']),
              trailing: address['isDefault']
                  ? const Chip(
                      label: Text('Default', style: TextStyle(fontSize: 12)),
                      backgroundColor: Color(0xFFF05E23),
                      labelStyle: TextStyle(color: Colors.white),
                    )
                  : null,
              onTap: () => _editAddress(address),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewAddress,
        backgroundColor: const Color(0xFFF05E23),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _addNewAddress() {
    showDialog(
      context: context,
      builder: (context) => AddressDialog(
        onSave: (newAddress) {
          setState(() {
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
              _addresses[index] = updatedAddress;
            }
          });
        },
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
    return AlertDialog(
      title: Text(widget.address == null ? 'Add Address' : 'Edit Address'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                  labelText: 'Address Title (e.g., Home, Work)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Full Address'),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the address';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text('Set as default address'),
              value: _isDefault,
              onChanged: (value) => setState(() => _isDefault = value ?? false),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saveAddress,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF05E23),
          ),
          child: const Text('Save'),
        ),
      ],
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
