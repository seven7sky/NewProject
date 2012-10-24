//
//  NSObject+Extension.h
//  ShipGame
//
//  Created by 陈 京 on 12-10-18.
//
//

#import <Foundation/Foundation.h>
#import "ColoredCircleSprite.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"

@interface SneakyButton(Extension)
+ (id) button;
+ (id) buttonWithRect:(CGRect)rect;
@end

@interface SneakyButtonSkinnedBase(Extension)
+ (id) skinnedButton;
@end