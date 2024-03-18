//
//  DatabaseManager.swift
//  FoodDay-Beta
//
//  Created by Николай Мавлютов on 17.02.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class DatabaseManager {
    static let shared = DatabaseManager()
    let fireCollectionName = "users"
    let nameOfField = "favourite"
    
    private func configure() -> Firestore {
        var db: Firestore!
        let setting = FirestoreSettings()
        Firestore.firestore().settings = setting
        db = Firestore.firestore()
        return db
    }
    
//    func getPost(collection: String, docName: String, completion: @escaping (FavouriteModel?) -> Void) {
//        let db = configure()
//        
//        db.collection(collection).document(docName).getDocument { (document, error) in
//            guard error == nil else { completion(nil); return }
//            let doc = FavouriteModel(favouriteRecipes: document?.get("favourite") as! [String])
//            completion(doc)
//        }
//    }
    
    func getPost(completion: @escaping (FavouriteModel?) -> Void) {
        let db = configure()
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let docRef = db.collection(fireCollectionName).document(uid)
        
        docRef.getDocument { (document, error) in
            guard error == nil else { print("error get"); return }
            if document?.exists == nil {
                db.collection(self.fireCollectionName).document(uid).setData([self.nameOfField : ""])
            } else {
                let doc = FavouriteModel(favouriteRecipes: document?.get(self.nameOfField) as! [String])
                completion(doc)
            }
        }
    }
    
    func realtimeDatabase(completion: @escaping (FavouriteModel?) -> Void) {
        let db = configure()
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
         db.collection(fireCollectionName).document(uid).addSnapshotListener { (documentSnapshot, error) in
             guard let document = documentSnapshot else { return }
//             guard let data = document.data() else { return }
             let doc = FavouriteModel(favouriteRecipes: document.get(self.nameOfField) as! [String])
             completion(doc)
        }
    }
    
    
    
    func addRecipe(addRecipe: String) {
        let db = configure()
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let docRef = db.collection(fireCollectionName).document(uid)
        
        docRef.getDocument { (document, error) in
            guard error == nil else { return }
            
            if document?.exists == nil {
                db.collection(self.fireCollectionName).document(uid).setData([self.nameOfField : [addRecipe]])
            } else {
                var doc = FavouriteModel(favouriteRecipes: document?.get(self.nameOfField) as! [String])
                doc.favouriteRecipes.append(addRecipe)
                docRef.updateData([
                    self.nameOfField: doc.favouriteRecipes
                ])
            }
        }
    }
    
    func removeRecipe(removePos: Int) {
        let db = configure()
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let docRef = db.collection(fireCollectionName).document(uid)
        docRef.getDocument { (document, error) in
            guard error == nil else { print("get error"); return }
            
            var doc = FavouriteModel(favouriteRecipes: document?.get(self.nameOfField) as! [String])
            doc.favouriteRecipes.remove(at: removePos)
            document?.reference.updateData([
                self.nameOfField: doc.favouriteRecipes])
        }
    }
}
