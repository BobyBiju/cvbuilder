import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;


class CvScreen extends StatefulWidget {


  @override
  _CvScreenState createState() => _CvScreenState();
}

class _CvScreenState extends State<CvScreen> {



  String bio;
  String name;
  String email;
  String avatar;
  String company;
  String website;
  int  projects;
  String repoName;
  String repoDescription;
  String repoUrl;
  
  List<dynamic> repoList=[];

  Future<dynamic> getData() async {
    http.Response res = await http.get(
        Uri.parse("https://api.github.com/users/BobyBiju"));
    var data = res.body;

    http.Response res2 = await http.get(
        Uri.parse("https://api.github.com/users/BobyBiju/repos"));
    var data2 = res2.body;
    var json =jsonDecode(data2);
    for(var i in json){
      repoList.add(i["name"]);
      repoList.add(i["description"]);
      repoList.add(i["url"]);
    }


    bio = jsonDecode(data)["bio"];
    name =jsonDecode(data)["name"];
    email =jsonDecode(data)["email"];
    avatar=jsonDecode(data)["avatar_url"];
    company=jsonDecode(data)["company"];
    website=jsonDecode(data)["blog"];
    projects=jsonDecode(data)["public_repos"];


    print(bio);
    print(name);
    print(email);
    print(avatar);
    print(company);
    print(website);
    print(projects);

    setState(() {

    });
  }
  @override
  void initState() {
    getData();// TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage('$avatar'),
              ),
              Text(
                '$name',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 25.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5.0,horizontal: 25.0),
                child: Text('$bio',
                  style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    color: Colors.black87,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
                width: 150.0,
                child: Divider(
                  color: Colors.teal.shade600,
                ),
              ),


              Container(
                child: Column(
                  children: [
                    Card(
                        color: Colors.white70,
                        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.sports_basketball,
                            color: Colors.teal,
                          ),
                          title: Text(
                            'Website :$website',
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.teal.shade900,
                                fontFamily: 'Source Sans Pro'),
                          ),
                        )),
                    Card(
                        color: Colors.white70,
                        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.work_rounded,
                            color: Colors.teal,
                          ),
                          title: Text(
                            '$company',
                            style: TextStyle(
                              color: Colors.teal.shade900,
                              fontFamily: 'Source Sans Pro',
                              fontSize: 15.0,
                            ),
                          ),
                        )),
                    Card(
                        color: Colors.white70,
                        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.precision_manufacturing_outlined,
                            color: Colors.teal,
                          ),
                          title: Text(
                            'Projects: $projects',
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.teal.shade900,
                                fontFamily: 'Source Sans Pro'),
                          ),
                        )
                    ),


                  ],
                ),
              ),

            ],
          )
      ),
    );
  }
}
