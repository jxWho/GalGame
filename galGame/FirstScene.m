//
//  FirstScene.m
//  galGame
//
//  Created by god on 13-7-20.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "FirstScene.h"
#import "GameLoad.h"
#import "GameScene.h"
#import "userManager.h"


@implementation FirstScene

+(id)scene
{
    
    CCScene *scene = [CCScene node];
    FirstScene *layer = [FirstScene node];
    [scene addChild:layer];
    
    
    return scene;
}

- (id) init
{
    CGSize size = [[CCDirector sharedDirector]winSize];
    self = [super initWithColor:ccc4(0, 0, 0, 0)];
    if( self ){
        CCSprite *sprite1 = [CCSprite spriteWithFile:@"op1.png"];
        sprite1.position = CGPointMake(size.width / 2, size.height / 2);
        sprite1.rotation = 90;
        [self addChild:sprite1];
        
        CCSprite *sprite2 = [CCSprite spriteWithFile:@"op2.png"];
        sprite2.position = CGPointMake(size.width / 2 , size.height / 2 );
        sprite2.rotation = 90;
        [self addChild:sprite2];
        
        CCSprite *spirte3 = [CCSprite spriteWithFile:@"logo.png"];
        spirte3.position = CGPointMake(size.width * 9 / 10, size.height * 2 / 5);
        spirte3.rotation = 90;
        [self addChild:spirte3];
        
        [CCMenuItemFont setFontName:@"STHeitiK-Medium"];
        [CCMenuItemFont setFontSize:50];
        CCMenuItemFont *item1 = [CCMenuItemFont itemFromString:@"New Game" target:self selector:@selector(NewGameTouch:)];
        item1.color = ccBLACK;
//        item1.rotation = 90;
        
        CCMenuItemFont *item2 = [CCMenuItemFont itemFromString:@"Continue"];
        item2.color = ccBLACK;
//        item2.rotation = 90;
        
        CCMenuItemFont *item3 = [CCMenuItemFont itemFromString:@"Album"];
        item3.color = ccBLACK;
        
        CCMenu *menu = [CCMenu menuWithItems:item1, item2, item3, nil];

        menu.position = CGPointMake(size.width * 4 / 7, size.height * 1 / 5);
//        menu.position = CGPointMake(size.width / 2, size.height / 2);
        menu.anchorPoint = CGPointMake(0, 0);
        [self addChild:menu ];
        [menu alignItemsVerticallyWithPadding:5];
//        [menu alignItemsHorizontallyWithPadding:5];

        menu.rotation = 90;
        
        
    }
    return self;
}

- (void)NewGameTouch:(id)sender
{
    NSLog(@"touch");
    
    [userManager destoryUserManager];
    CCTransitionFade *tran = [CCTransitionFade transitionWithDuration:1 scene:[GameLoad scene] withColor:ccBLACK];
    [[CCDirector sharedDirector]replaceScene:tran];
}

@end
