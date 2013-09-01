//
//  GameScene.h
//  galGame
//
//  Created by god on 13-7-26.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "gameBackGroundScene.h"
#import "subtitleScene.h"

@interface GameScene : CCLayer {
    CCSprite *showTimeSprite;
    BOOL showTimeFlag;
    NSInteger timeShow;
    
    NSInteger currentIndex;
    
    @public
    gameBackGroundScene *gScene;
    subtitleScene *sScene;
}

@property(nonatomic, assign) CCLabelTTF *label;



+ (id)scene;
+ (id)shareGameSceneInstance;

@end
