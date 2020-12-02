import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:tabletapp/constants/size_config.dart';

class ScanResultTile extends StatelessWidget {
  const ScanResultTile({@required this.result, @required this.onTap});

  final ScanResult result;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 40,
      height: SizeConfig.blockSizeVertical * 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(result.advertisementData.localName),
          Container(width: SizeConfig.blockSizeHorizontal * 5),
          RaisedButton(
            child: Text('CONNECT'),
            color: Colors.black,
            textColor: Colors.white,
            onPressed: (result.advertisementData.connectable) ? onTap : null,
          ),
        ],
      ),
    );
  }
}
