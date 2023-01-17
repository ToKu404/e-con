import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/src/presentations/blocs/realtime_internet_check/realtime_internet_check_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckInternetSingle extends StatefulWidget {
  final Widget child;
  const CheckInternetSingle({super.key, required this.child});

  @override
  State<CheckInternetSingle> createState() => _CheckInternetSingleState();
}

class _CheckInternetSingleState extends State<CheckInternetSingle> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RealtimeInternetCheckCubit>(context)
        .onCheckConnectionRealtime();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RealtimeInternetCheckCubit, RealtimeInternetCheckState>(
      listener: (context, state) {
        if (state is RealtimeInternetCheckLost) {
          const snackBar = SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'Koneksi Internet anda Terputus',
              style: TextStyle(color: Palette.white),
            ),
            duration: Duration(days: 1),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is RealtimeInternetCheckGain) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        }
      },
      child: widget.child,
    );
  }
}
