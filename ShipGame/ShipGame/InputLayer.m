//
//  InputLayer.m
//  ShipGame
//
//  Created by 陈 京 on 12-10-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "InputLayer.h"
#import "GameScene.h"
@interface InputLayer (PrivateMethods)
-(void) addFireButton;
@end

@implementation InputLayer
- (id) init
{
	if (self = [super init])
	{
		[self addFireButton];
		[self scheduleUpdate];
	}
	return self;
}
- (void) dealloc
{
	[super dealloc];
}

- (void) addFireButton
{
	float buttonRadius = 50;
	CGSize screenSize = [CCDirector sharedDirector].winSize;
	_fireButton = [SneakyButton button];
	_fireButton.isHoldable = YES;
	//skinButton
	SneakyButtonSkinnedBase *skinFireButton = [SneakyButtonSkinnedBase skinnedButton];
	//_fireButton.radius = buttonRadius;
	//_fireButton.position = ccp(screenSize.width - buttonRadius, buttonRadius);
	
	skinFireButton.position = ccp(screenSize.width - buttonRadius, buttonRadius);
	skinFireButton.defaultSprite = [CCSprite spriteWithSpriteFrameName:@"fire-button-idle.png"];
	skinFireButton.pressSprite = [CCSprite spriteWithSpriteFrameName:@"fire-button-pressed.png"];
	skinFireButton.button = _fireButton;
	
	[self addChild:skinFireButton];

}
- (void) update:(ccTime)delta
{
	totalTime += delta;
	if (_fireButton.active && totalTime > nextShotTime)
	{
		nextShotTime = totalTime + 0.5f;
		GameScene *game = [GameScene sharedGameScene];
		[game shootBulletFromShip:[game defaultShip]];
		
		CCLOG(@"FIRE!!!");
	}
	if (_fireButton.active==NO)
	{
		nextShotTime = 0;
	}
	/*if (_fireButton.active)
	{
				CCLOG(@"FIRE!!!");
	}*/
}

@end
