//
//  MenuLayer.m
//  MenuManage
//
//  Created by 陈 京 on 12-10-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#define kDelayTime 0.8f
#import "MenuLayer.h"


@implementation MenuLayer
- (id) init
{
	if (self = [super init])
	{
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
		//label
		//Action
		//CCLabelTTF *title = [CCLabelTTF labelWithString:@"Menu List" fontName:@"Marker Felt" fontSize:48.0f];
		CCLabelBMFont *title = [CCLabelBMFont labelWithString:@"Menu List" fntFile:@"font.fnt"];//利用了字体文件
		title.position = ccp(screenSize.width*0.5f, -80);
		//为title加入动画
		CCAction *action = [CCSequence actions:[CCDelayTime actionWithDuration:kDelayTime],
							[CCEaseBackOut actionWithAction:
							 [CCMoveTo actionWithDuration:1.0 position:ccp(screenSize.width*0.5f, screenSize.height*0.7f)]],nil];
		[title runAction:action];
		[self addChild:title];
		//menu
		//CCMenuItemFont *newGame = [CCMenuItemFont itemWithString:@"New Game" target:self selector:@selector(onNewGame)];
		CCMenuItemImage *newGame = [CCMenuItemImage itemWithNormalImage:@"buttonNormal.png" selectedImage:@"buttonSelected.png"  disabledImage:@"buttonNormal.png"  target:self selector:@selector(onNewGame)];
		CCMenuItemFont *credits = [CCMenuItemFont itemWithString:@"Credits" target:self selector:@selector(onCredits)];
		CCMenu *menu = [CCMenu menuWithItems:newGame,credits, nil];
		//为menu加入动画效果
		/*float delayTime = 1.0f;
		for (CCMenuItemFont *element in [menu children])
		{
			element.scaleX = 0.0f;
			element.scaleX = 0.0f;
			CCAction *menuAction = [CCSequence actions:
									[CCDelayTime actionWithDuration:delayTime],
									[CCScaleTo actionWithDuration:1.0f scale:1.0f],
									nil];
			delayTime += 0.5f;
			[element runAction:menuAction];
		}*///此段代码会引起app在频繁切换时stop，scaleX!=scaleY
		
		[menu alignItemsVerticallyWithPadding:40.0f];//设置Menu中的item的垂直间距
		menu.position = ccp(screenSize.width*0.5f, screenSize.height*0.4f);
		[self addChild:menu];
	}
	return self;
}
- (void) onNewGame
{
	[SceneManage goNewGame];
}
- (void) onCredits
{
	[SceneManage goCredits];
}
@end
