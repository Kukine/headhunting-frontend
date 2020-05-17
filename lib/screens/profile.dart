import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:headhunting_flutter/models/Employee.dart';
import 'package:oauth2/oauth2.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();

  Client client;
  Employee employee;
  Profile({this.client, this.employee});
}

class _ProfileState extends State<Profile> {
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade900,
        title: Text("${widget.employee.name}" + "'s Profile"),
      ),
      body: new Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            _userInfo(),
          ],
        ),
      ),
    );
  }

  Widget _userInfo() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(children: <Widget>[
        Row(
          children: <Widget>[
            _userNameEmail(),
            SizedBox(
              width: 15,
            ),
            _userAvatar()
          ],
        ),
        _aboutUser(),
        SizedBox(
          height: 10,
        ),
        _userSkillsInfo()
      ]),
    );
  }

  Widget _userAvatar() {
    return Hero(
      tag: "${widget.employee.email}",
      child: CircleAvatar(
        backgroundColor: Colors.purple.shade700,
        child: Text(
          '${widget.employee.name.substring(0, 1)}' +
              '${widget.employee.surname.substring(0, 1)}',
        ),
        radius: 30,
      ),
    );
  }

  Widget _aboutUser() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "About:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "How the user describes himself",
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Tincidunt eget nullam non nisi est sit. In egestas erat imperdiet sed euismod nisi porta lorem. Pulvinar mattis nunc sed blandit libero. Molestie ac feugiat sed lectus vestibulum."),
          ],
        ));
  }

  Widget _userNameEmail() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
        Widget>[
      Row(
        children: <Widget>[
          Text(
            "Name:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 20,
          ),
          Text("${widget.employee.name}" + " " + "${widget.employee.surname}")
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: <Widget>[
          Text(
            "Email:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 20,
          ),
          Text("${widget.employee.email}")
        ],
      )
    ]);
  }

  Widget _userSkillsInfo() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Skills:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Tags(
            spacing: 15,
            runAlignment: WrapAlignment.end,
            alignment: WrapAlignment.center,
            key: _tagStateKey,
            itemCount: widget.employee.skills.length,
            itemBuilder: (int index) {
              final skill = widget.employee.skills[index];

              return ItemTags(
                key: Key(index.toString()),
                alignment: MainAxisAlignment.end,
                activeColor: Colors.teal,
                index: index,
                title: skill.name,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                textStyle: TextStyle(fontSize: 14),
                combine: ItemTagsCombine.withTextBefore,
              );
            },
          )
        ],
      );
  }
}
