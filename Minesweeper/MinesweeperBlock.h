//
//  MinesweeperBlock.h
//  Minesweeper
//
//  Created by Jeremy Levine on 2/1/14.
//  Copyright (c) 2014 Jeremy Levine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MinesweeperBlock : NSObject

@property (nonatomic) BOOL isMine;
@property (nonatomic) NSInteger marking;
@property (nonatomic) NSInteger numberOfBorderingMines;
@property (strong, nonatomic, readonly) UIColor * color;

typedef enum
{
    MARKING_BLANK,
    MARKING_FLAGGED,
    MARKING_QUESTION,
    MARKING_CLICKED
} MARKING_STATE;

-(instancetype) init;
-(NSString *) print;
-(void) clicked;

@end
