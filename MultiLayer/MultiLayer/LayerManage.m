//
//  LayerManage.m
//  MultiLayer
//
//  Created by 陈 京 on 12-10-12.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "LayerManage.h"
#import "UILayer.h"
#import "GameLayer.h"


@implementation LayerManage
// Semi-Singleton: you can access MultiLayerScene only as long as it is the active scene.
static LayerManage * LayerManageInstance;
+ (LayerManage *) sharedLayer
{
	NSAssert(LayerManageInstance != nil,@"layerManageInstance not available");
	return LayerManageInstance;
}
// Access to the various layers by wrapping the getChildByTag method
// and checking if the received node is of the correct class.
- (GameLayer*) gameLayer
{
	CCNode* layer = [self getChildByTag:LayerTagGameLayer];
	NSAssert([layer isKindOfClass:[GameLayer class]], @"%@: not a GameLayer",NSStringFromSelector(_cmd));
	return (GameLayer *)layer;
}
- (UILayer*) uiLayer
{
	CCNode *layer = [self getChildByTag:LayerTagUILayer];
	NSAssert([layer isKindOfClass:[UILayer class]], @"%@: not a UILayer",NSStringFromSelector(_cmd));
	return (UILayer*) layer;
}
+ (CGPoint) locationFromTouch:(UITouch *)touch
{
	CGPoint touchLocation = [touch locationInView:[touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}
+ (CGPoint) locationFromTouches:(NSSet *)touches
{
	return [self locationFromTouches:[touches anyObject]];
}
+ (id)scene
{
	CCScene* scene = [CCScene node];
	LayerManage* layer = [LayerManage node];
	[scene addChild:layer];
	return scene;
}
- (id) init
{
	if (self = [super init])
	{
		NSAssert(LayerManageInstance == nil, @"another LayerManage is already in use");
		LayerManageInstance = self;//建立半单例的方法
		GameLayer *gameLayer = [GameLayer node];
		[self addChild:gameLayer z:1 tag:LayerTagGameLayer];
		
		UILayer *uiLayer = [UILayer node];
		[self addChild:uiLayer z:2 tag:LayerTagUILayer];
		//self.isTouchEnabled = YES;
	}
	return self;
}
- (void) dealloc
{
	LayerManageInstance = nil;
	[super dealloc];
}

@end
