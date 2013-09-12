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

const NSInteger panlBGTag = 100;


@implementation subtitleScene
@synthesize bg = _bg;

+ (id)scene
{
    CCScene *scene = [CCScene node];
    CCLayer *layer = [subtitleScene node];
    
    [scene addChild:layer];
    return scene;
}

- (id)init
{
    
    if( self = [super init] ){
        shellDictionary = [[NSMutableDictionary alloc]init];
        shellSprite = nil;
        currentShell = @"A";
        count = 0;
        panelBG = nil;
        timeSprite = nil;
        showTime = 0;
        isAutoFlag = NO;
        
        [self registerWithTouchDispatcher];
        [self schedule:@selector(updateString:) interval:0.2f];
        
        iconSprite = nil;
        iconName = nil;
        currentIconNumber = -11;
        
        iconArray = [[CCArray array] retain];
        for( int i = 0; i < 16; i++ ){
            CGSize size = [[CCDirector sharedDirector]winSize];
            NSString *iconPath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"icon%d", i] ofType:@"png"];
            if( [[NSFileManager defaultManager]fileExistsAtPath:iconPath] ){
                CCSprite *tempSprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"icon%d.png", i]];
                tempSprite.position = ccp(260 - 100,  size.height - 50);
                tempSprite.rotation = 90;
                [iconArray addObject:tempSprite];
            }else{
                [iconArray addObject:0];
            }
        }
        NSLog(@"%d", [iconArray count]);
    }
    return self;
}



- (void)updateString:(ccTime)delta
{

    if( !panelBG ){
        count = 0;
        CGSize size = [[CCDirector sharedDirector]winSize];
        panelBG = [CCSprite spriteWithFile:@"panel_bg.png"];
        panelBG.rotation = 90;
        panelBG.position = CGPointMake(260 / 2, size.height / 2);
        panelBG.opacity = 225 * 0.8;
        [self addChild:panelBG];
        
        label = [CCLabelTTF labelWithString:@"" dimensions:CGSizeMake(800, 190) alignment:UITextAlignmentLeft  fontName:@"STHeitiK-Light" fontSize:25 ];
        label.color = ccBLACK;
        
        label.anchorPoint = CGPointMake(0, 0);
        label.position = ccp(200, 0);
        
        [panelBG addChild:label];
        
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
                [self schedule:@selector(updateString:) interval:0.05f];
            }
        }];
        
        CCSprite *skipItemNormal = [CCSprite spriteWithFile:@"panel_skip.png"];
        CCSprite *skipItemSelected = [CCSprite spriteWithFile:@"panel_skip.png"];
        skipItemSelected.color = ccGRAY;
        CCMenuItemSprite *item2 = [CCMenuItemSprite itemFromNormalSprite:skipItemNormal selectedSprite:skipItemSelected block:^(id sender){
            [self unscheduleAllSelectors];
            userManager *UM = [userManager sharedUserManager];
            
            while (YES) {
                int index = UM -> currentCont;
                NSDictionary *tempD = [UM.getSayArray objectAtIndex:index];
                NSString *word = [tempD objectForKey:@"word"];
                if( [word rangeOfString:@"@Question"].length > 0 ){
                    [self schedule:@selector(updateString:) interval:0.1f];
                    [label setString:@""];
                    break;
                }
                UM -> currentCont = UM -> currentCont + 1;
            }
        }];
        
        
        CCMenu *menu1 = [CCMenu menuWithItems:item1, item2, nil];
        [menu1 alignItemsHorizontallyWithPadding:0];
        menu1.position = ccp(600, 223);
        
        CGPoint p = menu1.position;
        NSLog(@"menu point is %f %f",p.x, p.y);
        [panelBG addChild:menu1];
        
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
        
        [panelBG addChild:menu2];
        
        CCSprite *systemItmenNormal = [CCSprite spriteWithFile:@"panel_system.png"];
        CCSprite *systemItemSelected = [CCSprite spriteWithFile:@"panel_system.png"];
        systemItemSelected.color = ccGRAY;
        CCMenuItemSprite *systemItem = [CCMenuItemSprite itemFromNormalSprite:systemItmenNormal selectedSprite:systemItemSelected target:self selector:@selector(changeToSystem:)];
        CCMenu *menu3 = [CCMenu menuWithItems:systemItem, nil];
        menu3.position = ccp(930, 223);
        [panelBG addChild:menu3];
    }
    
    CGSize size = [[CCDirector sharedDirector]winSize];
    
    userManager *UM = [userManager sharedUserManager];
    int index = UM -> currentCont;
    NSDictionary *tempD = [UM.getSayArray objectAtIndex:index];
    NSString *word = [tempD objectForKey:@"word"];
    NSString *newShell = [tempD objectForKey:@"shell"];
    
    if( ![newShell isEqualToString:currentShell] ){
        currentShell = newShell;
        if( [newShell isEqualToString:@"A"] ){
            if( shellSprite != nil )
                [shellSprite removeFromParentAndCleanup:NO];
            
        }else{
                if( shellSprite != nil )
                    [shellSprite removeFromParentAndCleanup:NO];
            CCSprite *tempSp = [shellDictionary objectForKey:newShell];
            if( tempSp != nil ){
                shellSprite = tempSp;
                shellSprite.position = ccp(size.width / 2, size.height / 2);
                shellSprite.rotation = 90;
                [self addChild:shellSprite z:-10];
            }else{
                shellSprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png", newShell]];
                [shellDictionary setObject:shellSprite forKey:currentShell];
                shellSprite.position = ccp(size.width / 2, size.height / 2);
                shellSprite.rotation = 90;
                [self addChild:shellSprite z:-10];
            }
        }
    }
    
    if( [word rangeOfString:@"@Question"].length > 0 ){
        //remove icon and name
        [iconName setString:@""];
        [iconSprite removeFromParentAndCleanup:NO];
        iconSprite = nil;
        currentIconNumber = -1;
        //choose Item
        NSArray *array = [word componentsSeparatedByString:@"#"];
        int num = [[array objectAtIndex:2] intValue];

        CCMenu *menu = [CCMenu menuWithItems: nil];
        CCSprite *optionBg = [CCSprite spriteWithFile:@"option_bg.png"];

        for( int i = 0; i < num; i++){
            CCMenuItemFont *menuItem = [CCMenuItemFont itemFromString:[array objectAtIndex:3 + i] block:^(id sender){
                [optionBg removeFromParentAndCleanup:YES];
                int nextSay = [[array objectAtIndex:3 + num + i] intValue];
                UM -> currentCont = nextSay;
                [self schedule:@selector(updateString:) interval:0.1f];
            }];
            menuItem.fontName = @"STHeitiK-Light";
            menuItem.color = ccBLACK;
            [menu addChild:menuItem ];
        }

        menu.position = ccp(525, 190);
        
        [menu alignItemsVerticallyWithPadding:0];
        
        optionBg.rotation = 90;
        optionBg.position = ccp(size.width / 2, size.height / 2);
        
        [optionBg addChild:menu];
        [self addChild:optionBg];
        [self unscheduleAllSelectors];
        

        [panelBG removeFromParentAndCleanup:YES];
        panelBG = nil;
//        [iconSprite removeFromParentAndCleanup:YES];
//        if( iconSprite )
//            [iconSprite removeFromParentAndCleanup:YES];

    }else{
        //icon
        NSInteger iconNumber = [[tempD objectForKey:@"person"] intValue];
        if( iconNumber != currentIconNumber ){
            NSLog(@"%d", [iconArray count]);

           
            if( currentIconNumber >= 0 ){
                if( iconSprite ){
                    CCSprite *cTemp = [iconArray objectAtIndex:currentIconNumber];
                    [cTemp removeFromParentAndCleanup:NO];
                }
            }
            
            currentIconNumber = iconNumber;
            
            NSString *iconPath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"icon%d", iconNumber] ofType:@"png"];
            
            if( [[NSFileManager defaultManager]fileExistsAtPath:iconPath] ){
                CCSprite *cTemp;
                cTemp = [iconArray objectAtIndex:iconNumber];
                [self addChild:cTemp];
                iconSprite = cTemp;
                

            }else{
            }
        
        //icon Name
        NSArray *characterArray = [UM getCharacterArray];
        for( NSDictionary *p in characterArray ){
            NSInteger iconID = [[p objectForKey:@"id"] intValue];
            if( iconID == iconNumber ){
                NSString *name = [p objectForKey:@"name"];
                if( iconName ){
                    [iconName setString:name];
                }else{
                    iconName = [CCLabelTTF labelWithString:name fontName:@"STHeitiK-Light" fontSize:28];
                    iconName.position = ccp(260 - 40,  size.height - 50);
                    
                    iconName.rotation = 90;
                    ccColor3B pink = {255, 105, 180};
                    iconName.color = pink;
                    [self addChild:iconName z:10];
                }
                break;
            }
        }
    }
    
        //word
        const char *p = [word UTF8String];
        int length = strlen(p);
       
            if( count < length ){
                if( (int)p[count] > 127 || (int)p[count] < 0 )
                    count += 3;
                else
                    count ++;
            }else{
                if( isAutoFlag == YES ){
                    int nextNum = [[tempD objectForKey:@"next"] intValue];
                    if( nextNum <= 0 ){
                        UM -> currentCont ++;
                    }else{
                        [UM setCurrentCont:nextNum];
                    }
                    count = 0;
                }
                
            }
        
        char *k = (char *)malloc(count + 1);
        
        memcpy(k, p, count);
        k[count] = '\0';
        [label setString:[NSString stringWithUTF8String:k]];
        free(k);

    }

}


- (void)changeToSystem:(id)what
{
//    [[CCDirector sharedDirector]pushScene:[settingScene scene]];
    settingScene *scene = [settingScene node];
    [self addChild:scene z:1 tag:panlBGTag];
}

- (void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:YES];
}

- (BOOL)isTouchForMe:(CGPoint) touchLocation
{
//    CCNode *node = [self getChildByTag:panlBGTag];
//    if( node ){
//        NSLog(@"see");
//        CGRect rect = [node boundingBox];
//        NSLog(@"%f %f %f %f", rect.origin.x, rect.origin.y, rect.size.height, rect.size.width);
//        NSLog(@"%f %f", touchLocation.x, touchLocation.y);
//        if( CGRectContainsPoint([node boundingBox], touchLocation) ){
//            return NO;
//        }else{
//            NSLog(@"not in");
//        }
//    }
    return YES;
}




- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"second");
    CGPoint location = [self convertTouchToNodeSpace:touch];
    BOOL isTouchHandled = [self isTouchForMe:location];
    if( isTouchHandled ){
        userManager *UM = [userManager sharedUserManager];
        int index = UM -> currentCont;
        NSDictionary *tempD = [UM.getSayArray objectAtIndex:index];
        NSString *word = [tempD objectForKey:@"word"];
        const char *p = [word UTF8String];
        int length = strlen(p);
        
        if( count >= length ){
            int nextNum = [[tempD objectForKey:@"next"] intValue];
            if( nextNum <= 0 ){
                UM -> currentCont ++;
            }else{
                [UM setCurrentCont:nextNum];
            }
            count = 0;
        }else{
            count = length;
        }
    }
    return isTouchHandled;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
//    NSLog(@"touch2~~");

}

- (void)dealloc
{
    [super dealloc];
    [iconArray release];
}

@end
