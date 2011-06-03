//
//  Tud.m
//  Shot
//
//  Created by lokistudios on 6/3/11.
//  Copyright 2011 Loki Studios. All rights reserved.
//

#import "Tud.h"


@implementation Tud

NSMutableArray* projsBy;


-(id) initWithTexture:(CCTexture2D*)texture rect:(CGRect)rect
{
    if( (self=[super initWithTexture:texture rect:rect]))
    {
        CGSize size = [[CCDirector sharedDirector] winSize];
        projsBy = [[NSMutableArray alloc]init]; 
        CGPoint dest1 = ccp(-size.width, -size.height/2);
        CGPoint dest2 = ccp(size.width, -size.height/2);
        CGPoint dest3 = ccp(size.width,  size.height/2);
        CGPoint dest4 = ccp(-size.width, size.height/2);
       // CGPoint dest5 = ccp(0, size.height);
        CGPoint dest6 = ccp(0, -size.height);
        NSValue *point1 = [NSValue valueWithCGPoint:dest1];
        NSValue *point2 = [NSValue valueWithCGPoint:dest2];
        NSValue *point3 = [NSValue valueWithCGPoint:dest3];
        NSValue *point4 = [NSValue valueWithCGPoint:dest4];
        //NSValue *point5 = [NSValue valueWithCGPoint:dest5];
        NSValue *point6 = [NSValue valueWithCGPoint:dest6];
        [projsBy addObject: point1];
        [projsBy addObject: point2];
        [projsBy addObject: point3];
        [projsBy addObject: point4];
        //[projsBy addObject: point5];
        [projsBy addObject: point6];
        self.health = 10;
        self.tag = ENEMYSHIP;
    }
    return self;
}

-(void) step:(ccTime) dt
{
    self.needShoot = true;
}


-(NSArray *) projectilesBy
{
    return nil;
    //return projs;
}

-(NSArray *) projectilesJumpBy
{
    return projsBy;
}

@end
