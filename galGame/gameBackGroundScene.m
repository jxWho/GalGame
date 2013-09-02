//
//  gameBackGroundScene.m
//  galGame
//
//  Created by god on 13-7-27.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "gameBackGroundScene.h"
#import "SimpleAudioEngine.h"
#import "userManager.h"

@implementation gameBackGroundScene

@synthesize bg = _bg;

- (id)init
{
//    CGSize size = [[CCDirector sharedDirector]winSize];
    
    if( self = [super init] ){
//        self.bg = [CCSprite spriteWithFile:@"0.png"];
//        self.bg.position = CGPointMake(size.width / 2, size.height / 2);
//        self.bg.rotation = 90;
//        [self addChild:self.bg ];
        
        currentIndex = 0;
        bgMusicName = nil;
//        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"0.mp3" loop:YES];
//        [[SimpleAudioEngine sharedEngine] playEffect:@"sound_打字.mp3"];
        [self scheduleUpdate];
    }
    return self;
}

- (void)update:(ccTime)delta
{
    CGSize size = [[CCDirector sharedDirector]winSize];

    userManager *UM = [userManager sharedUserManager];
    if( currentIndex != UM->currentCont ){
        NSDictionary *dd = [UM.getSayArray objectAtIndex:UM->currentCont];
        
        if( self.bg )
            [self.bg removeFromParentAndCleanup:YES];
        
        if( [dd objectForKey:@"bg"] && ![[dd objectForKey:@"bg"] isEqualToString:@""] ){
            self.bg = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png",[dd objectForKey:@"bg"]]];
            self.bg.position = CGPointMake(size.width / 2, size.height / 2);
            self.bg.rotation = 90;
            [self addChild:self.bg ];
        }
        
        if( [dd objectForKey:@"music"] &&
           ![[dd objectForKey:@"music"] isEqualToString:bgMusicName] ){
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:[NSString stringWithFormat:@"%@.mp3", [dd objectForKey:@"music"]] loop:YES];
            [[SimpleAudioEngine sharedEngine]setBackgroundMusicVolume:[userManager sharedUserManager]->musicVolume];
            bgMusicName = [dd objectForKey:@"music"];
        }
        
        
        if( [dd objectForKey:@"effect"] && ![[dd objectForKey:@"effect"] isEqualToString:@""] ){
            NSString *effectString = [dd objectForKey:@"effect"];
            if( [effectString rangeOfString:@"sound"].length > 0 ){
                [[SimpleAudioEngine sharedEngine] playEffect:[NSString stringWithFormat:@"%@.mp3", [dd objectForKey:@"effect"]]];
            }else{
                if( self.bg )
                    [self.bg removeFromParentAndCleanup:YES];
                NSString *effectPath = [[NSBundle mainBundle]pathForResource:[dd objectForKey:@"effect"] ofType:@"png"];
                if( [[NSFileManager defaultManager] fileExistsAtPath:effectPath] ){
                    self.bg = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png",[dd objectForKey:@"effect"]]];
                    self.bg.position = CGPointMake(size.width / 2, size.height / 2);
                    self.bg.rotation = 90;
                    [self addChild:self.bg ];
                }
            }
        }
        
        currentIndex = UM->currentCont;
    }
}

@end
