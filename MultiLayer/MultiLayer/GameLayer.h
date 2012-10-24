//
//  GameLayer.h
//  MultiLayer
//
//  Created by 陈 京 on 12-10-12.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "LayerManage.h"
@interface GameLayer : CCLayer
{
    CGPoint gameLayerPosition;
	CGPoint lastTouchLocation;
}

@end
