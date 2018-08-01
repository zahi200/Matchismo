//
//  Card.m
//  Matchismo
//
//  Created by Zahi Ajami on 25/07/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "Card.h"

@interface Card()

@end


@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}



@end
