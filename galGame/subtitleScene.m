//
//  subtitleScene.m
//  galGame
//
//  Created by god on 13-7-27.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "subtitleScene.h"
#import "settingScene.h"
#import "userManager.h"
#import <string.h>


@implementation subtitleScene

+ (id)scene
{
    CCScene *scene = [CCScene node];
    CCLayer *layer = [subtitleScene node];
    
    [scene addChild:layer];
    return scene;
}

- (id)init
{
    CGSize size = [[CCDirector sharedDirector]winSize];
    
    if( self = [super init] ){
        count = 0;
        
        CCSprite *sprite = [CCSprite spriteWithFile:@"panel_bg.png"];
        sprite.rotation = 90;
        sprite.position = CGPointMake(260 / 2, size.height / 2);
        sprite.opacity = 225 * 0.8;
        [self addChild:sprite];
        

        label = [CCLabelTTF labelWithString:@"" dimensions:CGSizeMake(1000, 200) alignment:UITextAlignmentLeft  fontName:@"AppleGothic" fontSize:25 ];
//        label = [CCLabelTTF labelWithString:@"test" fontName:@"AppleGothic" fontSize:25];
        label.color = ccBLACK;

        label.anchorPoint = CGPointMake(0, 0);
//        label.position = ccp(0, 200);

        [sprite addChild:label];
        
        CCSprite *autoItemNormal = [CCSprite spriteWithFile:@"panel_auto.png"];
        CCSprite *autoItemSelected = [CCSprite spriteWithFile:@"panel_auto.png"];
        autoItemSelected.color = ccGRAY;
        CCMenuItemSprite *item1 = [CCMenuItemSprite itemFromNormalSprite:autoItemNormal selectedSprite:autoItemSelected block:^(id sender){
            [self unscheduleAllSelectors];
            if( isAutoFlag ){
                isAutoFlag = NO;
                [self schedule:@selector(updateString:) interval:0.2f];
            }else{
                isAutoFlag = YES;
                [self schedule:@selector(updateString:) interval:0.1f];
            }
        }];
        
        CCSprite *skipItemNormal = [CCSprite spriteWithFile:@"panel_skip.png"];
        CCSprite *skipItemSelected = [CCSprite spriteWithFile:@"panel_skip.png"];
        skipItemSelected.color = ccGRAY;
        CCMenuItemSprite *item2 = [CCMenuItemSprite itemFromNormalSprite:skipItemNormal selectedSprite:skipItemSelected];
        
        
        CCMenu *menu1 = [CCMenu menuWithItems:item1, item2, nil];
        [menu1 alignItemsHorizontallyWithPadding:0];
        menu1.position = ccp(600, 223);
        
        CGPoint p = menu1.position;
        NSLog(@"menu point is %f %f",p.x, p.y);
        [sprite addChild:menu1];
        
        CCSprite *saveItemNormal = [CCSprite spriteWithFile:@"panel_save.png"];
        CCSprite *saveItemSelected = [CCSprite spriteWithFile:@"panel_save.png"];
        saveItemSelected.color = ccGRAY;
        CCMenuItemSprite *saveItem = [CCMenuItemSprite itemFromNormalSprite:saveItemNormal selectedSprite:saveItemSelected];
        
        CCSprite *loadItemNormal = [CCSprite spriteWithFile:@"panel_load.png"];
        CCSprite *loadItemSelected = [CCSprite spriteWithFile:@"panel_load.png"];
        loadItemSelected.color = ccGRAY;
        CCMenuItemSprite *loadItem = [CCMenuItemSprite itemFromNormalSprite:loadItemNormal selectedSprite:loadItemSelected];
        CCMenu *menu2 = [CCMenu menuWithItems:saveItem, loadItem, nil];
        [menu2 alignItemsHorizontallyWithPadding:0];
        menu2.position = ccp(780, 223);
        
        [sprite addChild:menu2];
        
        CCSprite *systemItmenNormal = [CCSprite spriteWithFile:@"panel_system.png"];
        CCSprite *systemItemSelected = [CCSprite spriteWithFile:@"panel_system.png"];
        systemItemSelected.color = ccGRAY;
        CCMenuItemSprite *systemItem = [CCMenuItemSprite itemFromNormalSprite:systemItmenNormal selectedSprite:systemItemSelected target:self selector:@selector(changeToSystem:)];
        CCMenu *menu3 = [CCMenu menuWithItems:systemItem, nil];
        menu3.position = ccp(930, 223);
        [sprite addChild:menu3];
        
        [self schedule:@selector(updateString:) interval:0.2f];
        
        
        timeSprite = nil;
        showTime = 0;
        
        [self registerWithTouchDispatcher];
        
        isAutoFlag = NO;
        
    }
    return self;
}

- (void)updateString:(ccTime)delta
{
    CGSize size = [[CCDirector sharedDirector]winSize];
    
    userManager *UM = [userManager sharedUserManager];
    int index = UM -> currentCont;
    NSDictionary *tempD = [UM.getSayArray objectAtIndex:index];
    NSString *word = [tempD objectForKey:@"word"];
    const char *p = [word UTF8String];
    int length = strlen(p);
   
        if( count < length ){
            if( (int)p[count] > 127 || (int)p[count] < 0 )
                count += 3;
            else
                count ++;
        }else{
            if( isAutoFlag == YES ){
                UM -> currentCont ++;
                count = 0;
            }
            
        }
    
    char *k = (char *)malloc(count + 1);
    
    memcpy(k, p, count);
    k[count] = '\0';
    [label setString:[NSString stringWithUTF8String:k]];

}

- (void)changeToSystem:(id)what
{
//    [[CCDirector sharedDirector]pushScene:[settingScene scene]];
    settingScene *scene = [settingScene node];
    [self addChild:scene];
}

- (void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
}

- (BOOL)isTouchForMe
{
    return YES;
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    BOOL isTouchHandled = [self isTouchForMe];
    
    userManager *UM = [userManager sharedUserManager];
    int index = UM -> currentCont;
    NSDictionary *tempD = [UM.getSayArray objectAtIndex:index];
    NSString *word = [tempD objectForKey:@"word"];
    const char *p = [word UTF8String];
    int length = strlen(p);
    
    if( count >= length ){
        UM -> currentCont ++;
        count = 0;
    }else{
        count = length;
    }

    
    return isTouchHandled;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
//    NSLog(@"touch2~~");

}

@end
