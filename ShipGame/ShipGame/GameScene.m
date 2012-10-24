//
//  GameScene.m
//  ShipGame
//
//  Created by 陈 京 on 12-10-15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "Ship.h"
#import "Bullet.h"
#import "InputLayer.h"


@interface GameScene (PrivateMethods)
-(void) countBullets:(ccTime)delta;
@end


@implementation GameScene
static GameScene* instanceOfGameScene;

+ (GameScene *) sharedGameScene
{
	NSAssert(instanceOfGameScene != nil, @"GameScene instance not yet init");
	return instanceOfGameScene;
}

+(id) scene
{
	CCScene *scene = [CCScene node];
	//game layer
	GameScene *layer = [GameScene node];
	[scene addChild: layer z:0 tag:GameSceneLayerTagGame];
	//input layer
	InputLayer* inputLayer = [InputLayer node];
	[scene addChild:inputLayer z:1 tag:GameSceneLayerTagInput];	
	return scene;
}
- (id) init
{
	if (self = [super init])
	{
		instanceOfGameScene = self;
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
		//add texture atlas
		[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"game-art.plist"];//单例，可以在各处引用
		CCLOG(@"@@@@@@@@@@@");
		CCLOG(@"%@",[CCSpriteFrameCache sharedSpriteFrameCache]);
		CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"game-art.pvr.ccz"];
		[self addChild:spriteSheet];
		//add background
		//CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
		//background.position = ccp(screenSize.width*0.5f, screenSize.height*0.5f);
		ParallaxBackground *background = [ParallaxBackground node];
		[self addChild:background z:-1];
		//add ship
		Ship *ship = [Ship ship];
		ship.position = ccp(screenSize.width*0.17f, screenSize.height*0.5f);
		[self addChild:ship z:2 tag:GameSceneNodeTagShip];
		// Now uses the image from the Texture Atlas.
		CCSpriteFrame *bulletFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bullet.png"];
		CCSpriteBatchNode *bulletBatch = [CCSpriteBatchNode batchNodeWithTexture:bulletFrame.texture];//新建一个bulletBatch
		[self addChild:bulletBatch z:1 tag:GameSceneNodeTagBulletSpriteBatch];
		// Create a number of bullets up front and re-use them whenever necessary.
		//优化代码
		for (int i = 0; i <400; i++)
		{
			Bullet *bullet = [Bullet bullet];
			bullet.visible = NO;
			[bulletBatch addChild:bullet];
		}
		[self schedule:@selector(countBullets:) interval:3];
	}
	return self;
}
- (void) countBullets:(ccTime)delta
{
	CCLOG(@"Number of active Bullets: %i", [self.bulletSpriteBatch.children count]);
}
- (CCSpriteBatchNode *) bulletSpriteBatch
{
	CCNode *node = [self getChildByTag:GameSceneNodeTagBulletSpriteBatch];
	NSAssert([node isKindOfClass:[CCSpriteBatchNode class]], @"not abullet");
	
	return  (CCSpriteBatchNode *)node;
}
//三处shootBulletFromShip的区别
//GameScene是用于生成一次shoot任务的
//ship是调用GameScene的shoot
//bullet是用于更新子弹的位置的
- (void) shootBulletFromShip:(Ship *)ship
{
	CCArray *bullets = [self.bulletSpriteBatch children];
	//
	CCNode *node = [bullets objectAtIndex:nextInactiveBullet];
	NSAssert([node isKindOfClass:[Bullet class]], @"not is bullet");
	Bullet *bullet = (Bullet *) node;
	
	[bullet shootBulletFromShip:ship];
	nextInactiveBullet++;
	if (nextInactiveBullet >=[bullets count])
	{
		nextInactiveBullet = 0;
	}
}

- (void) dealloc
{
	instanceOfGameScene = nil;
	[super dealloc];
}
- (Ship *)defaultShip
{
	CCNode *node = [self getChildByTag:GameSceneNodeTagShip];
	NSAssert([node isKindOfClass:[Ship class]], @"node is not ship");
	return (Ship *)node;
}

@end
