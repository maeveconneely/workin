import 'dart:async';

//import 'package:pusher/pusher.dart';
import 'package:pusher_websocket_flutter/pusher.dart';

class PusherService {
  Event lastEvent;
  String lastConnectionState;
  Channel channel;
  Pusher pusher;
  StreamController<String> _eventData = StreamController<String>();
  Sink get _inEventData => _eventData.sink;
  Stream get eventStream => _eventData.stream;


  Future<void> initPusher() async {
    
    try {
      await Pusher.init("7b235cd4262e5f934f8f", PusherOptions(cluster: "us2"));
    } on Exception catch (e) {
      print(e); //PlatformException
    }
  }

  void connectPusher() {
    Pusher.connect(
        onConnectionStateChange: (ConnectionStateChange connectionState) async {
      lastConnectionState = connectionState.currentState;
    }, onError: (ConnectionError e) {
      print("Error: ${e.message}");
    });
  }

  Future<void> subscribePusher(String channelName) async {
    
    channel = await Pusher.subscribe(channelName);
  }

  void unSubscribePusher(String channelName) {
    Pusher.unsubscribe(channelName);
  }

 

  void bindEvent(String eventName) {
    channel.bind(eventName, (last) {
      final String data = last.data;
      _inEventData.add(data);
    });
  }

  void unbindEvent(String eventName) {
    channel.unbind(eventName);
    _eventData.close();
  }

  Future<void> firePusher(String channelName, String eventName) async {
    await initPusher();
    connectPusher();
    await subscribePusher(channelName);
    bindEvent(eventName);
  }

}