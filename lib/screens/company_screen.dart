import 'package:crud_api/models/company.dart';
import 'package:crud_api/screens/create_company.dart';
import 'package:crud_api/services/company_service.dart';
import 'package:flutter/material.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // context.go('/addCompany');
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => CreateCompany()));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Company Api"),
      ),
      body: FutureBuilder(
        future: CompanyService().getAllCompanies(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error reciving data from server"),
            );
          }

          if (snapshot.hasData) {
            List<Company> data = snapshot.data as List<Company>;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Material(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20)),
                      // color: Colors.red,
                      // height: size.height * 0.2,
                      width: double.maxFinite,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 15),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  data[index].companyLogo ?? "https://logo.clearbit.com/mtv.com",
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index].companyName ?? "Company name unavailable",
                                  ),
                                  Text(
                                    data[index].companyNumber ?? "No number",
                                  ),
                                  Text(
                                    data[index].companyAdress ?? "No adress",
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => CreateCompany(company: data[index],)));
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  "Are you sure to delete this company"),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    await CompanyService()
                                                        .deleteCompany(
                                                            data[index].id!);
                                                    Navigator.pop(context);
                                                    setState(() {});
                                                  },
                                                  child: const Text("Yes"),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("No"),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
