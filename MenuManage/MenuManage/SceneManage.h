//
//  SceneManage.h
//  MenuManage
//
//  Created by 陈 京 on 12-10-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MenuLayer.h";
#import "NewGameLayer.h"
#import "CreditsLayer.h"

@interface SceneManage : CCScene
{
    
}
+ (void) goMenu;
+ (void) goNewGame;
+ (void) goCredits;
@end
