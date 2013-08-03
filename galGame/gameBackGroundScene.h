//
//  gameBackGroundScene.h
//  galGame
//
//  Created by god on 13-7-27.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface gameBackGroundScene : CCLayer {
    NSInteger currentIndex;
}

@property(assign) CCSprite *bg;

@end
