//
//  baseLayer.m
//  MenuManage
//
//  Created by 陈 京 on 12-10-12.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "baseLayer.h"


@implementation baseLayer
- (id) init
{
	if (self = [super init])
	{
		CCSprite *background = [CCSprite spriteWithFile:@"sf-flyer.png"];
		background.position = ccp(240, 160);
		[self addChild:background z:0];//注意层次
	}
	return self;
}

@end
