//
//  LiveShowViewController.h
//  LiveVideoCoreDemo
//
//  Created by Alex.Shi on 16/3/2.
//  Copyright © 2016年 com.Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveVideoCoreSDK.h"
#import "ASValueTrackingSlider.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface LiveShowViewController : UIViewController<LIVEVCSessionDelegate, ASValueTrackingSliderDataSource, ASValueTrackingSliderDelegate>

@property (atomic, copy) NSURL* RtmpUrl;
@property (atomic, assign) Boolean IsHorizontal;
@property(atomic, retain) id<IJKMediaPlayback> player;

- (void) LiveConnectionStatusChanged: (LIVE_VCSessionState) sessionState;

@end
