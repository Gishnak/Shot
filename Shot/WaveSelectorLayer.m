//
//  WaveSelectorLayer.m
//  Shot
//
//  Created by lokistudios on 6/3/11.
//  Copyright 2011 Loki Studios. All rights reserved.
//

#import "WaveSelectorLayer.h"

CCMenuItemImage *menuItem0;
CCMenuItemImage *menuItem1;
CCMenuItemImage *menuItem2;
CCMenuItemImage *menuItem3;
CCMenuItemImage *menuItem4;
CCMenuItemImage *menuItem5;

@implementation WaveSelectorLayer
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	WaveSelectorLayer *layer = [WaveSelectorLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void) setUpMenus
{
    
	// Create some menu items
    [CCMenuItemFont setFontSize:25];
    
    menuItem0 = [CCMenuItemFont itemFromString:@"Wave 1"
                                        target:self
                                      selector:@selector(doWave1:)];
    
    
    menuItem1 = [CCMenuItemFont itemFromString:@"Wave 2"
                                        target:self
                                      selector:@selector(doWave2:)];
    
    menuItem2 = [CCMenuItemFont itemFromString:@"Wave 3"
                                        target:self
                                      selector:@selector(doWave3:)];
    
    menuItem3 = [CCMenuItemFont itemFromString:@"Wave 4"
                                        target:self
                                      selector:@selector(doWave4:)];
    
    menuItem4 = [CCMenuItemFont itemFromString:@"Wave 5"
                                        target:self
                                      selector:@selector(doWave5:)];
    [CCMenuItemFont setFontSize:30];
    menuItem5 = [CCMenuItemFont itemFromString:@"Back to Main Menu"
                                        target:self
                                      selector:@selector(doMenu:)];
    
   // NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
	// Create a menu and add your menu items to it
	CCMenu * myMenu = [CCMenu menuWithItems: menuItem0, menuItem5, nil];
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        if ([standardUserDefaults boolForKey: @"WAVE2"]) {
            [myMenu addChild: menuItem1];
        }
        if ([standardUserDefaults boolForKey: @"WAVE3"]) {
            [myMenu addChild: menuItem2];
        }
        if ([standardUserDefaults boolForKey: @"WAVE4"]) {
            [myMenu addChild: menuItem3];
        }
        if ([standardUserDefaults boolForKey: @"WAVE5"]) {
            [myMenu addChild: menuItem4];
        }
    }
    
	// Arrange the menu items vertically
    [myMenu alignItemsVertically];
    
	// add the menu to your scene
	[self addChild:myMenu];
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
		// ask director the the window size
        [self setUpMenus];
		//CGSize size = [[CCDirector sharedDirector] winSize];
        
        
        
	}
	return self;
}

- (void) doWave1: (CCMenuItem  *) menuItem 
{
    [[CCDirector sharedDirector] replaceScene: [GameLayer scene]];
}
- (void) doWave2: (CCMenuItem  *) menuItem 
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setBool:YES forKey:@"WAVE2START"];
    }
    [[CCDirector sharedDirector] replaceScene: [GameLayer scene]];

}
- (void) doWave3: (CCMenuItem  *) menuItem 
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setBool:YES forKey:@"WAVE3START"];
    }
    [[CCDirector sharedDirector] replaceScene: [GameLayer scene]];
}
- (void) doWave4: (CCMenuItem  *) menuItem 
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setBool:YES forKey:@"WAVE4START"];
    }
    [[CCDirector sharedDirector] replaceScene: [GameLayer scene]];
}
- (void) doWave5: (CCMenuItem  *) menuItem 
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setBool:YES forKey:@"WAVE5START"];
    }
    [[CCDirector sharedDirector] replaceScene: [GameLayer scene]];
}
- (void) doMenu: (CCMenuItem  *) menuItem 
{
    [[CCDirector sharedDirector] replaceScene: [MenuLayer scene]];
}

@end
