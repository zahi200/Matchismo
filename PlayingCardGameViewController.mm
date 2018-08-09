// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Zahi Ajami.

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

static const int kNumOfCardsInMatchPlayingCardGame = 2;

- (Deck *)createDeck {
  return [[PlayingCardDeck alloc] init];
}

- (NSUInteger)getNumOfCardsInMatch {
  return kNumOfCardsInMatchPlayingCardGame;
}

- (void)updateCardButtonUI:(Card *)card cardButton:(UIButton *)cardButton {
  [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
  [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
}

- (NSString *)titleForCard:(Card *)card {
  return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
  return [UIImage imageNamed:card.isChosen? @"cardfront" : @"cardback"];
}

- (NSAttributedString *)getCardAttributedString:(Card *)card {
  return [[NSAttributedString alloc] initWithString:card.contents];
}

@end

