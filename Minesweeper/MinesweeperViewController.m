//
//  MinesweeperViewController.m
//  Minesweeper
//
//  Created by Jeremy Levine on 2/1/14.
//  Copyright (c) 2014 Jeremy Levine. All rights reserved.
//

#import "MinesweeperViewController.h"
#import "MinesweeperButton.h"

@interface MinesweeperViewController ()

@end

@implementation MinesweeperViewController

static NSInteger const GAME_HEIGHT = 9;
static NSInteger const GAME_WIDTH = 9;
static NSInteger const GAME_MINE_COUNT = (GAME_HEIGHT*GAME_WIDTH)/8;
static NSString * const IMAGE_NAME_IN_PROGRESS = @"minesweeper_smiley.png";
static NSString * const IMAGE_NAME_WON = @"minesweeper_sunglasses";
static NSString * const IMAGE_NAME_LOST = @"minesweeper_frowny.png";
static NSString * const IMAGE_NAME_FLAG = @"minesweeper_flag.png";
static NSString * const IMAGE_NAME_BOMB_X = @"minesweeper_bomb_X.png";



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.75 alpha:1];
    [self newGame:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) newGame:(UIButton *)sender
{
    [self.view.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    self.game = [[MinesweeperGame alloc] initWithWidth:GAME_WIDTH AndHeight:GAME_HEIGHT AndMineCount:GAME_MINE_COUNT];
    self.buttonArray = [[NSMutableArray alloc] init];
    self.faceButton = [[UIButton alloc] init];
    [self.faceButton setImage:[UIImage imageNamed:IMAGE_NAME_IN_PROGRESS] forState:UIControlStateNormal];
    self.faceButton.frame = CGRectMake(self.view.frame.size.width/2-50/2, 30, 50, 50);
    self.faceButton.backgroundColor = [UIColor grayColor];
    self.faceButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.faceButton.layer.borderWidth = 2.0f;
    self.faceButton.layer.cornerRadius = 25.0f;
    self.faceButton.clipsToBounds = YES;
    [self.faceButton addTarget:self action:@selector(newGame:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.faceButton];
    
    self.timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-16-80, 30, 80, 50)];
    self.timeCount = @0;
    self.timerLabel.text = [self labelString:self.timeCount];
    self.timerLabel.textAlignment = NSTextAlignmentCenter;
    self.timerLabel.layer.backgroundColor = [UIColor blackColor].CGColor;
    self.timerLabel.textColor = [UIColor redColor];
    [self.timerLabel setFont:[UIFont systemFontOfSize:45]];
    self.timerLabel.layer.cornerRadius = 5.0f;
    [self.view addSubview:self.timerLabel];
    
    self.flagLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 30, 80, 50)];
    self.flagCount = @(GAME_MINE_COUNT);
    self.flagLabel.text = [self labelString:self.flagCount];
    self.flagLabel.textAlignment = NSTextAlignmentCenter;
    self.flagLabel.layer.backgroundColor = [UIColor blackColor].CGColor;
    self.flagLabel.textColor = [UIColor redColor];
    [self.flagLabel setFont:[UIFont systemFontOfSize:45]];
    self.flagLabel.layer.cornerRadius = 5.0f;
    [self.view addSubview:self.flagLabel];
    
    
    self.clickTypeButton = [[UISegmentedControl alloc] initWithItems: @[@"Reveal", @"Flag", @"Question"]];
    self.clickTypeButton.frame = CGRectMake(self.view.frame.size.width/2-self.clickTypeButton.frame.size.width/2, self.view.frame.size.height-self.clickTypeButton.frame.size.height-16, self.clickTypeButton.frame.size.width, self.clickTypeButton.frame.size.height);
    [self.clickTypeButton setSelectedSegmentIndex:0];
    [self.view addSubview:self.clickTypeButton];
    
    for(int i = 0; i < GAME_HEIGHT; i++) {
        for (int j = 0; j < GAME_WIDTH; j++) {
            self.button = [[MinesweeperButton alloc] initWithLocation: CGPointMake(j,i) andBlock:self.game.board[j][i] andTag:(i*GAME_HEIGHT+j)];
            [self.buttonArray addObject:self.button];
            [self.view addSubview:self.button];
            [self.button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    [self.timer invalidate];
}

-(void) onTick:(NSTimer *)timer {
    self.timeCount = @(self.timeCount.intValue + 1);
    self.timerLabel.text = [self labelString:self.timeCount];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTick:) userInfo:nil repeats:NO];

}

-(NSString *) labelString: (NSNumber *) num {
    if(num.intValue < 10) {
        return [NSString stringWithFormat:@"00%i",num.intValue];
    }
    else if(self.timeCount.intValue < 100) {
        return [NSString stringWithFormat:@"0%i",num.intValue];
    }
    else if(self.timeCount.intValue < 1000) {
        return [NSString stringWithFormat:@"%i",num.intValue];
    }
    else
        return @"---";
}


-(void) click:(MinesweeperButton *)sender
{
    if(!self.timer || !self.timer.isValid)
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTick:) userInfo:nil repeats:NO];

    if(self.game.gameStatus == STATUS_LOST || self.game.gameStatus == STATUS_WON) return;
    
    if(self.clickTypeButton.selectedSegmentIndex == 0 && sender.block.marking == MARKING_BLANK) {
        [self.game clickedAtColumn: sender.point.x AndRow: sender.point.y];
        for(MinesweeperButton *b in self.buttonArray) {
            if(b.block.marking == MARKING_CLICKED) {
                b.enabled = NO;
            }
            else if(b.block.marking == MARKING_BLANK) {
                [b setTitle:@"" forState:UIControlStateNormal];
                [b setImage:nil forState:UIControlStateNormal];
            }
        }
    }
    else if(self.clickTypeButton.selectedSegmentIndex == 1) {
        if(sender.block.marking == MARKING_BLANK && self.flagCount.intValue > 0) {
            sender.block.marking = MARKING_FLAGGED;
            self.flagCount = @(self.flagCount.intValue - 1);
            [sender setImage:[UIImage imageNamed:IMAGE_NAME_FLAG] forState:UIControlStateNormal];
        }
        else if(sender.block.marking == MARKING_FLAGGED) {
            sender.block.marking = MARKING_BLANK;
            self.flagCount = @(self.flagCount.intValue + 1);
            [sender setImage:nil forState:UIControlStateNormal];
        }
    }
    else if(self.clickTypeButton.selectedSegmentIndex == 2) {
        if(sender.block.marking == MARKING_BLANK) {
            sender.block.marking = MARKING_QUESTION;
            [sender setImage:nil forState:UIControlStateNormal];
            [sender setTitle:@"?" forState:UIControlStateNormal];
        }
        else if(sender.block.marking == MARKING_QUESTION) {
            sender.block.marking = MARKING_BLANK;
            [sender setImage:nil forState:UIControlStateNormal];
            [sender setTitle:nil forState:UIControlStateNormal];
        }
    }
    self.flagLabel.text = [self labelString:self.flagCount];
    if(self.game.gameStatus == STATUS_LOST) [self gameLost:sender];
    else if(self.game.gameStatus == STATUS_WON) [self gameWon];
}

-(void) gameLost:(MinesweeperButton *)sender {
    [self.timer invalidate];
    [self.faceButton setImage:[UIImage imageNamed:IMAGE_NAME_LOST] forState:UIControlStateNormal];
    for(MinesweeperButton *b in self.buttonArray) {
        if(b.block.isMine) {
            b.enabled = NO;
        }
        else if(!b.block.isMine && b.block.marking == MARKING_FLAGGED) {
            [b setImage:[UIImage imageNamed:IMAGE_NAME_BOMB_X] forState:UIControlStateNormal];
        }
    }
    sender.backgroundColor = [UIColor redColor];
    
}

-(void) gameWon {
    [self.timer invalidate];
    [self.faceButton setImage:[UIImage imageNamed:IMAGE_NAME_WON] forState:UIControlStateNormal];
    for(MinesweeperButton *b in self.buttonArray) {
        if(b.block.isMine) {
            [b setImage:[UIImage imageNamed:IMAGE_NAME_FLAG] forState:UIControlStateNormal];
            [b setTitle:nil forState:UIControlStateNormal];
        }
    }
}

@end
