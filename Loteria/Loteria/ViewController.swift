//
//  ViewController.swift
//  Loteria
//
//  Created by Gilmar Junior on 16/08/21.
//

import UIKit

enum GameType: String {
    case megasena = "Mega-sena"
    case quina = "Quina"
}

func gameRandom(total: Int, universe: Int) -> [Int]{
    var result: [Int] = []
    while result.count < total {
        let randomNumber = Int(arc4random_uniform(UInt32(universe))+1)
        if !result.contains(randomNumber) {
            result.append(randomNumber)
        }
    }
    
    return result.sorted()
}

class ViewController: UIViewController {

    @IBOutlet weak var gameTypeLabel: UILabel!
    @IBOutlet weak var gameTypeSC: UISegmentedControl!
    @IBOutlet var balls: [UIButton]!
    @IBOutlet weak var generateButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateButton.layer.cornerRadius = 5.0
        
        showNumbers(for: .megasena)
    }
    
    func showNumbers(for type: GameType) {
        gameTypeLabel.text = type.rawValue
        
        var game: [Int] = []
        
        switch type {
        case .megasena:
            game = gameRandom(total: 6, universe: 60)
            balls.last!.isHidden = false
        case .quina:
            game = gameRandom(total: 5, universe: 80)
            balls.last!.isHidden = true
        }
        
        for (index, game) in game.enumerated() {
            balls[index].setTitle("\(game)", for: .normal)
        }
    }
    

    @IBAction func generateGame() {
        switch gameTypeSC.selectedSegmentIndex {
        case 0:
            showNumbers(for: .megasena)
        default:
            showNumbers(for: .quina)
        }
    }
    
}

