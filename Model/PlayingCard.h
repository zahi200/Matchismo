//
//  PlayingCard.h
//  Matchismo
//
//  Created by Zahi Ajami on 25/07/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString* suit;
@property (nonatomic) NSUInteger rank; // from 0 (rank not set) to 13 (=King)

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
