//
//  UILayer.m
//  MultiLayer
//
//  Created by 陈 京 on 12-10-12.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "UILayer.h"


@implementation UILayer

- (id) init
{
	if (self = [super init])
	{
		//add sprite
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
		CCSprite *uiFrame = [CCSprite spriteWithFile:@"ui-frame.png"];
		uiFrame.position = CGPointMake(0, screenSize.height);
		uiFrame.anchorPoint = CGPointMake(0, 1);
		[self addChild:uiFrame z:0 tag:UILayerTagFrameSprite];
		//add label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Here be your Game Scores ets" fontName:@"Courier" fontSize:22];
		label.color = ccBLACK;
		label.position = ccp(screenSize.width*0.5f, screenSize.height);
		label.anchorPoint = ccp(0.5f, 1);
		[self addChild:label];
		self.isTouchEnabled = YES;
	}
	return  self;
}
- (void) dealloc
{
	[super dealloc];
}

- (void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
}
- (BOOL) istouchForMe:(CGPoint)touchLocation
{
	CCNode *node = [self getChildByTag:UILayerTagFrameSprite];
	return CGRectContainsPoint([node boundingBox], touchLocation);
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint location = [LayerManage locationFromTouch:touch];
	BOOL isTouch = [self istouchForMe:location];
	if (isTouch)
	{
		CCNode *node = [self getChildByTag:UILayerTagFrameSprite];
		((CCSprite *)node).color = ccRED;
		//Rotate & Zoom the game layer
		CCRotateBy *rotate = [CCRotateBy actionWithDuration:4 angle:360];
		CCScaleTo *scaleDown = [CCScaleTo actionWithDuration:2 scale:0];
		CCScaleTo *scaleUp = [CCScaleTo actionWithDuration:2 scale:1];
		CCSequence *sequence = [CCSequence actions:scaleDown,scaleUp, nil];
		sequence.tag = ActionTagGameLayerRotates;
		GameLayer *gameLayer = [LayerManage sharedLayer].gameLayer;
		// Reset GameLayer properties modified by action so that the end result is always the same.注意重置过程的重要性
		[gameLayer stopActionByTag:ActionTagGameLayerRotates];
		[gameLayer setRotation: 0];
		[gameLayer setScale:1];
		// Run the actions on the game layer.
		[gameLayer runAction:rotate];
		[gameLayer runAction:sequence];		
	}
	return isTouch;
}
- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	CCNode *node = [self getChildByTag:UILayerTagFrameSprite];
	NSAssert([node isKindOfClass:[CCSprite class]], @"node is not a CCsprite");
	((CCSprite *)node).color = ccWHITE;
}
@end
