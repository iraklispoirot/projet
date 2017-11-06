//
//  LoginScreenViewController.swift
//  
//
//  Created by etudiant on 21/10/2017.
//
//

import UIKit

class LoginScreenViewController: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnLgout: UIButton!
    
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBAction func actionLogout(_ sender: UIButton) {
        btnLogin.isEnabled  = true
        btnSignup.isEnabled = true
        btnLgout.isEnabled  = false
        Session.currentUser = nil
        tfUsername.text = ""
        tfPassword.text = ""
        
    }
    @IBAction func actionLogin(_ sender: UIButton) {
        guard isValidUsername(Input: tfUsername.text!) else {
            let al = alert(titre: "Erreur", message: "Nom d'utilisateur/Email incorrect: >= 6 caractères alphanumériques et _ et @ et . !", boutonTitre: "Ok")
            self.present(al, animated: true, completion: nil)
            return
        }
        let username = tfUsername.text!
        guard isValidPassword(Input: tfPassword.text!) else {
            let al = alert(titre: "Erreur", message: "Mot de passe doit contenir au mois 6 caractères", boutonTitre: "Ok")
            self.present(al, animated: true, completion: nil)
            return
        }
        let password = tfPassword.text!
        if let currentUser = login(username: username, password: password)
        {
            print("login with:" + username + ":" + password )
            btnLogin.isEnabled  = false
            btnSignup.isEnabled = false
            btnLgout.isEnabled  = true
            Session.currentUser = currentUser
            self.performSegue(withIdentifier: "mainScreenSegue", sender: self)
        }
        else
        {
            let al = alert(titre: "Erreur", message: "Nom d'utilisateur ou Mot de passe incorrects", boutonTitre: "Ok")
            self.present(al, animated: true, completion: nil)
        }
    
    }
    
    @IBAction func actionSignup(_ sender: UIButton) {
        
        guard isValidUsername(Input: tfUsername.text!) else {
            let al = alert(titre: "Erreur", message: "Nom d'utilisateur/Email incorrect: >= 6 caractères alphanumériques et _ et @ et . !", boutonTitre: "Ok")
            self.present(al, animated: true, completion: nil)
            return
        }
        let username = tfUsername.text!
        guard isValidPassword(Input: tfPassword.text!) else {
            let al = alert(titre: "Erreur", message: "Mot de passe doit contenir au mois 6 caractères", boutonTitre: "Ok")
            self.present(al, animated: true, completion: nil)
            return
        }
        let password = tfPassword.text!
        if let currentUser = register(username: username, password: password)
        {
            btnLogin.isEnabled  = false
            btnSignup.isEnabled = false
            btnLgout.isEnabled  = true
            Session.currentUser = currentUser
            self.performSegue(withIdentifier: "mainScreenSegue", sender: self)
        }
        else
        {
            let al = alert(titre: "Erreur", message: "Nom d'utilisateur/Email incorrect: >= 6 caractères alphanumériques et _ et @ et . ou Mot de passe (> 6 caractères) incorrects ou Nom d'utilisateur déjà existant", boutonTitre: "Ok")
            self.present(al, animated: true, completion: nil)
        }

    }
    
    func initializeView()
    {
      btnLgout.isEnabled  = false
      tfPassword.text = ""
      tfUsername.text = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
