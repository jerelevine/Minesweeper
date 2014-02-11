//
//  MinesweeperBlock.m
//  Minesweeper
//
//  Created by Jeremy Levine on 2/1/14.
//  Copyright (c) 2014 Jeremy Levine. All rights reserved.
//

#import "MinesweeperBlock.h"

@implementation MinesweeperBlock

@synthesize numberOfBorderingMines = _numberOfBorderingMines;

-(instancetype) init {
    self = [super init];
    if(self) {
        self.marking = MARKING_BLANK;
        self.isMine = NO;
    }
    return self;
}

-(NSString *) print {
    if(self.isMine) return @"M";
    else return [NSString stringWithFormat:@"%i",self.numberOfBorderingMines];
}

-(NSInteger) numberOfBorderingMines {
    return _numberOfBorderingMines;
}

-(void) clicked {
    if(self.marking == MARKING_BLANK || self.marking == MARKING_QUESTION)
        self.marking = MARKING_CLICKED;
}


-(void) setNumberOfBorderingMines:(NSInteger)numberOfBorderingMines {
    _numberOfBorderingMines = numberOfBorderingMines;
    switch (numberOfBorderingMines) {
            case -1:
                _color = [UIColor blackColor];
                break;
            case 0:
                _color =  [UIColor clearColor];
                break;
            case 1:
                _color =  [UIColor blueColor];
                break;
            case 2:
                _color =  [UIColor colorWithRed:35.0f/255.0f green:115.0f/255.0f blue:55.0f/255.0f alpha:1];
                break;
            case 3:
                _color =  [UIColor colorWithRed:1 green:40.0f/255.0f blue:40.0f/255.0f alpha:1];
                break;
            case 4:
                _color =  [UIColor colorWithRed:0 green:0 blue:140.0f/255.0f alpha:1];
                break;
            case 5:
                _color =  [UIColor colorWithRed:135.0f/255.0f green:10.0f/255.0f blue:25.0f/255.0f alpha:1];
                break;
            case 6:
                _color =  [UIColor colorWithRed:50.0f/255.0f green:50.0f/255.0f blue:160.0f/255.0f alpha:1];
                break;
            case 7:
                _color =  [UIColor blackColor];
                break;
            case 8:
                _color =  [UIColor colorWithRed:105.5f/255.0f green:105.5f/255.0f blue:105.5f/255.0f alpha:1];
                break;
            default:
                _color =  [UIColor clearColor];
                break;
    }
}

@end
