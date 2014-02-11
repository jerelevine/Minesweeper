//
//  MinesweeperGame.m
//  Minesweeper
//
//  Created by Jeremy Levine on 2/1/14.
//  Copyright (c) 2014 Jeremy Levine. All rights reserved.
//

#import "MinesweeperGame.h"

@implementation MinesweeperGame

-(instancetype) init {
    self = [super init];
    return self;
}

-(instancetype) initWithWidth:(NSInteger)w AndHeight:(NSInteger)h AndMineCount:(NSInteger)numMines
{
    self = [super init];
    if(self) {
        _gameStatus = STATUS_IN_PROGRESS;
        self.width = w;
        self.height = h;
        self.board = [NSMutableArray arrayWithCapacity:self.width];
        for(int i = 0; i < self.width; i++) {
            self.board[i] = [NSMutableArray arrayWithCapacity:self.height];
            for(int j = 0; j < self.height; j++) {
                self.board[i][j] = [[MinesweeperBlock alloc] init];
            }
        }
    
    
        int mineCounter = 0;
        while(mineCounter < numMines) {
            int col = arc4random() % self.width;
            int row = arc4random() % self.height;
            MinesweeperBlock *block = self.board[col][row];
            if(!block.isMine) {
                block.isMine = YES;
                mineCounter++;
            }
        }
    
        for(int i = 0; i < self.width; i++) {
            for(int j = 0; j < self.height; j++) {
                [((MinesweeperBlock *) self.board[i][j]) setNumberOfBorderingMines: [self findNumberOfMinesForColumn:i AndRow:j]];
            }
        }
    }
    return self;
}

-(NSInteger)findNumberOfMinesForColumn:(NSInteger)col AndRow:(NSInteger)row
{
    int mineCounter = 0;
    MinesweeperBlock *block = self.board[col][row];
    if(!(block.isMine)) {
        // looks in all the different directions
        for (int dCol = -1; dCol<=1; dCol++) {
            for (int dRow = -1; dRow<=1; dRow++) {
                if([self isOnBoardWithColumn:(col+dCol) AndRow:(row+dRow)] && ((MinesweeperBlock*)self.board[col+dCol][row+dRow]).isMine)
                mineCounter++;
            }
        }
        return mineCounter;
    }
    else {
        return -1;
    }
}

-(BOOL)isOnBoardWithColumn:(NSInteger)col AndRow:(NSInteger)row {
    return (col > -1 && col < self.width && row > -1 && row < self.height) ? YES: NO;
}

-(void)clickedAtColumn:(NSInteger)column AndRow:(NSInteger)row {
    if([self.board[column][row] isMine]) _gameStatus = STATUS_LOST;
    [self.board[column][row] clicked];
    [self revealAtColumn:column AndRow:row];
    if([self didWinGame]) _gameStatus = STATUS_WON;
}

-(BOOL) didWinGame {
    for(int i = 0; i < self.width; i++) {
        for(int j = 0; j < self.height; j++) {
            MinesweeperBlock *b = self.board[i][j];
            if(!b.isMine && b.marking != MARKING_CLICKED)
                return NO;
        }
    }
    return YES;
}

-(void)revealAtColumn:(NSInteger)column AndRow:(NSInteger)row {
    if ([self.board[column][row] numberOfBorderingMines] == 0) {
        [self.board[column][row] clicked];
        // checks neighbors in all directions
        for (int dCol = -1; dCol<=1; dCol++) {
            for (int dRow = -1; dRow<=1; dRow++) {
                [self continueRevealAtColumn:column+dCol AndRow:row+dRow];
            }
        }
    }
    else if ([self.board[column][row] numberOfBorderingMines] > 0) {
        [self.board[column][row] clicked];
    }
}

-(void)continueRevealAtColumn:(NSInteger)column AndRow:(NSInteger)row {
    if ([self isOnBoardWithColumn:column AndRow:row] && ![self.board[column][row] isMine] && [self.board[column][row] marking] != MARKING_CLICKED && [self.board[column][row]marking] != MARKING_FLAGGED) {
        [self revealAtColumn:column AndRow:row];
    }
}

@end
