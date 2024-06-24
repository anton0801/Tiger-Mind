import Foundation

struct OrderItems {
    var items: [String]
    var order: [String: Int]
}

var orderItemsAll = [
    1: OrderItems(items: ["game_item_1", "game_item_2", "game_item_3", "game_item_4"], order: [
        "game_item_1": 1, "game_item_2": 2, "game_item_3": 3, "game_item_4": 4
    ]),
    2: OrderItems(items: ["game_item_2", "game_item_3", "game_item_1", "game_item_5", "game_item_6"], order: [
        "game_item_2": 1, "game_item_3": 2, "game_item_1": 3, "game_item_5": 4, "game_item_6": 5
    ]),
    3: OrderItems(items: ["game_item_6", "game_item_7", "game_item_8", "game_item_9", "game_item_10", "game_item_11"], order: [
        "game_item_6": 1, "game_item_7": 2, "game_item_8": 3, "game_item_9": 4, "game_item_10": 5, "game_item_11": 6
    ]),
    4: OrderItems(items: ["game_item_1", "game_item_2", "game_item_7", "game_item_11", "game_item_12", "game_item_13", "game_item_14"], order: [
        "game_item_1": 1, "game_item_2": 2, "game_item_7": 3, "game_item_11": 4, "game_item_12": 5, "game_item_13": 6, "game_item_14": 7
    ]),
    5: OrderItems(items: ["game_item_1", "game_item_2", "game_item_3", "game_item_13", "game_item_7", "game_item_8", "game_item_15", "game_item_6"], order: [
        "game_item_1": 1, "game_item_2": 2, "game_item_3": 3, "game_item_13": 4, "game_item_7": 5, "game_item_8": 6, "game_item_15": 7, "game_item_6": 8
    ]),
    6: OrderItems(items: ["game_item_1", "game_item_2", "game_item_7", "game_item_11", "game_item_12", "game_item_13", "game_item_14"], order: [
        "game_item_1": 1, "game_item_2": 2, "game_item_7": 3, "game_item_11": 4, "game_item_12": 5, "game_item_13": 6, "game_item_14": 7
    ]),
    7: OrderItems(items: ["game_item_2", "game_item_3", "game_item_1", "game_item_5", "game_item_6"], order: [
        "game_item_2": 1, "game_item_3": 2, "game_item_1": 3, "game_item_5": 4, "game_item_6": 5
    ]),
    8: OrderItems(items: ["game_item_1", "game_item_2", "game_item_7", "game_item_11", "game_item_12", "game_item_13", "game_item_14"], order: [
        "game_item_1": 1, "game_item_2": 2, "game_item_7": 3, "game_item_11": 4, "game_item_12": 5, "game_item_13": 6, "game_item_14": 7
    ]),
    9: OrderItems(items: ["game_item_1", "game_item_2", "game_item_7", "game_item_11", "game_item_12", "game_item_13", "game_item_14"], order: [
            "game_item_1": 1, "game_item_2": 2, "game_item_7": 3, "game_item_11": 4, "game_item_12": 5, "game_item_13": 6, "game_item_14": 7
        ]),
    10: OrderItems(items: ["game_item_1", "game_item_2", "game_item_7", "game_item_11", "game_item_12", "game_item_13", "game_item_14"], order: [
            "game_item_1": 1, "game_item_2": 2, "game_item_7": 3, "game_item_11": 4, "game_item_12": 5, "game_item_13": 6, "game_item_14": 7
        ]),
    11: OrderItems(items: ["game_item_1", "game_item_2", "game_item_7", "game_item_11", "game_item_12", "game_item_13", "game_item_14"], order: [
            "game_item_1": 1, "game_item_2": 2, "game_item_7": 3, "game_item_11": 4, "game_item_12": 5, "game_item_13": 6, "game_item_14": 7
        ]),
    12: OrderItems(items: ["game_item_6", "game_item_7", "game_item_8", "game_item_9", "game_item_10", "game_item_11"], order: [
        "game_item_6": 1, "game_item_7": 2, "game_item_8": 3, "game_item_9": 4, "game_item_10": 5, "game_item_11": 6
    ]),
    13: OrderItems(items: ["game_item_6", "game_item_7", "game_item_8", "game_item_9", "game_item_10", "game_item_11"], order: [
        "game_item_6": 1, "game_item_7": 2, "game_item_8": 3, "game_item_9": 4, "game_item_10": 5, "game_item_11": 6
    ]),
    14: OrderItems(items: ["game_item_1", "game_item_2", "game_item_3", "game_item_4"], order: [
        "game_item_1": 1, "game_item_2": 2, "game_item_3": 3, "game_item_4": 4
    ]),
    15: OrderItems(items: ["game_item_2", "game_item_3", "game_item_1", "game_item_5", "game_item_6"], order: [
        "game_item_2": 1, "game_item_3": 2, "game_item_1": 3, "game_item_5": 4, "game_item_6": 5
    ]),
    16: OrderItems(items: ["game_item_6", "game_item_7", "game_item_8", "game_item_9", "game_item_10", "game_item_11"], order: [
        "game_item_6": 1, "game_item_7": 2, "game_item_8": 3, "game_item_9": 4, "game_item_10": 5, "game_item_11": 6
    ]),
    17: OrderItems(items: ["game_item_1", "game_item_2", "game_item_7", "game_item_11", "game_item_12", "game_item_13", "game_item_14"], order: [
        "game_item_1": 1, "game_item_2": 2, "game_item_7": 3, "game_item_11": 4, "game_item_12": 5, "game_item_13": 6, "game_item_14": 7
    ]),
    18: OrderItems(items: ["game_item_1", "game_item_2", "game_item_3", "game_item_13", "game_item_7", "game_item_8", "game_item_15", "game_item_6"], order: [
        "game_item_1": 1, "game_item_2": 2, "game_item_3": 3, "game_item_13": 4, "game_item_7": 5, "game_item_8": 6, "game_item_15": 7, "game_item_6": 8
    ]),
    19: OrderItems(items: ["game_item_1", "game_item_2", "game_item_7", "game_item_11", "game_item_12", "game_item_13", "game_item_14"], order: [
        "game_item_1": 1, "game_item_2": 2, "game_item_7": 3, "game_item_11": 4, "game_item_12": 5, "game_item_13": 6, "game_item_14": 7
    ]),
    20: OrderItems(items: ["game_item_2", "game_item_3", "game_item_1", "game_item_5", "game_item_6"], order: [
        "game_item_2": 1, "game_item_3": 2, "game_item_1": 3, "game_item_5": 4, "game_item_6": 5
    ]),
    21: OrderItems(items: ["game_item_1", "game_item_2", "game_item_7", "game_item_11", "game_item_12", "game_item_13", "game_item_14"], order: [
        "game_item_1": 1, "game_item_2": 2, "game_item_7": 3, "game_item_11": 4, "game_item_12": 5, "game_item_13": 6, "game_item_14": 7
    ]),
    22: OrderItems(items: ["game_item_1", "game_item_2", "game_item_7", "game_item_11", "game_item_12", "game_item_13", "game_item_14"], order: [
            "game_item_1": 1, "game_item_2": 2, "game_item_7": 3, "game_item_11": 4, "game_item_12": 5, "game_item_13": 6, "game_item_14": 7
        ]),
    23: OrderItems(items: ["game_item_1", "game_item_2", "game_item_7", "game_item_11", "game_item_12", "game_item_13", "game_item_14"], order: [
            "game_item_1": 1, "game_item_2": 2, "game_item_7": 3, "game_item_11": 4, "game_item_12": 5, "game_item_13": 6, "game_item_14": 7
        ]),
    24: OrderItems(items: ["game_item_1", "game_item_2", "game_item_7", "game_item_11", "game_item_12", "game_item_13", "game_item_14"], order: [
            "game_item_1": 1, "game_item_2": 2, "game_item_7": 3, "game_item_11": 4, "game_item_12": 5, "game_item_13": 6, "game_item_14": 7
        ])
]
