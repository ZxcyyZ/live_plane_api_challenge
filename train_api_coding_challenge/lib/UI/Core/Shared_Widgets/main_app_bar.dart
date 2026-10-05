import 'package:flutter/material.dart';

class TrainAppTitle extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? navigationCallback;
  final String appTitle;

  final List<Widget>? actionlist;


  const TrainAppTitle (
    {
    super.key,
    required this.appTitle,
    this.navigationCallback,
    this.actionlist,

    }
  );

  //setup colour configs after
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Title(
        color: Colors.white,
        title: "Placeholder",
        child: Text(
          style: TextStyle(
            color: Colors.white
          ),
          appTitle,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      actions: actionlist ??
       <Widget>[
        IconButton(
          onPressed: () => {}, 
          icon: Icon(
            Icons.refresh,
          )
        )
      ], 
    
      backgroundColor: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white
      ),

    );
  }

    @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}