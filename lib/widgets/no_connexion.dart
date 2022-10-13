import 'package:acciojob/utils/constants/dimensions.dart';
import 'package:flutter/material.dart';

class NoConnexion extends StatelessWidget {
  const NoConnexion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Icon(
                Icons.wifi_off_sharp,
                size: Dimensions.height100,
              ),
            ),
            Center(
              child: Text(
                'Aucune connexion internet',
                style: TextStyle(
                  fontSize: Dimensions.font18,
                  color: Colors.black,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(Dimensions.height20),
                child: Text(
                  'Veuillez vérifier que vos données mobiles ou connexion wifi sont activées.',
                  style: TextStyle(
                    fontSize: Dimensions.font12,
                    color: Colors.black.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
