//
//  MinesweeperGame.h
//  Minesweeper
//
//  Created by Jeremy Levine on 2/1/14.
//  Copyright (c) 2014 Jeremy Levine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MinesweeperBlock.h"

@interface MinesweeperGame : NSObject

@property (strong, nonatomic) NSMutableArray *board;
@property (nonatomic) NSInteger height;
@property (nonatomic) NSInteger width;
@property (nonatomic, readonly) NSInteger gameStatus;

typedef enum
{
    STATUS_IN_PROGRESS,
    STATUS_WON,
    STATUS_LOST
} GAME_STATUS_STATE;


-(instancetype) initWithWidth:(NSInteger)width AndHeight:(NSInteger)height AndMineCount:(NSInteger)numMines;
-(void) clickedAtColumn:(NSInteger)column AndRow:(NSInteger)row;
//+(NSInteger)findNumberOfMinesForColumn:(NSInteger)col AndRow:(NSInteger)row;
@end
