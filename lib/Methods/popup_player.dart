import 'package:flutter/material.dart';
import 'package:kabyarphatyinhlu/Widgets/SlidingUpPanel/collapsed_bottom_widget.dart';
import 'package:kabyarphatyinhlu/Widgets/SlidingUpPanel/panel_bottom_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PopupPlayer extends StatefulWidget {
  const PopupPlayer({Key? key}) : super(key: key);

  @override
  State<PopupPlayer> createState() => _PopupPlayerState();
}

class _PopupPlayerState extends State<PopupPlayer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SlidingUpPanel(
        backdropOpacity: 0.1,
        backdropEnabled: true,
        maxHeight: MediaQuery.of(context).size.height * 0.85,
        minHeight: 100,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0),
          ),
        ],
        color: Colors.transparent,
        onPanelOpened: () {
          setState(() {
            // padding = 0;
          });
        },
        onPanelClosed: () {
          setState(() {
            // padding = 100;
          });
        },
        collapsed: const CollapsedBottomWidget(),
        panel: const PanelBottomWidget(),
      ),
    );
  }
}
