//
//  ParallaxBackground.m
//  ShipGame
//
//  Created by 陈 京 on 12-10-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ParallaxBackground.h"
//#define kNumSprite 7

@implementation ParallaxBackground
//@synthesize spriteBatch = _spriteBatch;
-(id) init
{
	if ((self = [super init]))
	{
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
		
		// Get the game's texture atlas texture by adding it. Since it's added already it will simply return
		// the CCTexture2D associated with the texture atlas.
		CCTexture2D* gameArtTexture = [[CCTextureCache sharedTextureCache] addImage:@"game-art.pvr.ccz"];
		
		// Create the background spritebatch
		spriteBatch = [CCSpriteBatchNode batchNodeWithTexture:gameArtTexture];
		[self addChild:spriteBatch];
		CCLOG(@"@@@@@@@@@@@");
		CCLOG(@"%@",spriteBatch.children.count);
		// Add the 6 different layer objects and position them on the screen
		for (int i = 0; i < 7; i++)
		{
			NSString* frameName = [NSString stringWithFormat:@"bg%i.png", i];
			CCSprite* sprite = [CCSprite spriteWithSpriteFrameName:frameName];
			sprite.position = CGPointMake(screenSize.width / 2, screenSize.height / 2);
			[spriteBatch addChild:sprite z:i];
		}
		
		//scrollSpeed = 1.0f;
		//[self scheduleUpdate];
	}
	
	return self;
}

- (void) dealloc
{
	[super dealloc];
}
@end
