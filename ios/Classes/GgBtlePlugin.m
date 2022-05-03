#import "GgBtlePlugin.h"
#if __has_include(<gg_btle/gg_btle-Swift.h>)
#import <gg_btle/gg_btle-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "gg_btle-Swift.h"
#endif

@implementation GgBtlePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftGgBtlePlugin registerWithRegistrar:registrar];
}
@end
