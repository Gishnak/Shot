//
//  PlayerShip.h
//  Shot
//
//  Created by lokistudios on 6/2/11.
//  Copyright 2011 Loki Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface PlayerShip : CCSprite {
    
}

@property (nonatomic) BOOL needShoot;
@property (nonatomic) BOOL invicible;
@property (nonatomic) int health;
@property (nonatomic) BOOL hardcore;
@end
