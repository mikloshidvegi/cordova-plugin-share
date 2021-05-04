#import "MMShare.h"
#import <Cordova/CDV.h>

@implementation MMShare

- (void)share:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;

    //NSLog(@"SHARE: %@", command.arguments);
    NSString *text = [command.arguments objectAtIndex:0];
    NSString *mimeType = [command.arguments objectAtIndex:2];
    //NSLog(@"SHARE: %@", mimeType);

    if (text != nil) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

        NSMutableArray *dataToShare = [NSMutableArray new];

        if ([mimeType isEqualToString:@"text/plain"]) {
          [dataToShare addObject:text];
        } else {
          //NSLog(@"SHARE FILE!");
          NSURL *fileUrl = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:text] isDirectory:NO];
          [dataToShare addObject:fileUrl];
        }
        //NSLog(@"SHARE: %@", dataToShare);

        UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:dataToShare applicationActivities:nil];

        // fix crash on iOS8
        if (IsAtLeastiOSVersion(@"8.0")) {
            activityViewController.popoverPresentationController.sourceView = self.webView;
        }

        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
            [activityViewController popoverPresentationController].sourceRect=CGRectMake( 0,200,768,20);
        }
        
        [self.viewController presentViewController:activityViewController animated:YES completion:^{}];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
