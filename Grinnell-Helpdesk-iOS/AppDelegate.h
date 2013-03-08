//
//  AppDelegate.h
//  Grinnell-Helpdesk-iOS
//
//  Created by Colin Tremblay on 2/11/13.
//  Copyright (c) 2013 __GrinnellAppDev__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IssuesViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) IssuesViewController *viewController;
@property (nonatomic, strong) IBOutlet UINavigationController *navController;

@end
