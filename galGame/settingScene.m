//
//  settingScene.m
//  galGame
//
//  Created by god on 13-7-28.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "settingScene.h"
#import "FirstScene.h"


@implementation settingScene

+(id)scene
{
    CCScene *scene = [CCScene node];
    CCLayer *layer = [settingScene node];
    
    [scene setContentSize:CGSizeZero];
    
//    [scene addChild:layer];
    
    return scene;
}

-(id) init
{
    CGSize size = [[CCDirector sharedDirector]winSize];
    
    self = [super initWithColor:ccc4(255, 255, 255, 20)];
    if( self ){

        CCSprite *sprite = [CCSprite spriteWithFile:@"system_bg.png"];
        sprite.position = CGPointMake(size.width / 2, size.height / 2);
        sprite.rotation = 90;
        [self addChild:sprite];
        
        CCSprite *historyItemNormal = [CCSprite spriteWithFile:@"system_history.png"];
        CCSprite *histroyItemSelected = [CCSprite spriteWithFile:@"system_history_active.png"];
        CCMenuItemSprite *histroyItem = [CCMenuItemSprite itemFromNormalSprite:historyItemNormal selectedSprite:histroyItemSelected];
        
        CCSprite *titleItemNormal = [CCSprite spriteWithFile:@"system_title.png"];
        CCSprite *titleItemSelected = [CCSprite spriteWithFile:@"system_title_active.png"];
        CCMenuItemSprite *titleItem = [CCMenuItemSprite itemFromNormalSprite:titleItemNormal selectedSprite:titleItemSelected block:^(id sender){
            CCTransitionFade *fade = [[CCTransitionFade alloc]initWithDuration:1 scene:[FirstScene scene]];
            [[CCDirector sharedDirector] replaceScene:fade];
        }];
        
        CCSprite *continueItemNormal = [CCSprite spriteWithFile:@"system_continue.png"];
        CCSprite *continueItemSelected = [CCSprite spriteWithFile:@"system_continue_active.png"];
        CCMenuItemSprite *continueItem = [CCMenuItemSprite itemFromNormalSprite:continueItemNormal selectedSprite:continueItemSelected block:^(id sender){
            [self removeAllChildrenWithCleanup:YES];
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
        
        NSString *p;

        
        
    }
    return self;
}

@end
