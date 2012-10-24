//
//  LayerManage.h
//  MultiLayer
//
//  Created by 陈 京 on 12-10-12.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


// Using an enum to define tag values has the upside that you can select
// tags by name instead of having to remember each individual number.
typedef enum
{
	LayerTagGameLayer,
	LayerTagUILayer,
} MultiLayerSceneTags;

typedef enum
{
	ActionTagGameLayerMoveBack,
	ActionTagGameLayerRotates,
} MultiLayerSceneActionTags;
// Class forwards: if a class is used in a header file only to define a member variable or return value,
// then it's more effective to use the @class keyword rather than #import the class header file.
// When projects grow large this helps to reduce the time it takes to compile the project.
@class GameLayer;
@class UILayer;


@interface LayerManage : CCLayer
{
    BOOL isTouchForUI;
}
+ (LayerManage *) sharedLayer;
@property (readonly) GameLayer* gameLayer;
@property (readonly) UILayer* uiLayer;
+ (CGPoint) locationFromTouch:(UITouch *)touch;
+ (CGPoint) locationFromTouches:(NSSet *)touches;
+ (id) scene;
@end
