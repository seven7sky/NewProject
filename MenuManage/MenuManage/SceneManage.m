//
//  SceneManage.m
//  MenuManage
//
//  Created by 陈 京 on 12-10-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "SceneManage.h"
@interface SceneManage()
+ (void) go:(CCLayer *)layer;
+ (CCScene *) wrap:(CCLayer *)layer;
@end


@implementation SceneManage
+ (void) goMenu
{
	CCLayer *menuLayer = [MenuLayer node];
	[SceneManage go:menuLayer];
}
+ (void) goNewGame
{
	CCLayer *gameLayer = [NewGameLayer node];
	[SceneManage go:gameLayer];
}
+ (void) goCredits
{
	CCLayer *creditsLayer = [CreditsLayer node];
	[SceneManage go:creditsLayer];
}
#pragma mark private
+ (void) go:(CCLayer *)layer
{
	CCDirector *director = [CCDirector sharedDirector];
	CCScene *newScene = [SceneManage wrap:layer];
	//判断是否运行着scene
	if ([director runningScene])
	{
		//加入过渡效果
		//[director replaceScene:[CCTransitionFlipX transitionWithDuration:1.0f scene:newScene]];
		[director replaceScene:newScene];
	} else
	{
		[director runWithScene:newScene];
	}
}
+ (CCScene *)wrap:(CCLayer *)layer
{
	CCScene *newScene = [CCScene node];
	[newScene addChild:layer];
	return newScene;
}
@end
