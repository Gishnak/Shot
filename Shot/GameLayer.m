//
//  GameLayer.m
//  Shot
//
//  Created by lokistudios on 5/16/11.
//  Copyright 2011 Loki Studios. All rights reserved.
//

#import "GameLayer.h"




@implementation GameLayer


NSMutableArray *projectiles;
NSMutableArray *enemies;
NSMutableArray *enemyProjectiles;

int wave1count;
int wave1repeatcount;
int wave2x;
int wave2count;
int wave3y;
int wave3count;
int wave4tudy;
int wave4tudcount;
int wave4sputcount;
int score;
BOOL wave1sound;
BOOL wave2sound;
BOOL wave3sound;
BOOL wave4sound;


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


-(void) setUpMenus
{
    
	// Create some menu items
    [CCMenuItemFont setFontSize:8];
    CCMenuItemImage * menuItem0 = [CCMenuItemFont itemFromString:@"Wave 1"
                                                          target:self
                                                        selector:@selector(doWaveOne)];
    CCMenuItemImage * menuItem1 = [CCMenuItemFont itemFromString:@"Wave 2"
                                                          target:self
                                                        selector:@selector(doWaveTwo)];
    CCMenuItemImage * menuItem2 = [CCMenuItemFont itemFromString:@"Wave 3"
                                                         target:self
                                                        selector:@selector(doWaveThree)];
    CCMenuItemImage * menuItem3 = [CCMenuItemFont itemFromString:@"Wave 4"
                                                          target:self
                                                        selector:@selector(doWaveFour)];
    CCMenuItemImage * menuItem4 = [CCMenuItemFont itemFromString:@"Results"
                                                          target:self
                                                        selector:@selector(doResults)];

    
    
	 //reate a menu and add your menu items to it
	myMenu = [CCMenu menuWithItems:  menuItem0, menuItem1, menuItem2, menuItem3, menuItem4, nil];
    

    myMenu.position = ccp(25, 50);
    
	// Arrange the menu items vertically
	[myMenu alignItemsVertically];
    
	
	[self addChild:myMenu];
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {

        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"DonutTime.mp3"]; 
        wave1count = 5;
        wave2count = 3;
        wave1repeatcount = 3;
        wave2x = 0;
        wave3y = 420;
        wave3count = 3;
        wave4tudy = 190;
        wave4sputcount = 18;
        wave4tudcount = 2;
        wave1sound = YES;
        wave2sound = YES;
        wave3sound = YES;
        wave4sound = YES;
        
        score = 0;
        
        projectiles = [[NSMutableArray alloc] init];
        enemies = [[NSMutableArray alloc] init];
        enemyProjectiles = [[NSMutableArray alloc] init];
        
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        
        bg = [CCSprite spriteWithFile:@"bg.png"];
        bg.position = ccp(size.width/2, bg.contentSize.height - size.height);
        bg2 = [CCSprite spriteWithFile:@"bg.png"];
        bg2.position = ccp(size.width/2, bg2.contentSize.height + size.height - 6);
    
        [self addChild:bg2];
        [self addChild:bg];

       // [self setUpMenus];
        ship = [PlayerShip spriteWithFile: @"Main-Ship.png"];
        [ship schedule:@selector(step:) interval:.05];
        ship.scaleX = .2;
        ship.scaleY = .2;
        ship.position = ccp(size.width/2, 100);
        [self addChild:ship];
        [self schedule:@selector(step:)];
        [self schedule:@selector(scorer) interval:1];
        
        

        
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        if (standardUserDefaults) {
            if ([standardUserDefaults boolForKey: @"WAVE2START"]) {
                [standardUserDefaults setBool:NO forKey:@"WAVE2START"];
                [self runAction: [CCSequence actions: [CCDelayTime actionWithDuration: .5], [CCCallFunc actionWithTarget:self selector:@selector(doWaveTwo)], nil]];
            }
            else if ([standardUserDefaults boolForKey: @"WAVE3START"]) {
                [standardUserDefaults setBool:NO forKey:@"WAVE3START"];
                [self runAction: [CCSequence actions: [CCDelayTime actionWithDuration: .5], [CCCallFunc actionWithTarget:self selector:@selector(doWaveThree)], nil]];
            }
            else if ([standardUserDefaults boolForKey: @"WAVE4START"]) {
                [standardUserDefaults setBool:NO forKey:@"WAVE4START"];
                [self runAction: [CCSequence actions: [CCDelayTime actionWithDuration: .5], [CCCallFunc actionWithTarget:self selector:@selector(doWaveFour)], nil]];
            }
            else if ([standardUserDefaults boolForKey: @"WAVE5START"]) {
                [standardUserDefaults setBool:NO forKey:@"WAVE5START"];
                [self runAction: [CCSequence actions: [CCDelayTime actionWithDuration: .5], [CCCallFunc actionWithTarget:self selector:@selector(doWaveFive)], nil]];
            }
            else {
                [self runAction: [CCSequence actions: [CCDelayTime actionWithDuration: .5], [CCCallFunc actionWithTarget:self selector:@selector(doWaveOne)], nil]];
            }
        }

	}
	return self;
}

- (void)scorer
{
    score++;
}

- (void)panForTranslation:(CGPoint)translation {
    if (ship) {
        CGPoint newPos = ccpAdd(ship.position, translation);
        ship.position = newPos;
    }
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    return TRUE;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation);
    [self panForTranslation:translation];
}


-(void)spriteMoveFinished:(id)sender {
    CCSprite *sprite = (CCSprite *)sender;
    [self removeChild:sprite cleanup:YES];
    if (sprite.tag == PLAYERPROJECTILE) {    
        [projectiles removeObject:sprite];
    }
    else if (sprite.tag == ENEMYPROJECTILE) {
        [enemyProjectiles removeObject:sprite];
    }
    else if (sprite.tag == ENEMYSHIP) {
        [enemies removeObject:sprite];
    }
}



-(void) step:(ccTime) dt
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    bg.position = ccp (bg.position.x, bg.position.y-1);
    bg2.position = ccp (bg2.position.x, bg2.position.y-1);
    if (bg.position.y < 0 - size.height) {
        bg.position = ccp(size.width/2, bg2.position.y + bg.contentSize.height - 12);
    }
    if (bg2.position.y < 0 - size.height) {
        bg2.position = ccp(size.width/2, bg.position.y + bg2.contentSize.height - 6);
    }


   // NSLog(@"curr y: %f content height: %f sheight: %f", bg.position.y, bg.contentSize.height, size.height);
    if (ship.needShoot) {
        ship.needShoot = false;
        
        CCSprite *projectile = [CCSprite spriteWithFile:@"blue_bullet_icon.png" 
                                                   rect:CGRectMake(0, 0, 20, 20)];
        //projectile.position = ccp(20, winSize.height/2);
        projectile.position = ccp(ship.position.x+2, ship.position.y+30);
        [self addChild:projectile];    
        
        int realX = ship.position.x;
        int realY = 500;
        CGPoint realDest = ccp(realX, realY);
        //CGPoint realDest = ccp(winSize.width/2, 400);
        
        int offRealX = realX - projectile.position.x;
        int offRealY = realY - projectile.position.y;
        float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
        float velocity = 480/1; // 480pixels/1sec
        float realMoveDuration = length/velocity;
        
        [projectile runAction:[CCSequence actions:
                               [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
                               [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                               nil]];
        projectile.tag = PLAYERPROJECTILE;
        [projectiles addObject:projectile];
        
    }
    for (Enemy *enemy in enemies) {
        if (enemy.needShoot) {
            enemy.needShoot = false;
            for (NSValue *destVal in [enemy projectilesBy]) {
                CGPoint realDest = [destVal CGPointValue];
                int realX = realDest.x;
                int realY = realDest.y;
                CCSprite *projectile = [CCSprite spriteWithFile:@"bullet-yellow.png" 
                                                           rect:CGRectMake(0, 0, 20, 20)];
                projectile.position = ccp(enemy.position.x+2, enemy.position.y-10);
                projectile.tag = ENEMYPROJECTILE;
                [enemyProjectiles addObject: projectile];
                [self addChild:projectile];    
                
                
                int offRealX = realX - projectile.position.x;
                int offRealY = realY - projectile.position.y;
                float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
                float velocity = 480/1; // 480pixels/1sec
                float realMoveDuration = length/velocity;
                
                [projectile runAction:[CCSequence actions:
                                       [CCMoveBy actionWithDuration:realMoveDuration position:realDest],
                                       [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                                       nil]];
            }
            for (NSValue *destVal in [enemy projectilesJumpBy]) {
                CGPoint realDest = [destVal CGPointValue];
                CCSprite *projectile = [CCSprite spriteWithFile:@"bullet_ball_red.png" 
                                                           rect:CGRectMake(0, 0, 20, 20)];
                projectile.position = ccp(enemy.position.x+2, enemy.position.y-10);
                projectile.tag = ENEMYPROJECTILE;
                projectile.scaleX = .7;
                projectile.scaleY = .7;
                [enemyProjectiles addObject: projectile];
                [self addChild:projectile];    
                
                
                float realMoveDuration = 5;
                
                [projectile runAction:[CCSequence actions:
                                     //  [CCMoveBy actionWithDuration:realMoveDuration position:realDest],
                                       [CCJumpBy actionWithDuration:realMoveDuration position:realDest height:200 jumps:1],
                                       [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                                       nil]];
            }
        }
    }
    NSMutableArray *projectilesToDelete = [[NSMutableArray alloc]init];
    NSMutableArray *enemiesToDelete = [[NSMutableArray alloc]init];
    for (Enemy *enemy in enemies) {
        CGRect targetRect = CGRectMake(enemy.position.x - (enemy.contentSize.width * enemy.scaleX/2), enemy.position.y - (enemy.contentSize.height * enemy.scaleY/2), enemy.contentSize.width * enemy.scaleX, enemy.contentSize.height * enemy.scaleY);
        for (CCSprite *projectile in projectiles) {
            CGRect projectileRect = CGRectMake(projectile.position.x - (projectile.contentSize.width/2), projectile.position.y - (projectile.contentSize.height/2), projectile.contentSize.width, projectile.contentSize.height);
            if (CGRectIntersectsRect(projectileRect, targetRect)) {
                [projectilesToDelete addObject:projectile];
                enemy.health--;
                if (enemy.health <=0) {
                    [enemiesToDelete addObject:enemy];
                }
            }
        }
        
    }
	
    for (CCSprite *projectile in projectilesToDelete) {
        [projectiles removeObject: projectile];
        [self removeChild:projectile cleanup:YES];
    }
    for (CCSprite *enemy in enemiesToDelete) {
        [enemies removeObject:enemy];
        [self removeChild:enemy cleanup:YES];
    }
    [enemiesToDelete release];
    [projectilesToDelete release];
    
    NSMutableArray* eProjectilesToDelete = [[NSMutableArray alloc] init];
    CGRect playerRect = CGRectMake(ship.position.x - (ship.contentSize.width * ship.scaleX/2), ship.position.y - (ship.contentSize.height * ship.scaleY/2), 3, 3);
    for (CCSprite *eProjectile in enemyProjectiles) {
        CGRect eProjectileRect = CGRectMake(eProjectile.position.x - (eProjectile.contentSize.width/2), eProjectile.position.y - (eProjectile.contentSize.height/2), 8, 8);
        if (CGRectIntersectsRect(eProjectileRect, playerRect)) {
            [eProjectilesToDelete addObject: eProjectile];
            ship.health--;
            if (ship.health <= 0) {
                NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
                
                if (standardUserDefaults) {
                    [standardUserDefaults setInteger:score forKey:@"SCORE"];
                }
                [[CCDirector sharedDirector] replaceScene: [MenuLayer scene]];
                [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
                [[SimpleAudioEngine sharedEngine] playEffect:@"YouGotOwned.wav"];
            }
            else {
                [[SimpleAudioEngine sharedEngine] playEffect:@"oof.wav"];
            }
        }
    }
    for (CCSprite *eProjectile in eProjectilesToDelete) {
        [enemyProjectiles removeObject:eProjectile];
        [self removeChild:eProjectile cleanup:YES];
    }
    [eProjectilesToDelete release];
    
    NSMutableArray *enemiesToDelete2 = [[NSMutableArray alloc] init];
    for (CCSprite *enemy in enemies) {
        CGRect targetRect = CGRectMake(enemy.position.x - (enemy.contentSize.width * enemy.scaleX/2), enemy.position.y - (enemy.contentSize.height * enemy.scaleY/2), enemy.contentSize.width * enemy.scaleX, enemy.contentSize.height * enemy.scaleY);
        if (CGRectIntersectsRect(targetRect, playerRect)) {
            [enemiesToDelete2 addObject: enemy];
            ship.health--;
            if (ship.health <= 0) {
                NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
                
                if (standardUserDefaults) {
                    [standardUserDefaults setInteger:score forKey:@"SCORE"];
                }
                [[CCDirector sharedDirector] replaceScene: [MenuLayer scene]];
                [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
                [[SimpleAudioEngine sharedEngine] playEffect:@"YouGotOwned.wav"];
            }
            else {
                [[SimpleAudioEngine sharedEngine] playEffect:@"oof.wav"];
            }
        }
    }
    for (CCSprite *enemy in enemiesToDelete2) {
        [enemies removeObject:enemy];
        [self removeChild:enemy cleanup:YES];
    }
    [enemiesToDelete2 release];
}

- (void) doWaveOne//: (CCMenuItem  *) menuItem 
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setBool:YES forKey:@"WAVE1"];
    }
    if (wave1sound) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"Wave1.wav"];
        wave1sound = NO;
    }
    CGPoint realDest;
    CGPoint realDest2;
    
    float realMoveDuration;
    Sput *e1 = [Sput spriteWithFile: @"Ship-3.png"];
    e1.scaleX = .2;
    e1.scaleY = .2;
    e1.position = ccp(320, 390);
    [e1 schedule:@selector(step:) interval:1];
    [enemies addObject:e1];
    [self addChild:e1];
    realDest = ccp(40, 300);
    realDest2 = ccp(330, 400);
    realMoveDuration = 5;
    [e1 runAction:[CCSequence actions:
                          [CCJumpTo actionWithDuration:realMoveDuration position:realDest height:100 jumps:2],
                   [CCMoveTo actionWithDuration:realMoveDuration position:realDest2],
                          [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                           nil]];   
    Sput *e2 = [Sput spriteWithFile: @"Ship-3.png"];
    e2.scaleX = .2;
    e2.scaleY = .2;
    e2.position = ccp(0, 390);
    [e2 schedule:@selector(step:) interval:1];
    [enemies addObject:e2];	
    [self addChild:e2];
    realDest = ccp(300, 300);
    realDest2 = ccp(0, 400);
    realMoveDuration = 5;
    [e2 runAction:[CCSequence actions:
                   [CCJumpTo actionWithDuration:realMoveDuration position:realDest height:100 jumps:2],
                   [CCMoveTo actionWithDuration:realMoveDuration position:realDest2],
                   [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],

                   nil]]; 
    wave1count--;
    if (wave1count >= 0) {
        [self runAction: [CCSequence actions: [CCDelayTime actionWithDuration: .7], [CCCallFunc actionWithTarget:self selector:@selector(doWaveOne)], nil]];
    }
    else {
        wave1repeatcount--;
        if (wave1repeatcount >= 0) {
            wave1count = 5;
            [self runAction: [CCSequence actions: [CCDelayTime actionWithDuration: 2], [CCCallFunc actionWithTarget:self selector:@selector(doWaveOne)], nil]];
        }
        else
        {
            [self doWaveTwo];
        }
    }
}

- (void) doWaveTwo
{    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setBool:YES forKey:@"WAVE2"];
    }
    if (wave2sound) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"Wave2.wav"];
        wave2sound = NO;
    }
    CGPoint realDest;
    CGPoint realDest2;
    CGPoint realDest3;    
    float realMoveDuration;
    Sput *e1 = [Sput spriteWithFile: @"Ship-3.png"];
    e1.scaleX = .2;
    e1.scaleY = .2;
    e1.position = ccp(160 + wave2x, 500);
    [e1 schedule:@selector(step:) interval:1];
    [enemies addObject:e1];
    [self addChild:e1];
    realDest = ccp(160 + wave2x, 250);
    realDest2 = ccp(160 - wave2x, 250);
    realDest3 = ccp(160 - wave2x, 500);
    realMoveDuration = 5;
    [e1 runAction:[CCSequence actions:
                 //  [CCJumpTo actionWithDuration:realMoveDuration position:realDest height:100 jumps:2],
                   [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
                   [CCMoveTo actionWithDuration:realMoveDuration position:realDest2],
                   [CCMoveTo actionWithDuration:realMoveDuration position:realDest3],
                   [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                   nil]];
    
    
    if (wave2x != 0) {
    Sput *e2 = [Sput spriteWithFile: @"Ship-3.png"];
    e2.scaleX = .2;
    e2.scaleY = .2;
    e2.position = ccp(160 - wave2x, 500);
    [e2 schedule:@selector(step:) interval:1];
    [enemies addObject:e2];
    [self addChild:e2];
    realDest = ccp(160 - wave2x, 250);
    realDest2 = ccp(160 + wave2x, 250);
    realDest3 = ccp(160 + wave2x, 500);
    realMoveDuration = 5;
    [e2 runAction:[CCSequence actions:
                   //  [CCJumpTo actionWithDuration:realMoveDuration position:realDest height:100 jumps:2],
                   [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
                   [CCMoveTo actionWithDuration:realMoveDuration position:realDest2],
                   [CCMoveTo actionWithDuration:realMoveDuration position:realDest3],
                   [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                   nil]];  
    }
    wave2x +=35;
    if (wave2x <= 140) {
        [self runAction: [CCSequence actions: [CCDelayTime actionWithDuration: .7], 
                [CCCallFunc actionWithTarget:self selector:@selector(doWaveTwo)], nil]];
    }
    else {
        wave2count--;
        wave2x = 0;
        if (wave2count >= 0) {
            [self runAction: [CCSequence actions: [CCDelayTime actionWithDuration: .7], [CCCallFunc actionWithTarget:self selector:@selector(doWaveTwo)], nil]];
        }
        else
        {
            [self runAction: [CCSequence actions: [CCDelayTime actionWithDuration: 6.5], [CCCallFunc actionWithTarget:self selector:@selector(doWaveThree)], nil]];
        }
    }
}

- (void) doWaveThree
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        [standardUserDefaults setBool:YES forKey:@"WAVE3"];
    }
    
    if (wave3sound) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"Wave3.wav"];
        wave3sound = NO;
    }
    CGPoint realDest;
    id a1;
    float realMoveDuration;
    Tud *e1 = [Tud spriteWithFile: @"Ship-2.png"];
    e1.scaleX = .4;
    e1.scaleY = .4;
    e1.position = ccp(-50, wave3y);
    [e1 schedule:@selector(step:) interval:.3];
    [enemies addObject:e1];
    [self addChild:e1];
    realDest = ccp(350 , wave3y);
    realMoveDuration = 7;
    a1 = [CCRotateBy actionWithDuration:3 angle: 360];
    [e1 runAction:[CCRepeatForever actionWithAction:[CCSequence actions: [[a1 copy] autorelease], nil]]];
     
     
    [e1 runAction:[CCSequence actions:
                   [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
                   [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                   nil]];
    
    wave3y -= 70;
    Tud *e2 = [Tud spriteWithFile: @"Ship-2.png"];
    e2.scaleX = .4;
    e2.scaleY = .4;
    e2.position = ccp(350, wave3y);
    [e2 schedule:@selector(step:) interval:.3];
    [enemies addObject:e2];
    [self addChild:e2];
    realDest = ccp(-50 , wave3y);
    // realDest2 = ccp(160, 250);
    //  realDest3 = ccp(160 , 500);
    realMoveDuration = 7;
    a1 = [CCRotateBy actionWithDuration:3 angle: 360];
    [e2 runAction:[CCRepeatForever actionWithAction:[CCSequence actions: [[a1 copy] autorelease], nil]]];
    
    
    [e2 runAction:[CCSequence actions:
                   //  [CCJumpTo actionWithDuration:realMoveDuration position:realDest height:100 jumps:2],
                   [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
                   //  [CCMoveTo actionWithDuration:realMoveDuration position:realDest2],
                   // [CCMoveTo actionWithDuration:realMoveDuration position:realDest3],
                   [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                   nil]];
    wave3y -= 70;
    if (wave3y > 150) {
        [self runAction: [CCSequence actions: [CCDelayTime actionWithDuration: .7], 
                          [CCCallFunc actionWithTarget:self selector:@selector(doWaveThree)], nil]];
    }
    else {
        wave3count--;
        wave3y = 420;
        if (wave3count >= 0) {
            [self runAction: [CCSequence actions: [CCDelayTime actionWithDuration: 1.2], [CCCallFunc actionWithTarget:self selector:@selector(doWaveThree)], nil]];
        }
        else {
            [self runAction: [CCSequence actions: [CCDelayTime actionWithDuration: 6.5], [CCCallFunc actionWithTarget:self selector:@selector(doWaveFour)], nil]];
        }
    }
}

- (void) doWaveFour
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        [standardUserDefaults setBool:YES forKey:@"WAVE4"];
    }
    
    if (wave4sound) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"Wave4.wav"];
        wave4sound = NO;
    }
    [self doWaveFourTuds];
    [self doWaveFourSputs];


}

- (void) doWaveFourSputs
{
    CGPoint realDest;
    CGPoint realDest2;
    
    float realMoveDuration;
    Sput *e1 = [Sput spriteWithFile: @"Ship-3.png"];
    e1.scaleX = .2;
    e1.scaleY = .2;
    e1.position = ccp(320, 390);
    [e1 schedule:@selector(step:) interval:1];
    [enemies addObject:e1];
    [self addChild:e1];
    realDest = ccp(40, 300);
    realDest2 = ccp(330, 400);
    realMoveDuration = 5;
    [e1 runAction:[CCSequence actions:
                   [CCJumpTo actionWithDuration:realMoveDuration position:realDest height:100 jumps:2],
                   [CCMoveTo actionWithDuration:realMoveDuration position:realDest2],
                   [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                   nil]];   
    Sput *e2 = [Sput spriteWithFile: @"Ship-3.png"];
    e2.scaleX = .2;
    e2.scaleY = .2;
    e2.position = ccp(0, 390);
    [e2 schedule:@selector(step:) interval:1];
    [enemies addObject:e2];	
    [self addChild:e2];
    realDest = ccp(300, 300);
    realDest2 = ccp(0, 400);
    realMoveDuration = 5;
    [e2 runAction:[CCSequence actions:
                   [CCJumpTo actionWithDuration:realMoveDuration position:realDest height:100 jumps:2],
                   [CCMoveTo actionWithDuration:realMoveDuration position:realDest2],
                   [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                   
                   nil]]; 
    wave4sputcount--;
    if (wave4sputcount >= 0) {
        [self runAction: [CCSequence actions: [CCDelayTime actionWithDuration: 1.3], [CCCallFunc actionWithTarget:self selector:@selector(doWaveFourSputs)], nil]];
    }
    else
    {
        [self runAction: [CCSequence actions: [CCDelayTime actionWithDuration: 8], [CCCallFunc actionWithTarget:self selector:@selector(doResults)], nil]];
    }
  //  else {
   //     wave1repeatcount--;
 //       if (wave1repeatcount >= 0) {
  //          wave1count = 5;
   //         [self runAction: [CCSequence actions: [CCDelayTime actionWithDuration: 2], [CCCallFunc actionWithTarget:self //selector:@selector(doWaveOne)], nil]];
     //   }
     //   else
     //   {
    //        [self doWaveTwo];
   //     }
   // }
}
- (void) doWaveFourTuds
{
    CGPoint realDest;
    id a1;
    float realMoveDuration;
    Tud *t1 = [Tud spriteWithFile: @"Ship-2.png"];
    t1.scaleX = .4;
    t1.scaleY = .4;
    t1.position = ccp(-50, 190 + wave4tudy);
    [t1 schedule:@selector(step:) interval:.3];
    [enemies addObject:t1];
    [self addChild:t1];
    realDest = ccp(350, 190 - wave4tudy);
    realMoveDuration = 7;
    a1 = [CCRotateBy actionWithDuration:3 angle: 360];
    [t1 runAction:[CCRepeatForever actionWithAction:[CCSequence actions: [[a1 copy] autorelease], nil]]];
    
    
    [t1 runAction:[CCSequence actions:
                   [CCJumpTo actionWithDuration:realMoveDuration position:realDest height:70 jumps:4],
                   [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                   nil]];
    
    Tud *t2 = [Tud spriteWithFile: @"Ship-2.png"];
    t2.scaleX = .4;
    t2.scaleY = .4;
    t2.position = ccp(350, 190 + wave4tudy);
    [t2 schedule:@selector(step:) interval:.3];
    [enemies addObject:t2];
    [self addChild:t2];
    realDest = ccp(-50, 190 - wave4tudy);
    realMoveDuration = 7;
    a1 = [CCRotateBy actionWithDuration:3 angle: 360];
    [t2 runAction:[CCRepeatForever actionWithAction:[CCSequence actions: [[a1 copy] autorelease], nil]]];
    
    
    [t2 runAction:[CCSequence actions:
                   [CCJumpTo actionWithDuration:realMoveDuration position:realDest height:70 jumps:4],
                   [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                   nil]];
    wave4tudy -= 90;
    if (wave4tudy > -190) {
        [self runAction: [CCSequence actions: [CCDelayTime actionWithDuration: 1.4], 
                          [CCCallFunc actionWithTarget:self selector:@selector(doWaveFourTuds)], nil]];
    }
    else {
        wave4tudcount--;
        wave4tudy = 230;
        if (wave4tudcount >= 0) {
            [self runAction: [CCSequence actions: [CCDelayTime actionWithDuration: 3.2], [CCCallFunc actionWithTarget:self selector:@selector(doWaveFourTuds)], nil]];
        }
        
    }

}

- (void) doResults 
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCLabelTTF *countLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Hits sustained: %d", 10000 - ship.health] fontName:@"Marker Felt" fontSize:32];
    
    [self addChild:countLabel z:0 tag:0];
    countLabel.position = ccp(size.width/2,size.height/2);
    countLabel.opacity = 200;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setInteger:0 forKey:@"SCORE"];
        [standardUserDefaults synchronize];
    }
    
    [self runAction: [CCSequence actions: [CCDelayTime actionWithDuration: 7], [CCCallFunc actionWithTarget:self selector:@selector(doMenu)], nil]];
}
- (void) doMenu 
{
    [[CCDirector sharedDirector] replaceScene: [MenuLayer scene]];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end