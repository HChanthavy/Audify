import 'package:audify/service/http_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:just_audio/just_audio.dart';

AudioPlayer audioPlayer = AudioPlayer();
final user = FirebaseAuth.instance.currentUser!;
HttpService httpService = HttpService();