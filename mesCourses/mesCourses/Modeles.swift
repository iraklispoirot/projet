//
//  Modeles.swift
//  mesCourses
//
//  Created by etudiant on 18/10/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import Foundation

class Utilisateur
{
    var _ID: String
    var username: String
    private var password: String
    var dateDeCreation: String
    var derniereDateDacces: String
    var actif : Bool
    
    init?(
        username: String,
        password: String  = String(),
        dateDeCreation: String = DateFormatter().string(from: Date()),
        derniereDateDacces: String = DateFormatter().string(from: Date()) ,
        actif : Bool = false)
  {
    guard username != "", password != ""
        else { return nil }
    self._ID = UUID.init().uuidString
    self.username = username
    self.password = MD5(password)
    self.dateDeCreation = dateDeCreation
    self.derniereDateDacces = derniereDateDacces
    self.actif = actif
  }
    
    func verifierMotDePasse(motDePasse: String) -> Bool
    {
       
        return MD5(motDePasse) == self.password
    }
}
class Produit
{
    var _ID:         String
    var nom:         String
    var marque:      String
    var description: String
    var prix:        Float
    var poids:       Float
    var lienPhoto:   String
    var manquant:    Bool
    var favori:      Bool

    init?(nom:        String=String(),
         marque:      String=String(),
         description: String=String(),
         prix:        Float=Float(),
         poids:       Float=Float(),
         lienPhoto:   String=String(),
         manquant:    Bool=false,
         favori:      Bool=false)
    {
        guard nom != String() else
        { return nil }

        self._ID = UUID.init().uuidString
        self.nom = nom
        self.marque = marque
        self.description = description
        self.prix = prix
        self.poids = poids
        self.lienPhoto = lienPhoto
        self.manquant = manquant
        self.favori = favori
    }
}

class Magasin
{
    var _ID: String
    var nom: String
    var adresse: String
    var description: String
    var pos_latitude: Float
    var pos_longitude: Float
    var lienPhoto:   String
    
    init?(nom: String = String(),
         adresse: String = String(),
         description: String  = String(),
         pos_latitude: Float  = Float(),
         pos_longitude: Float,
         lienPhoto:   String=String())
    {
        guard nom != String() else
        { return nil }
       self._ID = UUID.init().uuidString
       self.nom = nom
       self.adresse = adresse
       self.description = description
       self.pos_latitude = pos_latitude
       self.pos_longitude = pos_longitude
       self.lienPhoto = lienPhoto
    }
}

class LienProduitMagasin
{
    var _ID: String
    var produit: Produit?
    var magasin: Magasin?
    var favori:  Bool
    
    init?( produit: Produit? = nil,
           magasin: Magasin? = nil,
           favori:  Bool=false)
    {
        guard produit != nil, magasin != nil
            else { return nil }
        self._ID = UUID.init().uuidString
        self.produit = produit
        self.magasin = magasin
        self.favori  = favori
    }
}

class Course
{
    var _ID: String
    var nom: String
    var tabLienProduitMagasin: [LienProduitMagasin]
    init?(
          nom: String = "",
          tabLienProduitMagasin: [LienProduitMagasin]  = []
     )
    {
        guard nom != String() else
        { return nil }
        self._ID = UUID.init().uuidString
        self.nom = nom
        self.tabLienProduitMagasin =  tabLienProduitMagasin
    }
    
    func getLienProduitMagasin(byLienId: String) -> LienProduitMagasin?
    {
        for lien in tabLienProduitMagasin {
            if lien._ID == byLienId {
                return lien
            }
        }
        return nil
    }
    
    func getLiensProduitMagasin(byMagasinId: String) ->  [LienProduitMagasin]
    {
        var tabLiens:[LienProduitMagasin] = []
        for lien in tabLienProduitMagasin {
            if lien.magasin?._ID == byMagasinId
            {
                tabLiens.append(lien)
            }
        }
        return tabLiens
    }
    
    func getLiensProduitMagasin(byProduitId: String) ->  [LienProduitMagasin]
    {
        var tabLiens:[LienProduitMagasin] = []
        for lien in tabLienProduitMagasin {
            if lien.produit?._ID == byProduitId
            {
                tabLiens.append(lien)
            }
        }
        return tabLiens
    
    }
    
}


