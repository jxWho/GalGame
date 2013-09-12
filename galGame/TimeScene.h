//
//  TimeScene.h
//  galGame
//
//  Created by god on 13-8-3.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface TimeScene : CCLayer {
    CCSprite *timeShowSprite;
    NSInteger showTime;
    
    NSString *timeString;
}


+ (id)scene;
- (void)setTimeString:(NSString *)newString;

@end
