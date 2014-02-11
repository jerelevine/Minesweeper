//
//  MinesweeperViewController.h
//  Minesweeper
//
//  Created by Jeremy Levine on 2/1/14.
//  Copyright (c) 2014 Jeremy Levine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MinesweeperButton.h"
#import "MinesweeperGame.h"


@interface MinesweeperViewController : UIViewController
@property (strong, nonatomic) MinesweeperButton *button;
@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) MinesweeperGame *game;
@property (strong, nonatomic) UISegmentedControl *clickTypeButton;
@property (strong, nonatomic) UIButton *faceButton;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) UILabel *timerLabel;
@property (strong, nonatomic) UILabel *flagLabel;
@property (nonatomic) NSNumber *timeCount;
@property (nonatomic) NSNumber *flagCount;
@property (strong, nonatomic) UIView *subview;

@end
