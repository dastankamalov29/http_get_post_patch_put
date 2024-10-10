import 'dart:convert';
import 'dart:developer';

import 'package:crud_api/models/company.dart';
import 'package:http/http.dart' as http;

class CompanyService {
  String baseUrl = "https://retoolapi.dev/0d7NGM/";

  //Получить данные с ip
  //GET получить данные
  getAllCompanies() async {
    try {
      List<Company> allCompanies = [];
      var response = await http.get(Uri.parse('${baseUrl}company'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        //Показывает в терминале данные
        print(data);

        for (var company in data) {
          Company newCompany = Company.fromJson(company);
          allCompanies.add(newCompany);
        }

        return allCompanies;
      } else {
        throw Exception(
          "Error occures with status code ${response.statusCode} and the message is ${response.body}",
        );
      }
    } catch (e) {
      print("The error occured: ${e.toString()}");
    }
  }

  //Создать данные в ip
  //Post создать данные
  createCompany(Company company) async {
    log("Create company is called");
    try {
      var response = await http.post(
        Uri.parse('${baseUrl}company'),
        body: company.toJson(),
      );
      log("The Response is ${response.body}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        print(
            "The company succesfully created with the following detail: ${response.body}");
      } else {
        throw Exception(
          "Error occures with status code ${response.statusCode} and the message is ${response.body}",
        );
      }
    } catch (e) {
      print("The error occured: ${e.toString()}");
    }
  }

  //Изменить данные в ip используя id
  //Patch частично обновить
  // PUT полностью обновить
  updateCompany(Company company, int id) async {
    try {
      var response = await http.put(
        Uri.parse('${baseUrl}company/$id'),
        body: company.toJson(),
      );
      log("the response status code is ${response.statusCode}");
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        print(
            "The company succesfully deleted with the following detail: ${response.body}");
      } else {
        throw Exception(
          "Error occures with status code ${response.statusCode} and the message is ${response.body}",
        );
      }
    } catch (e) {
      print("The error occured: ${e.toString()}");
    }
  }

  //Удалить данные с ip используя id
  //DELETE удалить данные по id
  deleteCompany(int id) async {
    try {
      var response = await http.delete(
        Uri.parse('${baseUrl}company/$id'),
      );
      if (response.statusCode == 204 || response.statusCode == 200) {
        print(
            "The company succesfully deleted with the following detail: ${response.body}");
      } else {
        throw Exception(
          "Error occures with status code ${response.statusCode} and the message is ${response.body}",
        );
      }
    } catch (e) {
      print("The error occured: ${e.toString()}");
    }
  }
}
