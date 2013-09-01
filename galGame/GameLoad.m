//
//  GameLoad.m
//  galGame
//
//  Created by god on 13-7-26.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "GameLoad.h"
#import "GameScene.h"

@implementation GameLoad

+(id)scene
{
    return [[[self alloc]initWithTargetScene]autorelease];
}

- (id)initWithTargetScene
{
//    CGSize size = [[CCDirector sharedDirector]winSize];
    
    self = [super init];
    if( self ){
        flag = NO;
//        CCSprite *spirte = [CCSprite spriteWithFile:@"64.png"];
//        spirte.position = CGPointMake(size.width / 2, size.height / 2);
//        spirte.rotation = 90;
//        [self addChild:spirte];
        [self scheduleUpdate];
    }
    return self;
}

- (void)update:(ccTime)delta
{
    if( flag == YES ){
        [self unscheduleAllSelectors];
        [[CCDirector sharedDirector]replaceScene:[GameScene scene]];
    }
}

- (void)onEnterTransitionDidFinish
{
    flag = YES;
}

@end
