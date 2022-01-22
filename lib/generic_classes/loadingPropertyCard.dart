import 'package:flutter/material.dart';

class LoadingPropertyCard extends StatelessWidget {
  const LoadingPropertyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: FittedBox(
          child: Material(
            color: Colors.white,
            elevation: 8.0,
            borderRadius: BorderRadius.circular(10),
            shadowColor: Theme.of(context).primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ListTile(
                    title: Container(
                      height: 10,
                      width: MediaQuery.of(context).size.width ,
                      color: Colors.white,
                    ),
                    subtitle: Container(
                      height: 10,
                      width: MediaQuery.of(context).size.width ,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  height: 80,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
