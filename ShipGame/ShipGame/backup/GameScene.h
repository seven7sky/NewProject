//
//  GameScene.h
//  ShipGame
//
//  Created by 陈 京 on 12-10-15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.



//从该例可以学习半单例、纹理集、代码优化

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ParallaxBackground.h"
@class Ship;
typedef enum
{
	GameSceneNodeTagBullet = 1,
	GameSceneNodeTagBulletSpriteBatch,
	
} GameSceneNodeTags;

@interface GameScene : CCLayer
{
    int nextInactiveBullet;
}
+ (id) scene;
+ (GameScene *) sharedGameScene;
- (CCSpriteBatchNode *)bulletSpriteBatch;
- (void) shootBulletFromShip:(Ship *)ship;
@end
