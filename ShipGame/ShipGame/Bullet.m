//
//  Bullet.m
//  ShipGame
//
//  Created by 陈 京 on 12-10-15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Bullet.h"
#import "Ship.h"

@interface Bullet (PrivateMethods)
-(id) initWithShip:(Ship*)ship;
-(id) initWithBulletImage;
@end

@implementation Bullet
@synthesize velocity;


+ (id) bullet
{
	return [[[self alloc] initWithBulletImage] autorelease];
}
- (id) initWithBulletImage
{
	// Uses the Texture Atlas now.
	if (self = [super initWithSpriteFrameName:@"bullet.png"])
	{
	}
	
	return self;
}
- (void) shootBulletFromShip:(Ship *)ship
{
	//y轴随机速度
	float spread = (CCRANDOM_0_1() - 0.5f) * 0.5f;
	velocity = CGPointMake(100, spread*100);
	//屏幕界限
	outsideScreen = [[CCDirector sharedDirector] winSize].width;
	//初始位置
	self.position = CGPointMake(ship.position.x + 45, ship.position.y - 19);
	self.visible = YES;
	// stop "update" in case we reuse the bullet
	[self unscheduleUpdate];
	// run "update" with every frame redraw
	[self scheduleUpdate];
}
- (void) update:(ccTime)delta
{
	// update position of the bullet
    // multiply the velocity by the time since the last update was called
    // this ensures same bullet velocity even if frame rate drops
	self.position = ccpAdd(self.position, ccpMult(velocity, delta));//确保不会因为帧速率下滑而变化
	if (self.position.x>outsideScreen)
	{
		self.visible = NO;
		[self unscheduleUpdate];
	}
}

@end
