import 'package:crud_api/models/company.dart';
import 'package:crud_api/services/company_service.dart';
import 'package:flutter/material.dart';

class CreateCompany extends StatefulWidget {
  final Company? company;
  const CreateCompany({super.key, this.company});

  @override
  State<CreateCompany> createState() => _CreateCompanyState();
}

class _CreateCompanyState extends State<CreateCompany> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _adressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();

  //Для того что бы редоктировать
  @override
  void initState() {
    super.initState();
    if (widget.company != null) {
      _nameController.text = widget.company!.companyName!;
      _adressController.text = widget.company!.companyAdress!;
      _phoneController.text = widget.company!.companyNumber!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Add Company"),
      ),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextFormField(
                _nameController,
                "Name",
                "Enter the company name",
                "Your name here..",
                (value) {
                  if (value!.isEmpty) {
                    return "Please enter the company name";
                  }
                  return null;
                },
              ),
              _buildTextFormField(
                _adressController,
                "Adress",
                "Enter the company adress",
                "Your adress",
                (value) {
                  if (value!.isEmpty) {
                    return "Please enter the company adress";
                  }
                  return null;
                },
              ),
              _buildTextFormField(
                _phoneController,
                "Number",
                "Enter the phone number",
                "Your number here",
                (value) {
                  if (value!.isEmpty) {
                    return "Please enter the company phone";
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    Company newCompany = Company(
                      companyName: _nameController.text,
                      companyAdress: _adressController.text,
                      companyNumber: _phoneController.text,
                      companyLogo: " https://logo.clearbit.com/mtv.com",
                    );
                    if (widget.company != null) {
                      await CompanyService().updateCompany(newCompany, widget.company!.id!);
                    } else {
                      await CompanyService().createCompany(newCompany);
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Company added succesfully"),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.company == null?"Create company": "Update company"),
              ),

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextFormField(
              //     controller: _adressController,
              //     decoration: const InputDecoration(
              //         helperText: "Your adress here..",
              //         labelText: "Adress",
              //         hintText: "Enter the company adress",
              //         border: OutlineInputBorder()),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextFormField(
              //     controller: _phoneController,
              //     decoration: const InputDecoration(
              //         helperText: "Your phone number here..",
              //         labelText: "Number",
              //         hintText: "Enter the phone number",
              //         border: OutlineInputBorder()),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(
    TextEditingController controller,
    String helperText,
    String labelText,
    String hintText,
    String? Function(String?)? validator,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            helperText: helperText,
            labelText: labelText,
            hintText: hintText,
            border: const OutlineInputBorder()),
      ),
    );
  }
}
