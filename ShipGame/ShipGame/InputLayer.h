//
//  InputLayer.h
//  ShipGame
//
//  Created by 陈 京 on 12-10-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

//SneakyInput
#import "Sneaky+Extension.h"


@interface InputLayer : CCLayer
{
    SneakyButton *_fireButton;
	ccTime totalTime;
	ccTime nextShotTime;
}

@end
