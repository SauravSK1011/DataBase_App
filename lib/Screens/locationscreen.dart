import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart' as geoloco;
import 'package:geolocator/geolocator.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mongoapp/Screens/profile_page.dart';
import 'package:mongoapp/Screens/services/auth.dart';
import 'package:mongoapp/Screens/userprofile.dart';
import 'package:mongoapp/common/theme_helper.dart';
import 'package:mongoapp/models/user.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key,required this.user}) : super(key: key);
final UsersModel user;
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late GoogleMapController googlemapcontrollar;
  Map<MarkerId, Marker> currentmarker = {};
  // MarkerId tempId = MarkerId("ABC");
  String address = "address";

  late Position position;
  getmarker(double lat, double lang) {
    MarkerId markerId = MarkerId(lat.toString() + lang.toString());
    Marker marker = Marker(
      markerId: markerId,
      position: LatLng(lat, lang),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(title: address),
    );
    setState(() {
      currentmarker[markerId] = marker;
    });
  }

  getcurrentposition() async {
    // Marker marker = Marker(
    //     markerId: tempId,
    //     position: LatLng(-89.999, 73.125),
    //     icon: BitmapDescriptor.defaultMarker,
    //     infoWindow: InfoWindow(snippet: "Address"));
    //     currentmarker[tempId ] = marker;

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position currentpoition =
        await GeolocatorPlatform.instance.getCurrentPosition();
    setState(() {
      position = currentpoition;
    });
  }

  Future<void> GetAddressFromLatLong(double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    var taddress =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {
      address = taddress;
    });
  }

  @override
  void initState() {
    super.initState();
    getcurrentposition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          child: GoogleMap(
            onTap: (val) async {
              setState(() {
                currentmarker = {};
              });
              // final coordinates=geoloco.Coordinates(val.latitude, val.longitude);
              await GetAddressFromLatLong(val.latitude, val.longitude);

              getmarker(val.latitude, val.longitude);
            },
            mapType: MapType.normal,
            compassEnabled: true,
            trafficEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              setState(() {
                googlemapcontrollar = controller;
              });
            },
            initialCameraPosition:
                const CameraPosition(target: LatLng(19, 76), zoom: 15),
            markers: Set<Marker>.of(currentmarker.values),
          ),
        ),
        Positioned(
          left: (MediaQuery.of(context).size.width - 230) / 2,
          top: MediaQuery.of(context).size.height - 280,
          child: Container(
            decoration: ThemeHelper().buttonBoxDecoration(context),
            child: GlassContainer(
              height: 130,
              blur: 3,
              shadowStrength: 10,
              opacity: 0.2,
              width: 230,
              //--code to remove border
              border: Border.fromBorderSide(BorderSide.none),
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        address,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    
                    // Container(
                    //   decoration: ThemeHelper().buttonBoxDecoration(context),
                    // child:
                    ElevatedButton(
                        style: ThemeHelper().buttonStyle(),
                        onPressed: () async {
                           Auth().addaddress(widget.user.email,address).then((val) {
                            if (val.data["Massage"] == "Done") {
                              Fluttertoast.showToast(msg: "Done");
                              Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => ProfilePage(user: widget.user,)),
                                        (Route<dynamic> route) => false);

                              
                            }
                          });
                        },
                        child: Text("Save")),
                    // )
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
