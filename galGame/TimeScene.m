//
//  TimeScene.m
//  galGame
//
//  Created by god on 13-8-3.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "TimeScene.h"


@implementation TimeScene

+ (id)scene
{
    CCScene *scene = [CCScene node];
    CCLayer *layer = [TimeScene node];
    [scene addChild:layer];
    
    return scene;
}

- (id)init
{
    CGSize size = [[CCDirector sharedDirector]winSize];
    
    self = [super init];
    if( self ){
        showTime = 0;
        timeShowSprite = [CCSprite spriteWithFile:@"64.png"];
        timeShowSprite.position = ccp(size.width / 2, size.height / 2);
        timeShowSprite.rotation = 90;
        [self addChild:timeShowSprite];
        
        [self scheduleUpdate];
    }
    return self;
}

- (void)update:(ccTime)delta
{
    showTime ++;
    if( showTime > 40 )
       [[CCDirector sharedDirector]popScene];
}

@end
