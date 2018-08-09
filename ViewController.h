//
//  ViewController.h
//  Ex3
//
//  Created by Zahi Ajami on 24/07/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//
// Abstract class.

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface ViewController : UIViewController

/// abstract
- (Deck *)createDeck;
/// abstract - updates the relevant UI to \c card represented by the button \c cardButton
- (void)updateCardButtonUI:(Card *)card cardButton:(UIButton *)cardButton;
/// abstract - get the number of cards to match in the game
- (NSUInteger)getNumOfCardsInMatch;
/// abstract - returns the attributed string representation of \c card
- (NSAttributedString *)getCardAttributedString:(Card *)card;

/// holds the entire history for this game
@property (strong, nonatomic) NSMutableAttributedString *gameHistory;

@end

