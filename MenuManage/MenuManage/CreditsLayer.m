//
//  CreditsLayer.m
//  MenuManage
//
//  Created by 陈 京 on 12-10-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CreditsLayer.h"


@implementation CreditsLayer
- (id) init
{
	if (self = [super init])
	{
		CGSize screenSize = [[CCDirector sharedDirector] winSize];
		//label
		CCLabelTTF *title = [CCLabelTTF labelWithString:@"Credits" fontName:@"Marker Felt" fontSize:48];
		title.position = ccp(screenSize.width*0.5f, screenSize.height*0.7f);
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
