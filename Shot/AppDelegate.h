//
//  AppDelegate.h
//  Shot
//
//  Created by lokistudios on 5/16/11.
//  Copyright Loki Studios 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
