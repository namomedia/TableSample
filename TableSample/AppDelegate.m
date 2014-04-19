//  Copyright (c) 2013 Namo Media. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Parse/Parse.h>

#import "AppDelegate.h"
#import "MainViewController.h"

@implementation AppDelegate

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [Parse setApplicationId:@"U8ipUhuguVcq8zid2nIH1OU7jvwYuBi2G2QBzUqT"
                clientKey:@"JYq1sRB1ZBh6AmD0UvGNVsLq5DwyIr5PnZikF1QN"];
  // [Namo setApplicationId:@"app-test-id"];
  ///NSString *testId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
  // [Namo setTestDevices:@[testId] includeSimulator:YES];

  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  MainViewController *mainVC = [[MainViewController alloc] init];
  UINavigationController
      *navigationController = [[UINavigationController alloc] initWithRootViewController:mainVC];
  [self.window setRootViewController:navigationController];
  [self.window makeKeyAndVisible];

  return YES;
}

@end
