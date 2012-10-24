//
//  ParallaxBackground.h
//  ShipGame
//
//  Created by 陈 京 on 12-10-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ParallaxBackground : CCNode
{
    CCSpriteBatchNode *_spriteBatch;
	int numSprites;
	CCArray *_speedFactors;
	float _scrollSpeed;
}
@property (nonatomic, readwrite) CCSpriteBatchNode *spriteBatch;

@end
