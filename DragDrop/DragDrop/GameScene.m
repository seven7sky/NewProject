//
//  GameScene.m
//  DragDrop
//
//  Created by 陈 京 on 12-10-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
@interface GameScene(privateMethod)
- (void) selectSpriteForTouch:(CGPoint) para;
@end

@implementation GameScene
@synthesize spriteArray = _spriteArray;
@synthesize selectSprite = _selectSprite;
@synthesize background = _background;

+ (CCScene *) scene
{
	CCScene *scene = [CCScene node];
	GameScene *layer = [GameScene node];//很重要
	[scene addChild:layer];
	return scene;
}
- (id) init
{
	if (self = [super init])
	{
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
		//background
		[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"all-hd.plist"];
		CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"all-hd.pvr.ccz"];
		[self addChild:spriteSheet];
		CCSpriteFrame *backgroundFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"blue-shooting-stars.png"];
		_background = [CCSprite spriteWithSpriteFrame:backgroundFrame];
		//background.position = ccp(screenSize.width*0.5f, screenSize.height*0.5f);
		_background.anchorPoint = ccp(0, 0);
		[spriteSheet addChild:_background];
		//改变底层颜色
		//CCLayerColor *layerColor = [CCLayerColor layerWithColor:ccc4(255, 255, 0, 255)];
		//[self addChild:layerColor z:0];
		//background方法2测试
		/*[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
		CCSprite *back = [CCSprite spriteWithFile:@"blue-shooting-stars.png"];
		back.anchorPoint = ccp(0, 0);
		 [self addChild:back];*/
		//label测试
		/*CCLabelTTF *label = [CCLabelTTF labelWithString:@"TEST"  fontName:@"Marker Felt" fontSize:44];
		label.position = ccp(screenSize.width*0.5f, screenSize.height*0.5f);
		label.color = ccBLACK;//字体默认为白色
		[self addChild:label z:2];*/
		//添加sprite
		_spriteArray = [[NSMutableArray alloc] init];//这句代码少了害死人啊！！！！！！
		NSArray *nameArray = [NSArray arrayWithObjects:@"bird.png",@"cat.png",@"dog.png",@"turtle.png", nil];
		for (int i = 0 ; i <nameArray.count ; i++)
		{
			NSString *name = [nameArray objectAtIndex:i];
			CCSprite *sprite = [CCSprite spriteWithFile:name];
			float radio = ((float)(i+1))/(nameArray.count + 1);
			//CCLOG(@"%f",radio);
			sprite.position = ccp(radio*screenSize.width, screenSize.height*0.5f);
			[self addChild:sprite];
			[_spriteArray addObject:sprite];
		}
		//CCLOG(@"@@@@@@@@@@@@@");
		//CCLOG(@"%@",_spriteArray);
		self.isTouchEnabled = YES;
	}
	return self;
}


- (void) dealloc
{
	[super dealloc];
}

#pragma mark Touch
- (void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:YES];
}
- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
	[self selectSpriteForTouch:touchLocation];
	//CCLOG(@"@@@@@@@@@@@@@1");
	return YES;
}
- (void) selectSpriteForTouch:(CGPoint)para
{
	CCSprite *newSprite = nil;
	//CCLOG(@"@@@@@@@@@@@@@2222");
	
	//
	for (CCSprite *sprite in _spriteArray)
	{
		//CCLOG(@"@@@@@@@@@@@@@2");
		if (CGRectContainsPoint(sprite.boundingBox, para))
		{
			newSprite = sprite;
			//CCLOG(@"@@@@@@@@@@@@@3");
			break;
		}
	}
	//
	if (newSprite != _selectSprite)
	{
		[self.selectSprite stopAllActions];
		[self.selectSprite runAction:[CCRotateTo actionWithDuration:0.1f angle:0]];
		CCRotateTo *rotLeft = [CCRotateTo actionWithDuration:0.1 angle:-4.0];
		CCRotateTo *rotCenter = [CCRotateTo actionWithDuration:0.1f angle:0.0];
		CCRotateTo *rotRight = [CCRotateTo actionWithDuration:0.1 angle:4.0];
		CCSequence *rotSeq = [CCSequence actions:rotRight,rotCenter,rotLeft, nil];
		[newSprite runAction:[CCRepeatForever actionWithAction:rotSeq]];
		_selectSprite = newSprite;
	}
}

- (CGPoint) boundLayerPos: (CGPoint)newPos
{
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	CGPoint retval = newPos;
	//注意该处的逻辑关系
	retval.x = MIN(retval.x, 0);
	retval.x = MAX(retval.x, -_background.contentSize.width + winSize.width);
	CCLOG(@"@@@@@@@@@@@@@3");
	CCLOG(@"%f",-_background.contentSize.width + winSize.width);
	retval.y = self.position.y;
	return retval;
}
- (void) panForTranslation:(CGPoint) translation
{
	if (_selectSprite)
	{
		CGPoint newPos = ccpAdd(_selectSprite.position, translation);
		_selectSprite.position = newPos;
	}else
	{
		//CCLOG(@"@@@@@@@@@@@@@3");
		CGPoint newPos = ccpAdd(self.position, translation);
		self.position = [self boundLayerPos:newPos];
		
	}
}
- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	//上个点位置
	CGPoint lastTouchLocation = [touch previousLocationInView:touch.view];
	lastTouchLocation = [[CCDirector sharedDirector] convertToGL:lastTouchLocation];
	lastTouchLocation = [self convertToNodeSpace:lastTouchLocation];
	//当前点位置
	CGPoint currentTouchLocation = [self convertTouchToNodeSpace:touch];
	CGPoint translation = ccpSub(currentTouchLocation, lastTouchLocation);
	[self panForTranslation:translation];
	
}
@end
