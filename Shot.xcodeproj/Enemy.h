//
//  Enemy.h
//  Shot
//
//  Created by lokistudios on 6/2/11.
//  Copyright 2011 Loki Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Enums.h"

@interface Enemy : CCSprite {

}

-(NSArray *) projectilesBy;
-(NSArray *) projectilesJumpBy;

@property (nonatomic) BOOL needShoot;
@property (nonatomic) int health;

@end
