//
//  WelcomeScene.m
//  galGame
//
//  Created by god on 13-7-20.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "WelcomeScene.h"
#import "FirstScene.h"

@implementation WelcomeScene



+(id) scene
{
    CCScene *scene = [CCScene node];
    CCLayerColor *layer = [WelcomeScene node];
    
    [scene addChild:layer];

    return scene;
}

- (id) init
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    
    if (self = [super initWithColor:ccc4(255, 255, 255, 255)]){
        CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
        CCSprite *sprite = [CCSprite spriteWithFile:@"Default-Portrait~ipad.png" ];
        sprite.position = CGPointMake(size.width / 2 , size.height / 2);
        sprite.scale = size.width / 480;
        [self addChild:sprite];
        [self scheduleUpdate];
    }
    return self;
}

-(void) dealloc
{
    [super dealloc];
}

//- (void)onEnter
//{
//    [super onEnter];
////    [[CCDirector sharedDirector] replaceScene:[FirstScene node]];
//    CCTransitionFade *tran = [CCTransitionFade transitionWithDuration:1 scene:[FirstScene node]];
//    [[CCDirector sharedDirector] replaceScene:tran];
//}

- (void)update:(ccTime)delta
{
    NSLog(@"111111");
    [self unscheduleAllSelectors];
    [[CCDirector sharedDirector] replaceScene:[FirstScene scene]];
}

@end
