//
//  LeagueVC.swift
//  Swoosh
//
//  Created by Lucas Inocencio on 01/09/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit

class LeagueVC: UIViewController {
    
    var player: Player!
    
    @IBOutlet weak var btNext: BorderButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = Player()
        
        btNext.isEnabled = false
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func selectedLeague(leagueType: String) {
        player.desiredLeague = leagueType
        btNext.isEnabled = true
    }
    
    @IBAction func onMensTouched(_ sender: Any) {
        selectedLeague(leagueType: "mens")
    }
    
    @IBAction func onWomensTouched(_ sender: Any) {
       selectedLeague(leagueType: "womens")
    }
    
    @IBAction func onCoedTouched(_ sender: Any) {
        selectedLeague(leagueType: "coed")
    }
    
    
    @IBAction func nextTouched(_ sender: Any) {
        performSegue(withIdentifier: "skillVCSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let skillVC = segue.destination as? SkillVC {
            skillVC.player = player
        }
    }
}
