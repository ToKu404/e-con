import 'package:e_con/src/presentations/blocs/onetime_internet_check/onetime_internet_check_cubit.dart';
import 'package:e_con/src/presentations/reusable_pages/econ_no_internet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckInternetOnetime extends StatefulWidget {
  final WidgetBuilder child;
  const CheckInternetOnetime({super.key, required this.child});

  @override
  State<CheckInternetOnetime> createState() => _CheckInternetOnetimeState();
}

class _CheckInternetOnetimeState extends State<CheckInternetOnetime> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OnetimeInternetCheckCubit>(context)
        .onCheckConnectionOnetime();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnetimeInternetCheckCubit, OnetimeInternetCheckState>(
      builder: (context, state) {
        if (state is OnetimeInternetCheckLost) {
          return EconNoInternet(
            onReload: () => BlocProvider.of<OnetimeInternetCheckCubit>(context)
                .onCheckConnectionOnetime(),
          );
        }
        return widget.child.call(context);
      },
    );
  }
}
