//
//  AppDelegate.m
//  TableSample
//
//  Created by Gabor Cselle on 9/2/13.
//  Copyright (c) 2013 Namo Media. All rights reserved.
//

#import <NamoAdsSDK/Namo.h>
#import <Parse/Parse.h>

#import "AppDelegate.h"
#import "MainViewController.h"

@implementation AppDelegate

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [Parse setApplicationId:@"U8ipUhuguVcq8zid2nIH1OU7jvwYuBi2G2QBzUqT"
                clientKey:@"JYq1sRB1ZBh6AmD0UvGNVsLq5DwyIr5PnZikF1QN"];
  [Namo setApplicationId:@"a1-6d85054334e6a247910"];

  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

  MainViewController *mainVC = [[MainViewController alloc] init];

  UINavigationController
      *navigationController = [[UINavigationController alloc] initWithRootViewController:mainVC];

  [self.window setRootViewController:navigationController];

  [self.window makeKeyAndVisible];

  return YES;
}

@end
