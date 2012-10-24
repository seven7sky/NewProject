//
//  NSObject+Extension.m
//  ShipGame
//
//  Created by 陈 京 on 12-10-18.
//
//

#import "Sneaky+Extension.h"

@implementation SneakyButton (Extension)
+ (id) button
{
	return [[[SneakyButton alloc] initWithRect:CGRectZero] autorelease];
}
+ (id) buttonWithRect:(CGRect)rect
{
	return [[[SneakyButton alloc] initWithRect:rect] autorelease];
}
@end

@implementation SneakyButtonSkinnedBase(Extension)

+ (id) skinnedButton
{
	return [[[SneakyButtonSkinnedBase alloc] init] autorelease];
}

@end