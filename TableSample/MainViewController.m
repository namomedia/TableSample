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

#import <AdSupport/AdSupport.h>
#import <Namo/Namo.h>
#import <Parse/Parse.h>

#import "MainViewController.h"

#import "ContentCell.h"
#import "AdContentCell.h"

@interface MainViewController ()
@property(nonatomic, strong) NSArray *content;
@property(nonatomic, strong) NAMOTableViewAdPlacer *adPlacer;
@end

@implementation MainViewController

- (id)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:style];
  if (self) {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor lightGrayColor];
    self.tableView.rowHeight = [ContentCell desiredHeight];

    self.content = [NSArray array];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"TableSample";
  [self.tableView registerClass:[ContentCell class]
         forCellReuseIdentifier:[ContentCell reuseIdentifier]];
  
  // Namo Media initialization:
  NSString *testId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
  [Namo setTestDevices:[NSArray arrayWithObjects:testId, nil] includeSimulator:YES];
  
  self.adPlacer = [NAMOTableViewAdPlacer placerForTableView:self.tableView];
  [self.adPlacer registerAdFormat:AdContentCell.class];
  
  [self.adPlacer requestAdsWithTargeting:nil];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  // load info from Parse
  PFQuery *query = [PFQuery queryWithClassName:@"BoardItem"];
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    if (!error) {
      self.content = objects;
      [self.tableView namo_reloadData];
    } else {
      // Log details of the failure
      NSLog(@"Error: %@ %@", error, [error userInfo]);
    }
  }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.content count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:[ContentCell reuseIdentifier]
                                                      forIndexPath:indexPath];

  PFObject *object = [self.content objectAtIndex:indexPath.item];
  cell.labelTitle.text = [object objectForKey:@"title"];
  cell.labelLikes.text =
      [NSString stringWithFormat:@"%i likes", [[object objectForKey:@"countLikes"] intValue]];
  cell.labelRepins.text =
      [NSString stringWithFormat:@"%i repins", [[object objectForKey:@"countRepins"] intValue]];
  cell.labelRepinnedBy.text = [object objectForKey:@"repinnedBy"];

  cell.imageViewPicture.file = [object objectForKey:@"picture"];
  [cell.imageViewPicture loadInBackground];
  cell.imageViewRepinnedBy.file = [object objectForKey:@"repinnedByPicture"];
  [cell.imageViewRepinnedBy loadInBackground];

  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return [ContentCell desiredHeight];
}

@end
