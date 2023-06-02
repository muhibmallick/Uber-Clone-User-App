import 'package:firebase_auth/firebase_auth.dart';

import '../Models/direction_details_info.dart';
import '../Models/user_models.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
UserModel? userModelCurrentInfo;
List dList = []; //online-active drivers Information List
DirectionDetailsInfo? tripDirectionDetailsInfo;
String? chosenDriverId="";
String cloudMessagingServerToken = "key=AAAAUHMYmto:APA91bEVymHFjXyf1sL3VS9S5p3jBcsqmXT4oBRZTr9t0x6iY_Bf_PAEYfoyfzmKtuRSDaMSoGtLBKAIR-9JRijUiCDH-GKX-kQROEitoa_EUJXyzE31St8v_8O02fuBY2Ox2h3L6-pQ";
String userDropOffAddress = "";
String driverCarDetails="";
String driverName="";
String driverPhone="";
double countRatingStars=0.0;
String titleStarsRating="";