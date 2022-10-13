import 'package:acciojob/pages/services/service_children.dart';
import 'package:acciojob/services/models/services/service.dart';
import 'package:acciojob/services/models/user/user_model.dart';
import 'package:acciojob/utils/constants/constants.dart';
import 'package:acciojob/utils/constants/dimensions.dart';
import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  UserModel? user;
  CustomSearchDelegate({
    this.user,
  });

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(
          Icons.clear,
          size: Dimensions.iconSize24,
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(
        Icons.arrow_back,
        size: Dimensions.iconSize24,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Service> matchQuery = [];
    for (var service in ServiceModel.services) {
      if (service.name!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(service);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return InkWell(
          onTap: () => Navigator.push(
            context,
            PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    ServiceChildrenPage(
                      service: result,
                      user: user,
                    ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var begin = Offset(0.0, 1.0);
                  var end = Offset.zero;
                  var tween = Tween(begin: begin, end: end);
                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                }),
          ),
          child: Card(
            margin: EdgeInsets.only(bottom: 5.0),
            child: ListTile(
              title: Text(result.name!),
              leading: Hero(
                tag: Key(result.id.toString()),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(result.filename != null
                      ? AppConstants.IMAGE_URL_SERVICE + result.filename!
                      : AppConstants.IMAGE_URL_DEFAULT),
                ),
              ),
              trailing: Icon(Icons.arrow_circle_right),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Service> matchQuery = [];
    for (var service in ServiceModel.services) {
      if (service.name!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(service);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return InkWell(
          onTap: () => Navigator.push(
            context,
            PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    ServiceChildrenPage(
                      service: result,
                      user: user,
                    ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var begin = Offset(0.0, 1.0);
                  var end = Offset.zero;
                  var tween = Tween(begin: begin, end: end);
                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                }),
          ),
          child: Card(
            margin: EdgeInsets.only(bottom: 5.0),
            child: ListTile(
              title: Text(result.name!),
              leading: Hero(
                tag: Key(result.id.toString()),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(result.filename != null
                      ? AppConstants.IMAGE_URL_SERVICE + result.filename!
                      : AppConstants.IMAGE_URL_DEFAULT),
                ),
              ),
              trailing: Icon(Icons.arrow_circle_right),
            ),
          ),
        );
      },
    );
  }
}
