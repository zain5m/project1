// import 'package:laravel_echo/laravel_echo.dart';
// import 'package:project1/shared/network/local/cache_helper.dart';
// import 'package:project1/shared/network/local/end_point.dart';
// import 'package:project1/shared/network/remote/end_points.dart';
// import 'package:pusher_client/pusher_client.dart';

// // String PUSHER_KEY = '12345';
// // String PUSHER_CLUSTER = 'mt1';
// // String AUTH_URL = '$HOST/api/broadcasting/auth';
// // String BEARER_TOKEN = CacheHelper.getData(key: TOKEN);

// class Pusher {
//   static Echo? echo;
//   static initPusherClient() {
//     PusherOptions options;

//     options = PusherOptions(
//       cluster: 'mt1',
//       host: Hos,
//       wsPort: 6001,
//       wssPort: 6001,
//       encrypted: false,
//       auth: PusherAuth(
//         '$HOST/api/broadcasting/auth',
//         headers: {
//           'Authorization': 'Bearer ${CacheHelper.getData(key: TOKEN)}',
//         },
//       ),
//     );

//     PusherClient pusherClient = PusherClient(
//       "12345",
//       options,
//       autoConnect: false,
//       enableLogging: true,
//     );

//     pusherClient.onConnectionError((error) {
//       print(error?.message);
//     });

//     echo = Echo(
//       broadcaster: EchoBroadcasterType.Pusher,
//       client: pusherClient,
//     );

//     // return echo;
//   }
// }
