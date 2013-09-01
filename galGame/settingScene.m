//
//  settingScene.m
//  galGame
//
//  Created by god on 13-7-28.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "settingScene.h"
#import "FirstScene.h"
#import "SimpleAudioEngine.h"
#import "userManager.h"
#import "GameScene.h"


@implementation settingScene

+(id)scene
{
    CCScene *scene = [CCScene node];
    
    [scene setContentSize:CGSizeZero];

//    [scene addChild:layer];
    
    return scene;
}

-(id) init
{
    CGSize size = [[CCDirector sharedDirector]winSize];
    
    self = [super initWithColor:ccc4(255, 255, 255, 20)];
    if( self ){
        [self registerWithTouchDispatcher];
        
        CCSprite *sprite = [CCSprite spriteWithFile:@"system_bg.png"];
        sprite.position = CGPointMake(size.width / 2, size.height / 2);
        sprite.rotation = 90;
        [self addChild:sprite z:0 tag:100];
        
        CCSprite *historyItemNormal = [CCSprite spriteWithFile:@"system_history.png"];
        CCSprite *histroyItemSelected = [CCSprite spriteWithFile:@"system_history_active.png"];
        CCMenuItemSprite *histroyItem = [CCMenuItemSprite itemFromNormalSprite:historyItemNormal selectedSprite:histroyItemSelected];
        
        CCSprite *titleItemNormal = [CCSprite spriteWithFile:@"system_title.png"];
        CCSprite *titleItemSelected = [CCSprite spriteWithFile:@"system_title_active.png"];
        CCMenuItemSprite *titleItem = [CCMenuItemSprite itemFromNormalSprite:titleItemNormal selectedSprite:titleItemSelected block:^(id sender){
//            [self removeFromParentAndCleanup:YES];
//            CCScene *scene = [[CCDirector sharedDirector] runningScene];
//            [scene unscheduleAllSelectors];
            CCTransitionFade *fade = [[[CCTransitionFade alloc]initWithDuration:1 scene:[FirstScene scene]] autorelease];
            
            [[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
            [[CCDirector sharedDirector] replaceScene:fade];

        }];
        
        CCSprite *continueItemNormal = [CCSprite spriteWithFile:@"system_continue.png"];
        CCSprite *continueItemSelected = [CCSprite spriteWithFile:@"system_continue_active.png"];
        CCMenuItemSprite *continueItem = [CCMenuItemSprite itemFromNormalSprite:continueItemNormal selectedSprite:continueItemSelected block:^(id sender){
            [self removeFromParentAndCleanup:YES];
        }];
        
        CCMenu *menu = [CCMenu menuWithItems:histroyItem, titleItem, continueItem, nil];
        [menu alignItemsVerticallyWithPadding:5];
        menu.position = CGPointMake(250, 120);
        [sprite addChild:menu];
        
        CCSprite *strack1 = [CCSprite spriteWithFile:@"system_strack.png"];
        strack1.position = CGPointMake(300, 560);
        [sprite addChild:strack1];

        CCSprite *sButton1 = [CCSprite spriteWithFile:@"system_sbutton.png"];
        sButton1.position = CGPointMake(150, 560);
//        sButton1.anchorPoint = CGPointMake(0, 0);
        [sprite addChild:sButton1];

        
        
    }
    return self;
}

- (void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
}

- (BOOL)isTouchForMe:(CGPoint)touchLocation
{
    CCNode *bg = [self getChildByTag:100];
    return CGRectContainsPoint(bg.boundingBox, touchLocation);
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"first");
    CCNode *bg = [self getChildByTag:100];
    CGPoint location = [bg convertTouchToNodeSpace:touch];
    BOOL isHandlered = [self isTouchForMe:location];
    if( isHandlered ){
        
    }
    return isHandlered;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CCNode *bg = [self getChildByTag:100];
    CGPoint location = [bg convertTouchToNodeSpace:bg];
    
}

@end
