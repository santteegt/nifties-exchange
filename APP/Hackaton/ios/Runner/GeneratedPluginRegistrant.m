//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <fast_qr_reader_view/FastQrReaderViewPlugin.h>
#import <firebase_messaging/FirebaseMessagingPlugin.h>
#import <flutter_facebook_login/FacebookLoginPlugin.h>
#import <flutter_webview_plugin/FlutterWebviewPlugin.h>
#import <google_maps_flutter/GoogleMapsPlugin.h>
#import <google_sign_in/GoogleSignInPlugin.h>
#import <location/LocationPlugin.h>
#import <share/SharePlugin.h>
#import <shared_preferences/SharedPreferencesPlugin.h>
#import <url_launcher/UrlLauncherPlugin.h>
#import <vibration/VibrationPlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FastQrReaderViewPlugin registerWithRegistrar:[registry registrarForPlugin:@"FastQrReaderViewPlugin"]];
  [FLTFirebaseMessagingPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseMessagingPlugin"]];
  [FacebookLoginPlugin registerWithRegistrar:[registry registrarForPlugin:@"FacebookLoginPlugin"]];
  [FlutterWebviewPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterWebviewPlugin"]];
  [FLTGoogleMapsPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTGoogleMapsPlugin"]];
  [FLTGoogleSignInPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTGoogleSignInPlugin"]];
  [LocationPlugin registerWithRegistrar:[registry registrarForPlugin:@"LocationPlugin"]];
  [FLTSharePlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharePlugin"]];
  [FLTSharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharedPreferencesPlugin"]];
  [FLTUrlLauncherPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTUrlLauncherPlugin"]];
  [VibrationPlugin registerWithRegistrar:[registry registrarForPlugin:@"VibrationPlugin"]];
}

@end
