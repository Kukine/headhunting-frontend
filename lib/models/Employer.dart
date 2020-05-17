import 'dart:convert';

class Employer{
  
  int id;
  String name;
  String surname;
  String email;
  String password;
  int type;
  String organizationName;

  Employer({
    this.id,
    this.name,
    this.surname,
    this.email,
    this.password,
    this.type,
    this.organizationName
  });

  Map toJson(){
    return {
    'id' : id,
    'name' : name,
    'surname' : surname,
    'email' : email,
    'password' : password,   
    'type' : 2,
    'organization' : new Organization(name: organizationName, adress: "placeholder").toJson() 
    };
  }

  factory Employer.fromJson(dynamic json){
    return Employer(
      id: json['id'],
      name : json['name'],
      surname: json['surname'],
      email: json['email'],
      password: json['password'],
      type : json['type'],
      organizationName: json['organization']['name']
    );
  }
}

class Organization{
  int id;
  String name;
  String adress;

  Organization({
    this.id,
    this.name,
    this.adress
  });

  Map toJson(){
    return {
      'id' : id,
      'name' : name,
      'adress' : adress
    };
  }

  factory Organization.fromJson(dynamic json){
    return Organization(
      id : json['id'],
      name : json['name'],
      adress : json['adress']
    );
  }
}