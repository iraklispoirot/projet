//
//  DaoObjets.swift
//  mesCourses
//
//  Created by etudiant on 21/10/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import Foundation
class UtilisateurDao

{
    private static var utilisateurs: [Utilisateur] = [
        Utilisateur(username: "nounou", password: "nounou",  actif: true)!,
        Utilisateur(username: "nico", password: "nico",  actif: true)!,
        Utilisateur(username: "savina", password: "savina",  actif: true)!
        
    ]

    static func getAllUsers() -> [Utilisateur]
    {
        return UtilisateurDao.utilisateurs
    }
    
    static func getUserByUsername(username: String, caseInsensitiveStr: Bool=false) -> Utilisateur?
    {
        if caseInsensitiveStr == true
        {
            for utilisateur in UtilisateurDao.utilisateurs
               {
                print("getUserByUsername:"+"table:" + utilisateur.username + "paramètre:" +  username)
                if utilisateur.username.caseInsensitiveCompare(username) == ComparisonResult.orderedSame {
                    print("user found:" + username)
                    return utilisateur
                 }
               }
 
        }
        else
          {
            for utilisateur in UtilisateurDao.utilisateurs {
              if utilisateur.username == username {
                        return utilisateur
               }
             }
          }
      return nil
    }
    
    static func addUser(username: String, password: String) -> Utilisateur?
    {
      guard getUserByUsername(username: username, caseInsensitiveStr: true) != nil
        else
        {
         let utilisateur = Utilisateur(username: username, password: password,  actif: true)!
         UtilisateurDao.utilisateurs.append(utilisateur)
         print("addUser:" + "username" + username + "password:" + password)
         return utilisateur
       }
       return nil
    }
    
    static func deleteUserById(id: String) -> Utilisateur?
    {
        var cpt: Int = 0
        while cpt < UtilisateurDao.utilisateurs.count {
          if UtilisateurDao.utilisateurs[cpt]._ID == id
           {
             return UtilisateurDao.utilisateurs.remove(at: cpt)
           }
          cpt+=1
        }
        return nil
    }
 
}

class ProduitDao
    
{
    
    private static var listeProduits: [Produit] = [
    Produit(nom: "Produit 1", marque: "Sarah Bernard", description: "Montre en or", prix: 5000.00, poids: 0.0, lienPhoto: "", manquant: false, favori: false)!,
    Produit(nom: "Produit 2", marque: "Hô JErOmE", description: "Viande de porc", prix: 50.00, poids: 0.0, lienPhoto: "", manquant: false, favori: false)!,
    Produit(nom: "Produit 3", marque: "Le bon Vieux Truc", description: "Choux", prix: 5.00, poids: 0.0, lienPhoto: "", manquant: false, favori: false)!,
    Produit(nom: "Produit 4", marque: "Buckingham", description: "Serviettes", prix: 10.00, poids: 0.0, lienPhoto: "", manquant: false, favori: false)!,
    Produit(nom: "Produit 5", marque: "Allez les gars!", description: "Lait de soja", prix: 2.00, poids: 0.0, lienPhoto: "", manquant: false, favori: false)!
   ]
   static func getListeProduits() -> [Produit]
   {
    return ProduitDao.listeProduits
   }

    static func getProduitById(idProduit: String) -> Produit?
    {
     for produit in listeProduits {
        if produit._ID == idProduit
         {
          return produit
         }
      }
      return nil
    }
    
    static func addProduit(produit: Produit)
    {
      ProduitDao.listeProduits.append(produit)
    }
    
    static func deleteProduitById(id: String) -> Produit?
    {
        var cpt: Int = 0
        while cpt < ProduitDao.listeProduits.count {
            if ProduitDao.listeProduits[cpt]._ID == id
            {
                return ProduitDao.listeProduits.remove(at: cpt)
            }
            cpt+=1
        }
        return nil
    }
    
}

class MagasinDao
{
    static var listeMagasins: [Magasin] = [
        Magasin(nom: "First shop", adresse: "Rue longue, 10, 1620 Drogenbos", description: "Magasin de chaussures", pos_latitude: 0.0, pos_longitude: 0.0, lienPhoto: "")!,
        Magasin(nom: "Second shop", adresse: "Rue longue, 12, 1620 Drogenbos", description: "Magasin d'informatique", pos_latitude: 0.0, pos_longitude: 0.0, lienPhoto: "")!,
        Magasin(nom: "Third shop", adresse: "Rue longue, 14, 1620 Drogenbos", description: "Magasin d'alimentation", pos_latitude: 0.0, pos_longitude: 0.0, lienPhoto: "")!,
        Magasin(nom: "Fourth shop", adresse: "Rue longue, 16, 1620 Drogenbos", description: "Magasin de vêtements", pos_latitude: 0.0, pos_longitude: 0.0, lienPhoto: "")!
    ]
    static func getListeMagasins() -> [Magasin]
    {
         return MagasinDao.listeMagasins
    }

    static func getMagasinById(idMagasin: String) -> Magasin?
    {
        for magasin in listeMagasins {
            if magasin._ID == idMagasin
            {
                return magasin
            }
        }
        return nil
    }
    
    static func addMagasin(magasin: Magasin)
    {
        MagasinDao.listeMagasins.append(magasin)
    }
    
    static func deleteMagasinById(id: String) -> Magasin?
    {
        var cpt: Int = 0
        while cpt < MagasinDao.listeMagasins.count {
            if MagasinDao.listeMagasins[cpt]._ID == id
            {
                return MagasinDao.listeMagasins.remove(at: cpt)
            }
            cpt+=1
        }
        return nil
    }
}

class LienProduitMagasinDao
{
    private static var listeLiensProduitMagasin: [LienProduitMagasin] = []
    
    static func getListeLiensProduitMagasin() -> [LienProduitMagasin]
    {
        return LienProduitMagasinDao.listeLiensProduitMagasin
    }
    
    static func getLienProduitMagasin(byId: String) -> LienProduitMagasin?
    {
        for lien in LienProduitMagasinDao.listeLiensProduitMagasin {
            if lien._ID == byId
            {
                return lien
            }
         }
        return nil
    }
    
    static func getLiensProduitMagasin(byMagasinId: String) -> [LienProduitMagasin]
    {
        var liens: [LienProduitMagasin] = []
        for lien in LienProduitMagasinDao.listeLiensProduitMagasin {
            if lien.magasin?._ID == byMagasinId
            {
                liens.append(lien)
            }
        }
        return liens
    }
   
   
    static func getLiensProduitMagasin(byProduitId: String) -> [LienProduitMagasin]
    {
        var liens: [LienProduitMagasin] = []
        for lien in LienProduitMagasinDao.listeLiensProduitMagasin {
            if lien.produit?._ID == byProduitId
            {
                liens.append(lien)
            }
        }
        return liens
    }
    
    
    static func addLienProduitMagasin(lienProduitMagasin: LienProduitMagasin)
    {
        LienProduitMagasinDao.listeLiensProduitMagasin.append(lienProduitMagasin)
    }
    
    static func deleteLienProduitMagasin(byId: String) -> LienProduitMagasin?
    {
        var cpt: Int = 0
        while cpt < LienProduitMagasinDao.listeLiensProduitMagasin.count {
            if LienProduitMagasinDao.listeLiensProduitMagasin[cpt]._ID == byId
            {
                return LienProduitMagasinDao.listeLiensProduitMagasin.remove(at: cpt)
            }
            cpt+=1
        }
        return nil

    }
}

class CourseDao
{
    private static var listeCourses: [Course] = []
    
    static func getListeCourses() -> [Course]
    {
        return CourseDao.listeCourses
    }
    static func getCourse(byId: String) -> Course?
    {
        for lien in CourseDao.listeCourses {
            if lien._ID == byId
            {
                return lien
            }
        }
        return nil
    }
    
    static func getLiensForCourse(byCourseId:String, byMagasinId: String) -> [LienProduitMagasin]
    {
       var liens: [LienProduitMagasin] = []
       
       if let course = getCourse(byId: byCourseId)
       {
        liens = course.getLiensProduitMagasin(byMagasinId: byMagasinId)
       }
       
      return liens
    }
    
    static func getLiensForCourse(byCourseId:String, byProduitId: String) -> [LienProduitMagasin]
    {
        var liens: [LienProduitMagasin] = []
        
        if let course = getCourse(byId: byCourseId)
        {
            liens = course.getLiensProduitMagasin(byProduitId: byCourseId)
        }
        
        return liens
    }

   
    
    static func addCourse(course: Course)
    {
        CourseDao.listeCourses.append(course)
    }
    
    static func deleteCourse(byId: String) -> Course?
    {
        var cpt: Int = 0
        while cpt < CourseDao.listeCourses.count {
            if CourseDao.listeCourses[cpt]._ID == byId
            {
                return CourseDao.listeCourses.remove(at: cpt)
            }
            cpt+=1
        }
        return nil
    }
}
