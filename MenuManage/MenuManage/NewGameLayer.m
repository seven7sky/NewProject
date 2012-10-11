//
//  NewGameLayer.m
//  MenuManage
//
//  Created by 陈 京 on 12-10-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//


#define kDelayTime 0.8f
#import "NewGameLayer.h"


@implementation NewGameLayer
- (id) init
{
	if (self = [super init])
	{
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
		//label
		//create action
		CCLabelTTF *title = [CCLabelTTF labelWithString:@"New Game" fontName:@"Marker Felt" fontSize:48];
		title.position = ccp(screenSize.width*0.5f, -80);
		CCAction *action = [CCSequence actions:[CCDelayTime actionWithDuration:kDelayTime], [CCEaseBackOut actionWithAction:[CCMoveTo actionWithDuration:1.0 position:ccp(screenSize.width*0.5f, screenSize.height*0.7f)]],nil];
		[title runAction:action];
		[self addChild:title];
		
		//menu
		CCMenuItemFont *back = [CCMenuItemFont itemWithString:@"Back" target:self selector:@selector(back)];
		CCMenu *menu = [CCMenu menuWithItems:back, nil];
		menu.position = ccp(screenSize.width*0.5f, screenSize.height*0.4f);
		[self addChild:menu];
		
	}
	return self;
}
- (void) back
{
	[SceneManage goMenu];
}
@end
