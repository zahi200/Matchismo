//
//  PlayingCard.m
//  Matchismo
//
//  Created by Zahi Ajami on 25/07/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard


- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (PlayingCard *otherCard in otherCards){
        if (self == otherCard){
            continue;
        }
        if (otherCard.rank == self.rank){
            score += 4;
        } else if ([otherCard.suit isEqualToString:self.suit]){
            score += 1;
        }
    }

    return score;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *)validSuits
{
    return @[@"♣︎",@"\u2764\uFE0F",@"♠︎",@"♦"];
}


+ (NSArray *)rankStrings
{
  return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank {
  return [[self rankStrings] count] - 1;
}

- (void) setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}

- (void) setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}
@end
