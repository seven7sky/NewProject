//
//  GameLayer.m
//  MultiLayer
//
//  Created by 陈 京 on 12-10-12.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
@interface GameLayer(PrivateMethod)
- (void) addRandomThings;
@end

@implementation GameLayer

- (id) init
{
	if (self = [super init]) {
		self.isTouchEnabled = YES;
		gameLayerPosition = self.position;
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
		CCSprite *background = [CCSprite spriteWithFile:@"grass.png"];
		background.position = ccp(screenSize.width*0.5f, screenSize.height*0.5f);
		[self addChild:background];
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"GameLayer" fontName:@"Marker Felt" fontSize:44];
		label.position = ccp(screenSize.width*0.5f, screenSize.height*0.5f);
		label.color = ccBLACK;
		label.anchorPoint = ccp(0.5f, 1);
		[self addChild:label];
		[self addRandomThings];
		
	}
return self;
}
// I want the pseudo game objects to move around a bit to illustrate that their movement is always
// relative to the Layer's position.
- (void) runRandomMoveSequence:(CCNode *)node
{
	float duration = CCRANDOM_0_1() * 5 + 1;
	CCMoveBy *move1 = [CCMoveBy actionWithDuration:duration position:ccp(-180, 0)];
	CCMoveBy *move2 = [CCMoveBy actionWithDuration:duration position:ccp(0, -180)];
	CCMoveBy *move3 = [CCMoveBy actionWithDuration:duration position:ccp(180, 0)];
	CCMoveBy *move4 = [CCMoveBy actionWithDuration:duration position:ccp(0, 180)];
	CCSequence *sequence = [CCSequence actions:move1,move2,move3,move4, nil];
	CCRepeatForever *repeat = [CCRepeatForever actionWithAction:sequence];
	[node runAction:repeat];
}
// Faking game objects, they just move around.
- (void) addRandomThings
{
	CGSize screenSize = [[CCDirector sharedDirector] winSize];
	for (int i =0; i < 4; i++)
	{
		CCSprite *firething = [CCSprite spriteWithFile:@"firething.png"];
		firething.position = ccp(CCRANDOM_0_1()*screenSize.width, CCRANDOM_0_1()*screenSize.height);
		[self addChild:firething];
		[self runRandomMoveSequence:firething];
	}
	for (int i =0; i < 10; i++)
	{
		CCSprite *spider = [CCSprite spriteWithFile:@"spider.png"];
		spider.position = ccp(CCRANDOM_0_1() * screenSize.width, CCRANDOM_0_1() * screenSize.height);
		[self addChild:spider];
		[self runRandomMoveSequence:spider];
	}
}
- (void) dealloc
{
	[super dealloc];
}
- (void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}
- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	lastTouchLocation = [LayerManage locationFromTouch:touch];
	// Stop the move action so it doesn't interfere with the user's scrolling.
	[self stopActionByTag:ActionTagGameLayerMoveBack];
	return YES;
}
- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint currentTouchLocation = [LayerManage locationFromTouch:touch];
	CGPoint moveTO = ccpSub(lastTouchLocation, currentTouchLocation);
	moveTO = ccpMult(moveTO, -1);
	lastTouchLocation = currentTouchLocation;
	self.position = ccpAdd(self.position, moveTO);
}
- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	CCMoveTo *move = [CCMoveTo actionWithDuration:1 position:gameLayerPosition];
	CCEaseIn *ease = [CCEaseIn actionWithAction:move rate:0.5f];
	ease.tag = ActionTagGameLayerMoveBack;
	[self runAction:ease];
}

@end
