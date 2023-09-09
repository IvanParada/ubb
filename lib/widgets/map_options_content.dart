import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final List<String> campusNames = [
  'map_screen',
  'map_screen_fm',
  'map_screen_lc',
];

final Map<String, String> campusImages = {
  'map_screen': 'assets/concepcion/Concepcion.jpg',
  'map_screen_fm': 'assets/fernando_may/Fernando_May.jpg',
  'map_screen_lc': 'assets/la_castilla/La_Castilla.jpg',
};

class MapsOptions extends StatelessWidget {
  const MapsOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            FadeInDown(
              child: const Center(),
            ),
            const SizedBox(height: 10),
            Center(
              child: FadeInDown(
                child: const Center(
                    child: FaIcon(
                  FontAwesomeIcons.mapLocationDot,
                  color: Colors.white,
                  size: 80,
                )),
              ),
            ),
            const SizedBox(height: 40),
            FadeInLeft(
              child: const Center(
                child: Text(
                  'Mapas disponibles.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: BounceInUp(
                child: Swiper(
                  autoplay: false,
                  itemCount: campusNames.length,
                  layout: SwiperLayout.STACK,
                  itemWidth: size.width * 0.7,
                  itemHeight: size.height * 0.5,
                  itemBuilder: (BuildContext context, int index) {
                    final campusName = campusNames[index];
                    final campusImage = campusImages[campusName];

                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(context, campusName),
                      child: Hero(
                        tag: campusName,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FadeInImage(
                            placeholder:
                                const AssetImage('assets/no-image.jpg'),
                            image: AssetImage(campusImage ??
                                'assets/no-image.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
