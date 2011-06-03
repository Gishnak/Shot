//
//  Sput.m
//  Shot
//
//  Created by lokistudios on 6/2/11.
//  Copyright 2011 Loki Studios. All rights reserved.
//

#import "Sput.h"


@implementation Sput


NSMutableArray* projs;


-(id) initWithTexture:(CCTexture2D*)texture rect:(CGRect)rect
{
    if( (self=[super initWithTexture:texture rect:rect]))
    {
        projs = [[NSMutableArray alloc]init]; 
        CGPoint dest1 = ccp(-50, -500);
        CGPoint dest2 = ccp(0, -500);
        CGPoint dest3 = ccp(50, -500);
        NSValue *point1 = [NSValue valueWithCGPoint:dest1];
        NSValue *point2 = [NSValue valueWithCGPoint:dest2];
        NSValue *point3 = [NSValue valueWithCGPoint:dest3];
        [projs addObject: point1];
        [projs addObject: point2];
        [projs addObject: point3];
        self.health = 5;
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
    return projs;
}

@end
