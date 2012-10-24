//
//  Bullet.h
//  ShipGame
//
//  Created by 陈 京 on 12-10-15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class Ship;

@interface Bullet : CCSprite
{
	CGPoint velocity;
	float outsideScreen;
}
@property (readwrite, nonatomic) CGPoint velocity;
+(id) bullet;
-(void) shootBulletFromShip:(Ship*)ship;
@end
