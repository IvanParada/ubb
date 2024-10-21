import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ubb/themes/colors_theme.dart';
import 'package:google_fonts/google_fonts.dart';

final List<Map<String, String>> campusData = [
  {'name': 'Concepción', 'route': '/map_screen'},
  {'name': 'Fernando May', 'route': '/map_screen_fm'},
  {'name': 'La Castilla', 'route': '/map_screen_lc'},
];

class MapsOptions extends StatelessWidget {
  const MapsOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          height: size.height * 0.15,
          width: size.width,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: size.height * 0.03),
              child: Text(
                'Mapas',
                style: GoogleFonts.roboto(
                  color: AppColors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 30,
            left: 30,
            right: 30,
          ),
          child: Text(
            'Selecciona tu campus para acceder al mapa correspondiente y explorar sus ubicaciones.',
            style: GoogleFonts.roboto(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: ListView.builder(
              itemCount: campusData.length,
              itemBuilder: (BuildContext context, int index) {
                final campus = campusData[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  color:
                      const Color.fromARGB(255, 54, 102, 168).withOpacity(0.2),
                  elevation: 0,
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 5,
                    ),
                    leading: SvgPicture.asset(
                      'assets/icons/map_icon.svg',
                      width: 22,
                      height: 22,
                      color: AppColors.primary,
                    ),
                    title: Text(
                      campus['name']!,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: SvgPicture.asset(
                      'assets/icons/arrow_right_icon.svg',
                      width: 20,
                      height: 20,
                      color: AppColors.primary,
                    ),
                    onTap: () {
                      context.push(campus['route']!);
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
