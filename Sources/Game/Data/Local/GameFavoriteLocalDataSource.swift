//
//  File.swift
//  
//
//  Created by Ludin Nento on 02/01/21.
//

import Foundation
import FunGamesCore
import CoreData
import RxSwift

public struct GameFavoriteLocalDataSource: FavoriteLocalDataSource {
  public typealias Request = Any
  public typealias Response = FavoriteEntity
  
  private var _presententContainer: NSPersistentContainer
  
  public init(presententContainer: NSPersistentContainer) {
      _presententContainer = presententContainer
  }
  
  private func newTaskContext() -> NSManagedObjectContext {
      let taskContext = _presententContainer.newBackgroundContext()
      taskContext.undoManager = nil
      taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
      return taskContext
  }
  
  public func list(request: Any?) -> Observable<[FavoriteEntity]> {
    return Observable<[FavoriteEntity]>.create { observer in
      let taskContext = self.newTaskContext()
      taskContext.perform {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
        do {
            let results = try taskContext.fetch(fetchRequest)
            var favorites: [FavoriteEntity] = []
            for result in results {
                let favorite = FavoriteEntity(
                  id: result.value(forKeyPath: "id") as? Int64,
                  name: result.value(forKeyPath: "name") as? String,
                  released: result.value(forKeyPath: "released") as? String,
                  rating: result.value(forKeyPath: "rating") as? Double,
                  ratingCount: result.value(forKeyPath: "ratingCount") as? Int64,
                  image: result.value(forKeyPath: "image") as? String
                )
                favorites.append(favorite)
            }
          observer.onNext(favorites)
          observer.onCompleted()
        } catch let error as NSError {
          observer.onError(error)
        }
      }
      return Disposables.create()
    }
  }
  
  public func add(entity: FavoriteEntity) -> Observable<Bool> {
    return Observable<Bool>.create { observer in
      let taskContext = self.newTaskContext()
      taskContext.performAndWait {
        if let entityCore = NSEntityDescription.entity(forEntityName: "Favorite", in: taskContext) {
            let favoriteTask = NSManagedObject(entity: entityCore, insertInto: taskContext)
          favoriteTask.setValue(entity.id, forKeyPath: "id")
          favoriteTask.setValue(entity.name, forKeyPath: "name")
          favoriteTask.setValue(entity.released, forKeyPath: "released")
          favoriteTask.setValue(entity.rating, forKeyPath: "rating")
          favoriteTask.setValue(entity.ratingCount, forKeyPath: "ratingCount")
          favoriteTask.setValue(entity.image, forKeyPath: "image")
          do {
            try taskContext.save()
            observer.onNext(true)
            observer.onCompleted()
          } catch let error as NSError {
            observer.onError(error)
          }
        }
      }
      return Disposables.create()
    }
  }
  
  public func get(id: Int) -> Observable<FavoriteEntity> {
    return Observable<FavoriteEntity>.create { observer in
      let taskContext = self.newTaskContext()
      taskContext.perform {
          let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
          fetchRequest.fetchLimit = 1
          fetchRequest.predicate = NSPredicate(format: "id == \(id)")
          do {
              if let result = try taskContext.fetch(fetchRequest).first {
                  let favorite = FavoriteEntity(
                    id: result.value(forKeyPath: "id") as? Int64,
                    name: result.value(forKeyPath: "name") as? String,
                    released: result.value(forKeyPath: "released") as? String,
                    rating: result.value(forKeyPath: "rating") as? Double,
                    ratingCount: result.value(forKeyPath: "ratingCount") as? Int64,
                    image: result.value(forKeyPath: "image") as? String
                  )
                observer.onNext(favorite)
                observer.onCompleted()
              } else {
                observer.onNext(FavoriteEntity())
                observer.onCompleted()
              }
          } catch let error as NSError {
            observer.onError(error)
          }
      }
      return Disposables.create()
    }
  }
  
  public func delete(id: Int) -> Observable<Bool> {
    return Observable<Bool>.create { observer in
      let taskContext = self.newTaskContext()
      taskContext.perform {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeCount
        if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult,
          batchDeleteResult.result != nil {
          observer.onNext(true)
          observer.onCompleted()
        }
      }
      return Disposables.create()
    }
  }
  
}
