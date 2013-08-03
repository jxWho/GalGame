//
//  GameScene.m
//  galGame
//
//  Created by god on 13-7-26.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "userManager.h"
#import "TimeScene.h"

@implementation GameScene
@synthesize label = _label;

+ (id)scene
{
    CCScene *scene = [CCScene node];
    GameScene *layer = [GameScene node];
    [scene addChild:layer];
    
    return scene;

}

- (id)init
{
//    CGSize size = [[CCDirector sharedDirector]winSize];
    
    if( self = [super init] ){
        
        gScene = nil;
        sScene = nil;
        
        [self scheduleUpdate];
        
        showTimeFlag = NO;
        
        currentIndex = -1;
    }
    return self;
}

- (void) update:(ccTime)delta
{
    userManager *UM = [userManager sharedUserManager];
    int index = UM -> currentCont;
    NSDictionary *dd = [UM.getSayArray objectAtIndex:index];
    
    if( currentIndex !=  index){
        currentIndex = index;
        showTimeFlag = NO;
    }
    
    if( [dd objectForKey:@"shijian"] && !showTimeFlag ){
        showTimeFlag = YES;
        //push the scene in
        [[CCDirector sharedDirector]pushScene:[TimeScene scene]];
    }
    
    if( !gScene ){
        gScene = [gameBackGroundScene node];
        [self addChild:gScene z:-1];
    }
    
    if( !sScene ){
        sScene = [subtitleScene node];
        [self addChild:sScene z:1];
    }
    
}

@end
