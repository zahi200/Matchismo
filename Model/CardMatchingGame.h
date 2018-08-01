//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Zahi Ajami on 29/07/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

/// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;
///
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                        matchMode:(NSUInteger)mode;
///
- (void)chooseCardAtIndex:(NSUInteger)index;

///
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, strong, readonly) NSString *currentStateText;
@property (nonatomic) NSUInteger numOfCardsInMatch; // 2 or 3 in our case

@end
