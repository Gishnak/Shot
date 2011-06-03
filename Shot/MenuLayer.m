//
//  MenuLayer.m
//  Shot
//
//  Created by lokistudios on 5/31/11.
//  Copyright 2011 Loki Studios. All rights reserved.
//

#import "MenuLayer.h"
#import "GameLayer.h"
#import "OptionsLayer.h"
#import "WaveSelectorLayer.h"


@implementation MenuLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MenuLayer *layer = [MenuLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


//NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
//if (standardUserDefaults) {
   // if ([standardUserDefaults boolForKey: @"WAVE1"]) {
  //      [myMenu addChild: menuItem0];
  //  }
    
    
-(void) setUpMenus
{
    CGSize size = [[CCDirector sharedDirector] winSize];
	// Create some menu items
    [CCMenuItemFont setFontSize:30];
    CCMenuItemImage * menuItem0 = [CCMenuItemFont itemFromString:@"Start Game!"
                                                          target:self
                                      	                  selector:@selector(doStartGame:)];
    CCMenuItemImage * menuItem1 = [CCMenuItemFont itemFromString:@"Options"
                                                          target:self
                                                        selector:@selector(doOptions:)];
	CCMenu * myMenu = [CCMenu menuWithItems: menuItem0, menuItem1, nil];
    
	// Arrange the menu items vertically
	[myMenu alignItemsVertically];
    
    myMenu.position = ccp (size.width/2 + 73, 58);
    
	[self addChild:myMenu];
    
        [CCMenuItemFont setFontSize:26];
    CCMenuItemImage * menuItem2 = [CCMenuItemFont itemFromString:@"Waves"
                                                          target:self
                                                        selector:@selector(doWaveSelector:)];
    CCMenu * myMenu2 = [CCMenu menuWithItems: menuItem2, nil];
    

    myMenu2.position = ccp(size.width/2 - 115, 28);
    
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        if ([standardUserDefaults boolForKey: @"WAVE2"]) {
                [self addChild:myMenu2];
        }
        int score = [standardUserDefaults integerForKey:@"SCORE"];
        if (score >0) {
        CCLabelTTF *countLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Score: %d", score] fontName:@"Marker Felt" fontSize:22];
            [countLabel runAction:[CCFadeOut actionWithDuration:5]];
                                  
        
        [self addChild:countLabel z:0 tag:0];
        countLabel.position = ccp(size.width/2,size.height/2 + 110);
        countLabel.opacity = 200;
        }
    }
    


}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
		// ask director the the window size

        CGSize size = [[CCDirector sharedDirector] winSize];
        CCSprite * titleImg = [CCSprite spriteWithFile:@"Title.png"];
        titleImg.position = ccp(size.width/2, size.height/2);
        [self addChild: titleImg];
        [self setUpMenus];
		//CGSize size = [[CCDirector sharedDirector] winSize];
        
        
        
	}
	return self;
}

- (void) doStartGame: (CCMenuItem  *) menuItem 
{
	[[CCDirector sharedDirector] replaceScene: [GameLayer scene]];
}
- (void) doOptions: (CCMenuItem  *) menuItem 
{
	[[CCDirector sharedDirector] replaceScene: [OptionsLayer scene]];
}
    
- (void) doWaveSelector: (CCMenuItem  *) menuItem 
{
        [[CCDirector sharedDirector] replaceScene: [WaveSelectorLayer scene]];
}

@end
