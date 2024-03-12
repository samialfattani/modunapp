import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:modunapp/shared/colors.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class Web extends StatefulWidget 
{
  Web({Key? key, }) : super(key: key);

  @override
  State<Web> createState() => _WebState();
}

class _WebState extends State<Web> 
{
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late InAppWebViewController _webViewController;

  double progress = 0;  
  // String _url = "https://sami.netzerooo.com";
  String _url = "https://modunsa.com";

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;


  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }  

  // Version: 6.0.0
  final InAppWebViewSettings inAppWebViewSettings = InAppWebViewSettings(
    //CrosPlatform
    disableHorizontalScroll: false,
    disableVerticalScroll: false,
    supportZoom: true,
    verticalScrollBarEnabled: true,

    //Android
    useHybridComposition: true,

    //ios
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
  );

  // final InAppWebViewGroupOptions inAppWebViewOptions = InAppWebViewGroupOptions(
  //     crossPlatform: InAppWebViewOptions(
  //       disableHorizontalScroll: false,
  //       disableVerticalScroll: false,
  //       supportZoom: false,
  //       verticalScrollBarEnabled: false,
  //     ),

  //     android: AndroidInAppWebViewOptions(
  //       useHybridComposition: true,
  //     ),

  //     ios: IOSInAppWebViewOptions(
  //       allowsInlineMediaPlayback: true,
  //     )
  // );


  @override
  Widget build(BuildContext context) 
  {
    log('Web build ..... ');

    return 
      PopScope(
        canPop: false, //false --> blocks the current route from being popped.
        
        // the back button 
        onPopInvoked: (didPop) 
        {
          //do your logic here:
          // showToast(msg: "msg", state: ToastStates.SUCCESS);
          _webViewController.goBack();
        },
        child: get_scaffold()
      );

    
  }


  Widget get_scaffold()
  {
    return 
      Scaffold(
        key: scaffoldKey,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(20.0), // Set the desired height here
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: PRIMARY,
              foregroundColor: WHITE,
              centerTitle: false,
              title: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Row(
                        children: [
                          SizedBox(width: 2.w,),
                          Icon(Icons.arrow_back_ios, size: 14 ),
                          SizedBox(width: 2.w,),
                        ],
                      ),
                      onTap: () => _webViewController.goBack() ,
                    ),
                    
                    SizedBox(width: 5.w,),
                    Text("modunsa.com", style: TextStyle(fontSize: 14),),
                    SizedBox(width: 5.w,),

                    InkWell(
                      child: Row(
                        children: [
                          SizedBox(width: 2.w,),
                          Icon(Icons.arrow_forward_ios, size: 14,),
                          SizedBox(width: 2.w,),
                        ],
                      ),
                      onTap: () => _webViewController.goForward() ,
                    ),
                    
                      
                  ],)
              
              // leading: 
              

            ),
          ),
        body: 
          Column(
            children: <Widget>
            [
              // Show the progress bar until 100%
              if (progress < 1.0)
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: LIGHT_PRIMARY,
                  valueColor: AlwaysStoppedAnimation<Color>(SECONDARY),
                ),

              
              if( _connectionStatus == ConnectivityResult.none )
                Center(                
                  child: 
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text('لا يوجد اتصال بالانترنت!', style: TextStyle(color: Colors.red[800], fontWeight: FontWeight.bold),))
                ),

              if( _connectionStatus == ConnectivityResult.none)
                Center(                
                  child: Text('NO Internet Connection!', style: TextStyle(color: Colors.red[800], fontWeight: FontWeight.bold),)
                ),
              
              Expanded(
                child: InAppWebView(
                  // initialUrlRequest: URLRequest(url: Uri.parse( _url ),),
                  // initialOptions: inAppWebViewOptions,
                  
                  // Version 6.0.0
                  initialUrlRequest: URLRequest(url: WebUri(_url),),
                  initialSettings: inAppWebViewSettings,

                  onWebViewCreated: (InAppWebViewController _controler) { 
                    _webViewController = _controler;
                  },

                  onLoadStart: (InAppWebViewController _controler, Uri? _uri) {
                    log(_uri.toString());
                  },

                  // بعد تحميل الصفحة
                  onLoadStop: (InAppWebViewController _controler, Uri? _uri) async { },

                  onProgressChanged: (controller, newProgress) {
                    setState(() { progress = newProgress / 100; });
                  },
                ),
              ),
            ],
          ),
      );    

  }


  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async 
  {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }  

} //end class
