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

    
    CCLabelTTF *label;
    NSInteger count;
    
    CCSprite *timeSprite;
    NSInteger showTime;
    BOOL showTimeFlag;
    
    BOOL isAutoFlag;
}

@property(nonatomic, retain) CCSprite *bg;


+ (id)scene;


@end
