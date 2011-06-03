//
//  OptionsLayer.m
//  Shot
//
//  Created by lokistudios on 6/2/11.
//  Copyright 2011 Loki Studios. All rights reserved.
//

#import "OptionsLayer.h"

CCMenuItemImage *menuItem0;
CCMenuItemImage *menuItem1;
CCMenuItemImage *menuItem2;
CCMenuItemImage *menuItem3;
CCMenuItemImage *menuItem4;
CCMenuItemImage *menuItem5;

@implementation OptionsLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MenuLayer *layer = [OptionsLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void) setUpMenus
{
    
	// Create some menu items
    [CCMenuItemFont setFontSize:25];
    
    menuItem0 = [CCMenuItemFont itemFromString:@"Invincible Mode"
                                        target:self
                                      selector:@selector(doInvincibleMode:)];
   
    
    menuItem1 = [CCMenuItemFont itemFromString:@"Easy Mode"
                                        target:self
                                      selector:@selector(doEasyMode:)];
    
    menuItem2 = [CCMenuItemFont itemFromString:@"Hardcore Mode"
                                        target:self
                                      selector:@selector(doHardCoreMode:)];
    
    menuItem3 = [CCMenuItemFont itemFromString:@"Standard Mode"
                                        target:self
                                      selector:@selector(doStandardMode:)];
    
    menuItem5 = [CCMenuItemFont itemFromString:@"Reset Progress"
                                        target:self
                                      selector:@selector(doReset:)];
    [CCMenuItemFont setFontSize:30];
    menuItem4 = [CCMenuItemFont itemFromString:@"Back to Main Menu"
                                        target:self
                                      selector:@selector(doMenu:)];
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        if ([standardUserDefaults boolForKey: @"INVINCIBLE"]) {
            [menuItem0 runAction:[CCTintTo actionWithDuration: 1 red:10 green:80 blue:200]];
        }
        if ([standardUserDefaults boolForKey: @"EASY"]) {
            [menuItem1 runAction:[CCTintTo actionWithDuration: 1 red:0 green: 230 blue: 10]];
        }
        if ([standardUserDefaults boolForKey: @"HARDCORE"]) {
            [menuItem2 runAction:[CCTintTo actionWithDuration: 1 red:100 green:0 blue:28]];
        }
        if ([standardUserDefaults boolForKey: @"STANDARD"]) {
            [menuItem3 runAction:[CCTintTo actionWithDuration: 1 red:180 green:160 blue:28]];
        }
    }
    //   CCMenuItemImage * menuItem2 = [CCMenuItemFont itemFromString:@"100 bullets/second"
    //     target:self
    //   selector:@selector(doSomethingTwo:)];
    
    //	CCMenuItemImage * menuItem3 = [CCMenuItemFont itemFromString:@"500 bullets/second"
    //    target:self
    //     selector:@selector(doSomethingThree:)];
    //CCMenuItemImage * menuItem4 = [CCMenuItemFont itemFromString:@"Max per update"
    //    target:self
    //    selector:@selector(doSomethingFour:)];
    
    
	// Create a menu and add your menu items to it
	CCMenu * myMenu = [CCMenu menuWithItems: menuItem0, menuItem1, menuItem3, menuItem2, menuItem5, menuItem4, nil];
    
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

- (void) doInvincibleMode: (CCMenuItem  *) menuItem 
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"Invincible.wav"];
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setBool:YES forKey:@"INVINCIBLE"];
        [standardUserDefaults setBool:NO  forKey:@"EASY"];
        [standardUserDefaults setBool:NO  forKey:@"HARDCORE"];
        [standardUserDefaults setBool:NO  forKey:@"STANDARD"];
        [standardUserDefaults synchronize];
    }
    [menuItem0 runAction:[CCTintTo actionWithDuration: 1 red:10 green:80 blue:200]];
    [menuItem1 runAction:[CCTintTo actionWithDuration: 1 red:255 green: 255 blue: 255]];
    [menuItem2 runAction:[CCTintTo actionWithDuration: 1 red:255 green: 255 blue: 255]];
    [menuItem3 runAction:[CCTintTo actionWithDuration: 1 red:255 green:255 blue:255]];
}
- (void) doEasyMode: (CCMenuItem  *) menuItem 
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"Easy.wav"];
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setBool:NO forKey:@"INVINCIBLE"];
        [standardUserDefaults setBool:YES  forKey:@"EASY"];
        [standardUserDefaults setBool:NO  forKey:@"HARDCORE"];
        [standardUserDefaults setBool:NO  forKey:@"STANDARD"];
        [standardUserDefaults synchronize];
    }
    [menuItem0 runAction:[CCTintTo actionWithDuration: 1 red:255 green: 255 blue: 255]];
    [menuItem1 runAction:[CCTintTo actionWithDuration: 1 red:0 green: 230 blue: 10]];
    [menuItem2 runAction:[CCTintTo actionWithDuration: 1 red:255 green:255 blue:255]];
    [menuItem3 runAction:[CCTintTo actionWithDuration: 1 red:255 green:255 blue:255]];
}
- (void) doHardCoreMode: (CCMenuItem  *) menuItem 
{   
    [[SimpleAudioEngine sharedEngine] playEffect:@"Hardcore.wav"];
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setBool:NO forKey:@"INVINCIBLE"];
        [standardUserDefaults setBool:NO  forKey:@"EASY"];
        [standardUserDefaults setBool:YES  forKey:@"HARDCORE"];
        [standardUserDefaults setBool:NO  forKey:@"STANDARD"];
        [standardUserDefaults synchronize];
    }
    [menuItem0 runAction:[CCTintTo actionWithDuration: 1 red:255 green: 255 blue: 255]];
    [menuItem1 runAction:[CCTintTo actionWithDuration: 1 red:255 green: 255 blue: 255]];
    [menuItem2 runAction:[CCTintTo actionWithDuration: 1 red:100 green:0 blue:28]];
    [menuItem3 runAction:[CCTintTo actionWithDuration: 1 red:255 green:255 blue:255]];
}

- (void) doStandardMode: (CCMenuItem *) menuItem
{
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"Standard.wav"];
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setBool:NO forKey:@"INVINCIBLE"];
        [standardUserDefaults setBool:NO  forKey:@"EASY"];
        [standardUserDefaults setBool:NO  forKey:@"HARDCORE"];
        [standardUserDefaults setBool:YES  forKey:@"STANDARD"];
        [standardUserDefaults synchronize];
    }
    [menuItem0 runAction:[CCTintTo actionWithDuration: 1 red:255 green: 255 blue: 255]];
    [menuItem1 runAction:[CCTintTo actionWithDuration: 1 red:255 green: 255 blue: 255]];
    [menuItem2 runAction:[CCTintTo actionWithDuration: 1 red:255 green: 255 blue: 255]];
    [menuItem3 runAction:[CCTintTo actionWithDuration: 1 red:180 green:160 blue:28]];
}
- (void) doMenu: (CCMenuItem  *) menuItem 
{
	[[CCDirector sharedDirector] replaceScene: [MenuLayer scene]];
}

- (void) doReset: (CCMenuItem  *) menuItem 
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setBool:NO  forKey:@"WAVE2"];
        [standardUserDefaults setBool:NO  forKey:@"WAVE3"];
        [standardUserDefaults setBool:NO  forKey:@"WAVE4"];
        [standardUserDefaults setBool:NO  forKey:@"WAVE5"];
        [standardUserDefaults setInteger:0 forKey:@"SCORE"];
        [standardUserDefaults synchronize];
    }
}

@end
