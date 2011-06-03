//
//  HelloWorldLayer.h
//  Shot
//
//  Created by lokistudios on 5/16/11.
//  Copyright Loki Studios 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "PlayerShip.h"
#import "Enemy.h"
#import "MenuLayer.h"
#import "SimpleAudioEngine.h"
#import "Sput.h"
#import "Tud.h"
#import "Enemy.h"




// HelloWorldLayer
@interface GameLayer : CCLayer
{
    PlayerShip* ship;
    CCSprite* bg;
    CCSprite* bg2;
    CCMenu* myMenu;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
- (void) doWaveOne;
- (void) doWaveTwo;
- (void) doWaveFourTuds;
- (void) doWaveFourSputs;
@end
