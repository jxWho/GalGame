//
//  GameLoad.h
//  galGame
//
//  Created by god on 13-7-26.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameLoad : CCScene {
    BOOL flag;
}

+ (id)scene;
- (id)initWithTargetScene;
@end
