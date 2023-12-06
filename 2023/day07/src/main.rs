use std::fs;
use std::collections::HashMap;
use std::collections::HashSet;
use std::cmp::Ordering;

#[test]
fn tests() {
    let contents: &str = &fs::read_to_string("input_test.txt").expect("Failure");
    {
        let mut input = parse(contents, false);
        let res_p1 = part1(&mut input);
        assert!(res_p1 == 6440);
    }
    {
        let mut input = parse(contents, true);
        let res_p2 = part2(&mut input);
        assert!(res_p2 == 5905);
    }
}

fn main() {
    let contents: &str = &fs::read_to_string("input.txt").expect("Failure");
    {
        let mut input = parse(contents, false);
        let res_p1 = part1(&mut input);
        println!("part 1: {res_p1} | should be 250474325");
    }
    {
        let mut input = parse(contents, true);
        let res_p2 = part2(&mut input);
        println!("part 2: {res_p2} | should be 248909434");
    }
}
#[derive(Debug, Eq, PartialEq, Ord, PartialOrd)]
struct Hand {
    cards: String,
    bet: u32,
    handType: HandType,
}

#[derive(Debug, Eq, PartialEq, Ord, PartialOrd, Copy, Clone)]
#[allow(non_camel_case_types)]
enum HandType {
    FIVE_OF_A_KIND = 10,
    FOUR_OF_A_KIND = 9,
    FULL_HOUSE = 8,
    THREE_OF_A_KIND = 7,
    TWO_PAIR = 6,
    PAIR = 5,
    HIGH_CARD = 4,
}
 

fn get_card_value(card: char, withJoker: bool) -> u32 {
    match card {
        'A' => 14,
        'K' => 13,
        'Q' => 12,
        'J' => {
            if withJoker { return 1 }
            11
        },
        'T' => 10,
        _ => card.to_digit(10).unwrap(),
    }
}

fn compare_cards(card1: &str, card2: &str, withJoker: bool) -> Ordering {
    for (c1, c2) in card1.chars().zip(card2.chars()) {
        let res = get_card_value(c1, withJoker).cmp(&get_card_value(c2, withJoker));
        if res != Ordering::Equal {
            return res;
        }
    }
    Ordering::Equal
}

fn calculate_hand_type(hand: &str) -> HandType {
    let mut map = hand.chars().fold(HashMap::new(), |mut acc, card| {
        *acc.entry(card).or_insert(0) += 1;
        acc
    });

     match map.len() {
        1 => return HandType::FIVE_OF_A_KIND,
        2 => {
            if map.values().any(|&v| v == 4) {
                return HandType::FOUR_OF_A_KIND;
            }
            return HandType::FULL_HOUSE;
        },
        3 => {
            if map.values().any(|&v| v == 3) {
                return HandType::THREE_OF_A_KIND;
            }
            return HandType::TWO_PAIR;
        },
        4 => return HandType::PAIR,
        _ => return HandType::HIGH_CARD,
    }
}

fn parse_hand(hand: &str, withJoker:bool) -> HandType {
    if !withJoker || !hand.contains("J") {
        return calculate_hand_type(hand)
    }
    let mut hands = vec![];
    let mut cs: HashSet<char> = hand.chars().collect();
    cs.remove(&'J');
    cs.iter().for_each(|c| {
        let new_hand = hand.replace("J", &c.to_string());
        let hand_value = calculate_hand_type( &new_hand );
        hands.push( hand_value );
    });
    hands.sort_by(|a, b| b.cmp(a));

    match hands.len() {
        0 => return HandType::FIVE_OF_A_KIND,
        _ => return hands[0],
    }
}

fn parse(filecontent: &str, withJoker: bool) -> Vec<Hand> {
    filecontent.lines().map(|line| {
        let mut parts = line.split(" ");
        let cards = parts.next().unwrap().to_string();
        let bet = parts.next().unwrap().parse::<u32>().unwrap();
        let handType = parse_hand(&cards, withJoker);
        Hand { cards, bet, handType }
    }).collect()
}

fn part1(lines: &mut Vec<Hand>) -> u32 {
    lines.sort_by(|a, b| {
        match a.handType.cmp(&b.handType) {
            Ordering::Equal => compare_cards(&a.cards, &b.cards, false),
            _ => a.handType.cmp(&b.handType),
        }
    });

    lines.iter().enumerate().map(|(i, hand)| {
        (i as u32 +1) * hand.bet
    }).sum()
}

fn part2(lines: &mut Vec<Hand>) -> u32 {
    lines.sort_by(|a, b| {
        match a.handType.cmp(&b.handType) {
            Ordering::Equal => compare_cards(&a.cards, &b.cards, true),
            _ => a.handType.cmp(&b.handType),
        }
    });

    lines.iter().enumerate().map(|(i, hand)| {
        (i as u32 +1) * hand.bet
    }).sum()
}