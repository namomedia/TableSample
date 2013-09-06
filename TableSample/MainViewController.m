//
//  MainViewController.m
//  TableSample
//
//  Created by Gabor Cselle on 9/2/13.
//  Copyright (c) 2013 Namo Media. All rights reserved.
//
#import <NamoAdsSDK/Namo.h>
#import <Parse/Parse.h>

#import "MainViewController.h"

#import "ContentCell.h"

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

  self.adPlacer = [NAMOTableViewAdPlacer adPlacer];
  [self.adPlacer bindToTableView:self.tableView];
  [self.adPlacer setAdPlacementWithFirstPosition:2 spacing:3 maxAds:10];
  self.title = @"TableSample";
  
  [self.tableView registerClass:[ContentCell class]
         forCellReuseIdentifier:[ContentCell reuseIdentifier]];
  [self.tableView namo_registerAdCellClass:[NAMOTableViewAdCellThumb class]];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.adPlacer requestAds];
  
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

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // Navigation logic may go here. Create and push another view controller.
  /*
   <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
   // ...
   // Pass the selected object to the new view controller.
   [self.navigationController pushViewController:detailViewController animated:YES];
   */
}

@end
