//
//  TransactionService.swift
//  CashFlow_Storyboard
//
//  Created by Otabek Tuychiev
//

import Foundation
import CoreData

class TransactionService {
    
    static let shared = TransactionService()
    private init() {}
    
    //    MARK: - CRUD operations
    
    func saveTransaction(type: String, amount: String, date: String, notes: String) {
        let context = CoreDataManager.shared.context
        let transaction = Transaction(context: context)
        transaction.type = type
        transaction.amount = amount
        transaction.date = date
        transaction.notes = notes
        transaction.uuid = UUID().uuidString
        CoreDataManager.shared.saveContext()
    }
    
    func fetchTransactions() -> [Transaction] {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest).reversed()
        } catch {
            print("Fetch failed: \(error)")
            return []
        }
    }
    
    func fetchIncomeTransactions() -> [Transaction] {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "type == %@ OR type == %@ OR type == %@", "Income ▼", "Kirim ▼", "수입 ▼")
        
        do {
            return try context.fetch(fetchRequest).reversed()
        } catch {
            print("Fetch failed: \(error)")
            return []
        }
    }
    
    func fetchExpenseTransactions() -> [Transaction] {
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "type == %@ OR type == %@ OR type == %@", "Expense ▼", "Chiqim ▼", "경비 ▼")
        
        do {
            return try context.fetch(fetchRequest).reversed()
        } catch {
            print("Fetch failed: \(error)")
            return []
        }
    }
    
    func deleteTransaction(transaction: Transaction) {
        let context = CoreDataManager.shared.context
        context.delete(transaction)
        CoreDataManager.shared.saveContext()
    }
    
    func updateTransaction(transaction: Transaction, type: String, amount: String, date: String, notes: String) {
        transaction.type = type
        transaction.amount = amount
        transaction.date = date
        transaction.notes = notes
        CoreDataManager.shared.saveContext()
    }
}
