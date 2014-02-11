//
//  MinesweeperButton.h
//  Minesweeper
//
//  Created by Jeremy Levine on 2/1/14.
//  Copyright (c) 2014 Jeremy Levine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MinesweeperBlock.h"

@interface MinesweeperButton : UIButton

@property (nonatomic) CGPoint point;
@property (strong, nonatomic) MinesweeperBlock * block;

- (instancetype) initWithLocation:(CGPoint)point andBlock:(MinesweeperBlock *) block andTag:(NSInteger)tag;


@end
