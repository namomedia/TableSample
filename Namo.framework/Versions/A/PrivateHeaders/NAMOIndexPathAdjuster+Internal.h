// Copyright (c) 2013 Namo Media, Inc. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NAMOIndexPathAdjuster.h"

@class NAMOAdsInfo;

typedef void(^NAMOContinuationBlock)();

@interface NAMOIndexPathAdjuster (Internal)

/**
 An index path adjuster which doesn't actually adjust anything. Useful as a sentinel value
 when a table isn't yet bound.
*/
+ (NAMOIndexPathAdjuster *)nonAdjustingAdjuster;

/**
 Returns original sizes for each section.
*/
- (NSArray *)sectionSizes;

/**
 Set the original sizes for each section.
*/
- (void)putSectionSizes:(NSArray *)sectionSizes;


/**
 Clears all the ad data from the adjuster. Should be followed by a call to reloadData and reloadViewData
 */
- (void)clearAdData;

/**
 Sets the currently loaded ad data.
 */
- (void)addAdData:(NSArray *)adData
        positions:(NSArray *)positions
continuationBlock:(NAMOContinuationBlock)continuationBlock;

/**
 Takes an array of index paths and returns an array of adjusted paths (possible including additional ads) to insert.
 Should be followed immediately by a call to the table/collection view's insertRowsAtIndexPaths method.
*/
- (NSArray *)insertRowsAtIndexPaths:(NSArray *)indexPaths;

/**
 Takes an array of index paths to delete and return an array of adjusted index paths that should be deleted.
 Should be followed immediately by a call to the table/collection view's deleteRowsAtIndexPaths method.
*/
- (NSArray *)deleteRowsAtIndexPaths:(NSArray *)indexPaths;

/**
 @see UITableView+NAMOAdPlacer.h
*/
- (void)moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;

@end
