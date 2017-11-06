//
//  Authentification.swift
//  mesCourses
//
//  Created by etudiant on 21/10/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import Foundation

// accepte des adresses emails, des noms de domaine, des usernames sans caractères spéciaux ...
// taille username minimale 6 caractères
// https://stackoverflow.com/questions/44153773/username-regex-swift
func isValidUsername(Input:String) -> Bool {
    //let RegEx = "\\A\\w{6,18}\\z"
    let RegEx = "^(?=\\w{6,18})[a-zA-Z]\\w*(?:\\.\\w+)*(?:@\\w+\\.\\w{2,4})?$"
    let reply = NSPredicate(format:"SELF MATCHES %@", RegEx)
    
    return reply.evaluate(with: Input)
}

func isValidPassword(Input: String) -> Bool
 {
    return Input.characters.count >= 6
 }


func login(username: String, password: String) -> Utilisateur?
 {
  print("login!")
    if let utilisateur = UtilisateurDao.getUserByUsername(username: username, caseInsensitiveStr: true)
  {
    print("login:" + utilisateur.username + "motdepasse reçu:" + password)
    return utilisateur.verifierMotDePasse(motDePasse: password) ? utilisateur: nil
  }
  return nil
}

func register(username: String, password: String) -> Utilisateur!
{
   if isValidUsername(Input: username) && isValidPassword(Input: password)
   {
    return UtilisateurDao.addUser(username: username, password: password)
   }
   return nil
    
}

func logout()
{
    
}
