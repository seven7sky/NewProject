//
//  UILayer.h
//  MultiLayer
//
//  Created by 陈 京 on 12-10-12.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "LayerManage.h"
typedef enum
{
	UILayerTagFrameSprite,
}UILayerTags;

@interface UILayer : CCLayer
{
    //BOOL isTouchMe;
}
- (BOOL) istouchForMe:(CGPoint)touchLocation;
@end
