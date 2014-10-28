//
//  AppDelegate.h
//  asyncsocketDemo
//
//  Created by vic on 14-7-21.
//  Copyright (c) 2014年 vic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "chatViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    chatViewController *ChatViewControll;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) chatViewController *ChatViewControll;


@end
