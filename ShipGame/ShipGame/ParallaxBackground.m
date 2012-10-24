//
//  ParallaxBackground.m
//  ShipGame
//
//  Created by 陈 京 on 12-10-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ParallaxBackground.h"


@implementation ParallaxBackground
@synthesize spriteBatch = _spriteBatch;

- (id) init
{
	if (self = [super init])
	{
		//size
		CGSize screenSize = [CCDirector sharedDirector].winSize;
		//texture
		CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage:@"game-art.pvr.ccz"];
		_spriteBatch = [CCSpriteBatchNode batchNodeWithTexture:texture];
		[self addChild:_spriteBatch];
		//add background1
		numSprites = 7;
		for (int i = 0; i < numSprites; i++)
		{
			NSString *name = [NSString stringWithFormat:@"bg%i.png",i];
			CCSprite *tmpSprite = [CCSprite spriteWithSpriteFrameName:name];
			tmpSprite.position = ccp(0, screenSize.height*0.5f);
			tmpSprite.anchorPoint = ccp(0, 0.5f);
			[_spriteBatch addChild:tmpSprite z:i tag:i];//分层放置背景
		}
		//add background2
		for (int j = 0; j < numSprites; j++)
		{
			NSString *name1 = [NSString stringWithFormat:@"bg%i.png",j];
			CCSprite *tmpSprite1 = [CCSprite spriteWithSpriteFrameName:name1];
			tmpSprite1.position = ccp(screenSize.width-1, screenSize.height*0.5f);//采用1个像素点来减少闪烁
			tmpSprite1.anchorPoint = ccp(0, 0.5f);
			tmpSprite1.flipX = YES;
			[_spriteBatch addChild:tmpSprite1 z:j tag:numSprites+j];
		}
		//speed
		_speedFactors = [[CCArray alloc] initWithCapacity:numSprites];
		[_speedFactors addObject:[NSNumber numberWithFloat:0.3f]];
		[_speedFactors addObject:[NSNumber numberWithFloat:0.5f]];
		[_speedFactors addObject:[NSNumber numberWithFloat:0.5f]];
		[_speedFactors addObject:[NSNumber numberWithFloat:0.8f]];
		[_speedFactors addObject:[NSNumber numberWithFloat:0.8f]];
		[_speedFactors addObject:[NSNumber numberWithFloat:1.2f]];
		[_speedFactors addObject:[NSNumber numberWithFloat:1.2f]];
		NSAssert([_speedFactors count]==numSprites, @"mismatch");
		_scrollSpeed = 0.3f;
		[self scheduleUpdate];
	}
return self;
}
- (void) dealloc
{
	[_speedFactors release];
	[super dealloc];
}

- (void) update:(ccTime)delta
{
	CCSprite *sprite;
	CGSize screenSize = [[CCDirector sharedDirector] winSize];
	//ccarray的用法
	CCARRAY_FOREACH([_spriteBatch children], sprite)
	{
		CGPoint pos = sprite.position;
		NSNumber *factor = [_speedFactors objectAtIndex:sprite.zOrder];
		pos.x -= _scrollSpeed*[factor floatValue]*(delta*100);
		if (pos.x < -screenSize.width)
		{
			pos.x += (screenSize.width*2)-2;
		}
		sprite.position = pos;
	}
	

}
@end
