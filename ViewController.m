//
//  ViewController.m
//  Matchismo
//
//  Created by Zahi Ajami on 24/07/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *lastMoveLabel;
@end

@implementation ViewController

- (CardMatchingGame *)game
{
    if (!_game){
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]
                    matchMode:[self getMatchMode:self.modeSegmentedControl.selectedSegmentIndex]];
    }
    return _game;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}


- (IBAction)touchCardButton:(UIButton *)sender
{
    self.modeSegmentedControl.enabled = NO;
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}


- (NSInteger)getMatchMode:(NSInteger)selectedSegmentIndex {
    if (selectedSegmentIndex==0){
        return 2;
    } else if (selectedSegmentIndex == 1){
        return 3;
    } else {
        return -1;
    }
}

//segmented control changed
- (IBAction)switchMatchMode:(UISegmentedControl *)sender
{
    self.game.numOfCardsInMatch = [self getMatchMode:sender.selectedSegmentIndex];
}

-(void) updateUI
{
    for (UIButton *cardButton in self.cardButtons){
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
    self.lastMoveLabel.text = self.game.currentStateText;
}

- (IBAction)touchRedealButton:(UIButton *)sender
{
    // reset the score and the UI
    self.modeSegmentedControl.enabled = YES;
    self.game = nil; // TODO - maybe next line is not needed?!
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]
                    matchMode:[self getMatchMode:self.modeSegmentedControl.selectedSegmentIndex]];
    [self updateUI];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen? @"cardfront" : @"cardback"];
}

@end
