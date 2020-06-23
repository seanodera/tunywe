import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tunywe/background/functions.dart';
import 'package:tunywe/background/model.dart';
import 'package:tunywe/background/viewModel.dart';
import 'package:tunywe/ui/home/order/bottle/BottleList.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Types> list = listProcess();
    list.sort((a, b) {
      return a.className.compareTo(b.className);
    });
    list.add(Types('All', 'assets/all.png'));
    return ListView.builder(
      itemBuilder: (context, index) {
        Types type = list[index];
        return InkWell(
          child: Container(
            margin: EdgeInsets.all(5),
            height: 100,
            child: Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(type.pictureUrl))),
                  ),
                  Text(type.className)
                ],
              ),
            ),
          ),
          onTap: () =>
              Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Consumer<ViewModel>(
                      builder: (a, b, c) => BottleList(
                            titleText: type.className,
                          ))
              )),
        );
      },
      itemCount: list.length,
      shrinkWrap: true,
    );
  }
}
