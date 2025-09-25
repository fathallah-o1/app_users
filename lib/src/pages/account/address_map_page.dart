import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class AddressController extends GetxController {
  final isLoading = true.obs;
  final cameraPos = const LatLng(32.8872, 13.1913).obs; // طرابلس افتراضيًا
  final markers = <Marker>{}.obs;
  GoogleMapController? map;

  @override
  void onInit() {
    super.onInit();
    _initLocation();
  }

  Future<void> _initLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        isLoading.value = false;
        return;
      }
      LocationPermission perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
      }
      if (perm == LocationPermission.deniedForever || perm == LocationPermission.denied) {
        isLoading.value = false;
        return;
      }

      final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final latlng = LatLng(pos.latitude, pos.longitude);
      cameraPos.value = latlng;
      markers.value = {
        Marker(markerId: const MarkerId('me'), position: latlng, infoWindow: const InfoWindow(title: 'موقعي الحالي')),
      };

      // حرّك الكاميرا إذا كانت الخريطة جاهزة
      if (map != null) {
        map!.animateCamera(CameraUpdate.newLatLngZoom(latlng, 16));
      }
    } catch (_) {
      // تجاهل الخطأ لعدم كسر الواجهة
    } finally {
      isLoading.value = false;
    }
  }

  void onMapCreated(GoogleMapController c) {
    map = c;
    // بعد إنشاء الخريطة، لو كان عندي إحداثية محدثة حرّك لها
    Future.delayed(const Duration(milliseconds: 200), () {
      map!.animateCamera(CameraUpdate.newLatLngZoom(cameraPos.value, 16));
    });
  }
}

class AddressMapPage extends StatelessWidget {
  const AddressMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(AddressController());
    return Scaffold(
      appBar: AppBar(title: const Text('العنوان')),
      body: Obx(() {
        if (c.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            Expanded(
              child: GoogleMap(
                onMapCreated: c.onMapCreated,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                initialCameraPosition: CameraPosition(target: c.cameraPos.value, zoom: 14),
                markers: c.markers.value,
                onTap: (latLng) {
                  c.markers.value = {
                    Marker(markerId: const MarkerId('drop'), position: latLng, infoWindow: const InfoWindow(title: 'نقطة التوصيل')),
                  };
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, -2))
              ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('حدد موقعك الحالي أو اضغط على الخريطة لاختيار عنوانك.',
                      textAlign: TextAlign.right),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: () {
                      final m = c.markers.isEmpty ? null : c.markers.first.position;
                      if (m != null) {
                        Get.snackbar('تم', 'تم حفظ العنوان: (${m.latitude.toStringAsFixed(5)}, ${m.longitude.toStringAsFixed(5)})',
                            snackPosition: SnackPosition.BOTTOM);
                      } else {
                        Get.snackbar('تنبيه', 'رجاءً اختر نقطة على الخريطة', snackPosition: SnackPosition.BOTTOM);
                      }
                    },
                    child: const Text('حفظ العنوان'),
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}