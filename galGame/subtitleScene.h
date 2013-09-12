//
//  subtitleScene.h
//  galGame
//
//  Created by god on 13-7-27.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface subtitleScene : CCLayer {
    NSInteger currentIndex;
    CCSprite *panelBG;
    
    CCLabelTTF *label;
    NSInteger count;
    
    CCSprite *timeSprite;
    NSInteger showTime;
    BOOL showTimeFlag;
    
    BOOL isAutoFlag;
    
    CCSprite *iconSprite;
    CCLabelTTF *iconName;
    
    NSInteger currentIconNumber;
    
    CCArray *iconArray;
    
    CCSprite *shellSprite;
    NSString *currentShell;
    NSMutableDictionary *shellDictionary;
}

@property(nonatomic, retain) CCSprite *bg;


+ (id)scene;


@end
