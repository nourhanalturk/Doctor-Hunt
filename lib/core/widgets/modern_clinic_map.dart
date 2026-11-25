import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tender/config/constants/constants.dart';
import 'package:tender/core/resources/manager_fonts.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/widgets/app_tile_provider.dart';
import 'package:tender/core/widgets/glass_card.dart';

class ModernClinicMap extends StatelessWidget {
  const ModernClinicMap({
    super.key,
    required this.coordinates,
    required this.location,
    this.height = 190,
  });

  final LatLng coordinates;
  final String location;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 4, bottom: 10),
            child: Row(
              children: [
                const Icon(
                  Icons.place_rounded,
                  size: 17,
                  color: Color(0xFF168A57),
                ),
                const SizedBox(width: 7),
                Text(
                  ManagerStrings.clinicLocation,
                  style: TextStyle(
                    fontFamily: ManagerFontFamily.fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF154734),
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: SizedBox(
              height: height,
              width: double.infinity,
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: coordinates,
                  initialZoom: 13,
                ),
                children: [
                  TileLayer(
                    urlTemplate: Constants.flutterMapUrl,
                    tileProvider: AppTileProviders.openStreetMap,
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: coordinates,
                        width: 42,
                        height: 42,
                        child: const Icon(
                          Icons.location_on_rounded,
                          size: 34,
                          color: Color(0xFF168A57),
                          shadows: [
                            Shadow(
                              color: Color(0x66000000),
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (location.trim().isNotEmpty) ...[
            const SizedBox(height: 9),
            Text(
              location,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: ManagerFontFamily.fontFamily,
                fontSize: 12.5,
                color: const Color(0xFF6E7B76),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
