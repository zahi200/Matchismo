//
//  ViewController.m - Ex3
//  Ex3
//
//  Created by Zahi Ajami on 24/07/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "ViewController.h"
#import "CardMatchingGame.h"
#import "HistoryViewController.h"

@interface ViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
//@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSegmentedControl;
@property (weak, nonatomic) IBOutlet UITextView *lastMoveTextView;
@property (nonatomic) NSInteger lastMoveScore;

@end

@implementation ViewController

- (CardMatchingGame *)game {
  if (!_game) {
    NSUInteger matchMode = [self getNumOfCardsInMatch];
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                              usingDeck:[self createDeck]
                                              matchMode:matchMode];
    // TODO: is it ok to do here matchmode = viewController isMemberOf playing/set ?
  }
  return _game;
}

- (NSAttributedString *)gameHistory {
  if (!_gameHistory) {
    _gameHistory = [[NSMutableAttributedString alloc] init];
  }
  return _gameHistory;
}

// abstract
- (Deck *)createDeck {
  return nil;
}

// abstract
- (void)updateCardButtonUI:(Card *)card cardButton:(UIButton *)cardButton {
}

// abstract
- (NSUInteger)getNumOfCardsInMatch {
  assert(NO);
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender {
//  self.modeSegmentedControl.enabled = NO;
  NSInteger scoreBeforeLastMove = self.game.score;
  NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
  [self.game chooseCardAtIndex:chosenButtonIndex];
  self.lastMoveScore = self.game.score - scoreBeforeLastMove;
  [self updateUI];
}

-(void) updateUI {
  for (UIButton *cardButton in self.cardButtons) {
    NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
    Card *card = [self.game cardAtIndex:cardButtonIndex];
    [self updateCardButtonUI:card cardButton:cardButton];
    cardButton.enabled = !card.isMatched;
  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
  [self updateLastMove];
}

// reset the score and the UI
- (IBAction)touchRedealButton:(UIButton *)sender {
//  self.modeSegmentedControl.enabled = YES;
  NSUInteger numOfCardsInMatch = self.game.numOfCardsInMatch;
  self.game = nil;
  self.game.numOfCardsInMatch = numOfCardsInMatch;
  self.gameHistory = nil;
  [self updateUI];
}

// abstract
- (NSAttributedString *)getCardAttributedString:(Card *)card {
  return nil;
}

- (void)updateLastMove {
  NSArray *chosenCards = [self.game chosenCardsInLastMove];
  NSMutableAttributedString *attStrToShow = [[NSMutableAttributedString alloc] init];
  NSAttributedString *chosenCardsAttStr = [self getChosenCardsAttStr:chosenCards];
  if ([chosenCards count] == [self getNumOfCardsInMatch]) {
    if (self.lastMoveScore > 0) {
      attStrToShow = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
      [attStrToShow appendAttributedString:chosenCardsAttStr];
      NSAttributedString *ending = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"for %ld points", self.lastMoveScore + 1]]; // +1 to cancel the reduction for doing this move
      [attStrToShow appendAttributedString:ending];
    } else if (self.lastMoveScore < 0) {
      attStrToShow = [chosenCardsAttStr mutableCopy];
      
      NSAttributedString *end = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"don't match! %ld points penalty", -self.lastMoveScore - 1]  attributes:@{                                                    NSFontAttributeName : [UIFont  fontWithName:@"Palatino-Roman" size:15.0]                                                                                                                                                                                                                                           }];
      [attStrToShow appendAttributedString:end];
    }
  } else {
    attStrToShow = [chosenCardsAttStr mutableCopy];
  }
  [self.lastMoveTextView setAttributedText:attStrToShow];
  [self.gameHistory appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n"]];
  [self.gameHistory appendAttributedString:attStrToShow];
}

// returns the attributed string that represents all the chosen cards in the last move
- (NSAttributedString *)getChosenCardsAttStr:(NSArray *)cards {
  NSMutableAttributedString *chosenCardsAttributedString = [[NSMutableAttributedString alloc] init];
  
  for (Card *card in cards) {
    [chosenCardsAttributedString appendAttributedString:[self getCardAttributedString:card]];
    [chosenCardsAttributedString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" "]];
  }
  
  return chosenCardsAttributedString;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"playingCardGameHistory"] || [segue.identifier isEqualToString:@"setGameHistory"]) {
    if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
      HistoryViewController *historyViewController = (HistoryViewController *)segue.destinationViewController;
      historyViewController.historyAttributedString = self.gameHistory;
    }
  }
}

@end
