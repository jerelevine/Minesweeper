//
//  MinesweeperButton.m
//  Minesweeper
//
//  Created by Jeremy Levine on 2/1/14.
//  Copyright (c) 2014 Jeremy Levine. All rights reserved.
//

#import "MinesweeperButton.h"

@implementation MinesweeperButton

static NSInteger const BLOCK_HEIGHT = 32;
static NSInteger const BLOCK_WIDTH = 32;
static NSInteger const TOP_GAP = 100;
static NSString *const IMAGE_NAME_BOMB = @"minesweeper_bomb.png";

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}

- (instancetype) initWithLocation:(CGPoint)point andBlock:(MinesweeperBlock *)block andTag:(NSInteger)tag{
    self = [super initWithFrame:CGRectMake(point.x*BLOCK_WIDTH+BLOCK_WIDTH/2.0f, point.y*BLOCK_HEIGHT+TOP_GAP, BLOCK_WIDTH, BLOCK_HEIGHT)];
    if (self) {
        self.block = block;
        [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self setTitle:[block print] forState:UIControlStateDisabled];
        if(block.isMine)
            [self setImage:[UIImage imageNamed:IMAGE_NAME_BOMB] forState:UIControlStateDisabled];
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self setTitleColor:block.color forState:UIControlStateDisabled];
        
        [self.titleLabel setFont:[UIFont systemFontOfSize:BLOCK_HEIGHT/2.0f]];
        self.backgroundColor = [UIColor grayColor];
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 2.0f;
        self.layer.cornerRadius = 3.0f;
        self.clipsToBounds = YES;
        self.point = point;
        self.tag = tag;
    }
    return self;
}

-(void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if(enabled) self.backgroundColor = [UIColor grayColor];
    else self.backgroundColor = [UIColor lightGrayColor];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
