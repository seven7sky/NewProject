//
//  Ship.m
//  ShipGame
//
//  Created by 陈 京 on 12-10-15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Ship.h"
#import "GameScene.h"
#import "CCAnimationHelper.h"
#import "Bullet.h"

@interface Ship (PrivateMethods)
-(id) initWithShipImage;
@end

@implementation Ship
+ (id) ship
{
	return [[[self alloc] initWithShipImage] autorelease];
}
-(id) initWithShipImage
{
	if (self = [super initWithSpriteFrameName:@"ship.png"])
	{
		//creat Animation
		CCAnimation *animation = [CCAnimation animationWithFrame:@"ship-anim" frameCount:5 delay:0.08f];//use help
		CCAnimate *animate = [CCAnimate actionWithAnimation:animation];
		CCRepeatForever *repeat = [CCRepeatForever actionWithAction:animate];
		[self runAction:repeat];
		[self scheduleUpdate];
	}
	return self;
}
- (void) update:(ccTime)delta
{
	// Shooting is relayed to the game scene
	//[[GameScene sharedGameScene] shootBulletFromShip:self];
}
@end
