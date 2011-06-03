//
//  PlayerShip.m
//  Shot
//
//  Created by lokistudios on 6/2/11.
//  Copyright 2011 Loki Studios. All rights reserved.
//

#import "PlayerShip.h"


@implementation PlayerShip

@synthesize needShoot;
@synthesize invicible;
@synthesize health;
@synthesize hardcore;

-(id) initWithTexture:(CCTexture2D*)texture rect:(CGRect)rect
{
    if( (self=[super initWithTexture:texture rect:rect]))
    {
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults) {
            if ([standardUserDefaults boolForKey: @"INVINCIBLE"]) {
                health = 10000;
                invicible = YES;
            }
            if ([standardUserDefaults boolForKey: @"EASY"]) {
                health = 10;
            }
            if ([standardUserDefaults boolForKey: @"HARDCORE"]) {
                health = 1;
                hardcore = true;
            }
            if ([standardUserDefaults boolForKey: @"STANDARD"]) {
                health = 3;
            }
        }
    }
    return self;
}

-(void) step:(ccTime) dt
{
    if (self.visible && !hardcore) {
        needShoot = true;
    }
    
    
    // NSData *test = [NSData dataWithBytes:dest1 length:sizeof(dest1)];
    //[projs addObject: &dest1];
}


@end
