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

NSUInteger strackLength;
const NSUInteger button1 = 1;
const NSUInteger button2 = 2;
const NSUInteger button3 = 3;
const NSUInteger button4 = 4;


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
    currentTouch = 0;
    
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
        strackLength = strack1.texture.contentSize.width;

        CCSprite *sButton1 = [CCSprite spriteWithFile:@"system_sbutton.png"];
        sButton1.position = CGPointMake(150, 560);
//        sButton1.anchorPoint = CGPointMake(0, 0);
        [sprite addChild:sButton1 z:0 tag:button1];
        
        CCSprite *strack2 = [CCSprite spriteWithFile:@"system_strack.png"];
        strack2.position = ccp(300, 480);
        [sprite addChild:strack2];
        
        CCSprite *sButton2 = [CCSprite spriteWithFile:@"system_sbutton.png"];
        sButton2.position = ccp(150, 480);
        [sprite addChild:sButton2 z:0 tag:button2];
        
        CCSprite *strack3 = [CCSprite spriteWithFile:@"system_strack.png"];
        strack3.position = ccp(300, 360);
        [sprite addChild:strack3];
        
        CCSprite *sButton3 = [CCSprite spriteWithFile:@"system_sbutton.png"];
        sButton3.position = ccp(150, 360);
        [sprite addChild:sButton3 z:0 tag:button3];
        
        CCSprite *strack4 = [CCSprite spriteWithFile:@"system_strack.png"];
        strack4.position = ccp(300, 290);
        [sprite addChild:strack4 ];

        CCSprite *sButton4 = [CCSprite spriteWithFile:@"system_sbutton.png"];
        sButton4.position = ccp(150, 290);
        [sprite addChild:sButton4 z:0 tag:button4];
        
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
        CCNode *node = [bg getChildByTag:button1];
        if( CGRectContainsPoint(node.boundingBox, location) ){
            currentTouch = button1;
        }
    }
    return isHandlered;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CCNode *bg = [self getChildByTag:100];
    CGPoint location = [bg convertTouchToNodeSpace:touch];
    
    if( currentTouch == button1 ){
        CCNode *bt = [bg getChildByTag:button1];
        if( location.x > strackLength + 150 ){
            bt.position = ccp(strackLength + 150, bt.position.y);
        }else if( location.x < 150 ){
            bt.position = ccp(150, bt.position.y);
        }else{
            bt.position = ccp(location.x, bt.position.y);
        }
    }
}

@end
