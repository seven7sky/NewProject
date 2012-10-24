//
//  GameScene.h
//  DragDrop
//
//  Created by 陈 京 on 12-10-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameScene : CCLayer//<CCTargetedTouchDelegate>
{
	NSMutableArray *_spriteArray;
	CCSprite *_selectSprite;
	CCSprite *_background;
}
@property (nonatomic) NSMutableArray *spriteArray;
@property (nonatomic) CCSprite *selectSprite;
@property (nonatomic) CCSprite *background;
+ (CCScene *) scene;

@end
