import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/size_const.dart';
import 'package:e_con/core/routes/app_routes.dart';
import 'package:e_con/core/themes/text_theme.dart';
import 'package:e_con/src/presentations/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TeacherGenBarcodePage extends StatefulWidget {
  const TeacherGenBarcodePage({super.key});

  @override
  State<TeacherGenBarcodePage> createState() => _TeacherGenBarcodePageState();
}

class _TeacherGenBarcodePageState extends State<TeacherGenBarcodePage> {
  final TextEditingController dateController = TextEditingController();
  bool isNeedLocation = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Palette.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close_rounded),
        ),
        title: Text(
          'Barcode Absen',
          style: kTextHeme.headline5?.copyWith(
            color: Palette.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(AppSize.space[3]),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Matakuliah',
                          style: kTextHeme.subtitle1
                              ?.copyWith(color: Palette.disable),
                        ),
                        Text(
                          'Matematika Dasar 1',
                          style: kTextHeme.headline4?.copyWith(
                            color: Palette.primary,
                          ),
                        ),
                        AppSize.verticalSpace[3],
                        _buildAbsentTile(
                          title: 'Kelas A (2019)',
                          iconPath: 'assets/icons/school.svg',
                        ),
                        AppSize.verticalSpace[1],
                        _buildAbsentTile(
                          title: '10.00 - 12.00 WITA',
                          iconPath: 'assets/icons/time.svg',
                        ),
                        AppSize.verticalSpace[1],
                        _buildAbsentTile(
                          title: 'Senin, 15 Januari 2022',
                          iconPath: 'assets/icons/date.svg',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                      AppSize.space[3],
                    ),
                    child: Column(
                      children: [
                        InputField(
                          controller: dateController,
                        ),
                        AppSize.verticalSpace[2],
                        DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: CheckboxListTile(
                              title: Text(
                                'Deteksi Lokasi',
                                style: kTextHeme.subtitle1?.copyWith(
                                  color: Palette.primary,
                                ),
                              ),
                              checkColor: Palette.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              checkboxShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              value: isNeedLocation,
                              onChanged: (val) {}),
                        ),
                        AppSize.verticalSpace[3],
                        CustomButton(
                          text: 'Lanjutkan',
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoute.barcodeAbsent,
                            );
                          },
                          height: 54,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildAbsentTile({required String title, required String iconPath}) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Palette.onPrimary,
          ),
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              color: Colors.white,
            ),
          ),
        ),
        AppSize.horizontalSpace[2],
        Expanded(
          child: Text(
            title,
            style: kTextHeme.subtitle1?.copyWith(
              color: Palette.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

class InputField extends StatefulWidget {
  final TextEditingController controller;
  const InputField({
    super.key,
    required this.controller,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: (value) {},
      keyboardType: TextInputType.text,
      style: kTextHeme.subtitle1?.copyWith(
        color: Palette.onPrimary,
      ),
      cursorColor: Palette.primary,
      decoration: InputDecoration(
        hintText: 'Berlaku Hingga',
        hintStyle: kTextHeme.subtitle1,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Palette.background),
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Palette.primary),
          borderRadius: BorderRadius.circular(12.0),
        ),
        // errorText: !state.isEmailValid
        //     ? 'Please ensure the email entered is valid'
        //     : null,
        // labelText: 'Email',
      ),
    );
  }
}
