package com.hanranet.mydesktop.budget

import com.hanranet.mydesktop.receipts.Receipt
import grails.transaction.Transactional
import org.codehaus.groovy.transform.trait.Traits
import org.springframework.dao.DataIntegrityViolationException

import static org.springframework.http.HttpStatus.NOT_FOUND
import static org.springframework.http.HttpStatus.OK

class ItemController {

    def index() {

        def weeklyTotal = 0
        def monthlyTotal = 0
        def bucketTotal = 0

        def itemList = Item.findAllByOwner("thanrahan")

        itemList.each { item->

            if (item.monthlyBucketAmount > 0)
            {
                item.weeklyBucketAmount = item.monthlyBucketAmount / 2
                monthlyTotal = monthlyTotal + item.monthlyBucketAmount
            }

            if (item.weeklyBucketAmount > 0)
            {
                weeklyTotal = weeklyTotal + item.weeklyBucketAmount
            }

            if (item.bucketAmount > 0)
            {
                bucketTotal = bucketTotal + item.bucketAmount
            }

        }

        //def receiptBalance = receiptsService.getReceiptBalance()
        def receiptBalance = 0

        def difference = receiptBalance - bucketTotal

        [ itemList: itemList,
          weeklyTotal: weeklyTotal,
          monthlyTotal: monthlyTotal,
          bucketTotal: bucketTotal,
          receiptBalance: receiptBalance,
          difference: difference]

    }

    def create() {
        [itemInstance: new Item(params)]
    }

    def show(Item item) {
        redirect action:"index"
    }

    @Transactional
    def save(Item item) {

        if (item == null)
        {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (item.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond item.errors, view:'create', model: [item: item]
            return
        }

        if (item.getBucketAmount() == null || item.getBucketAmount().equals("") ) {
            item.setBucketAmount(new BigDecimal(0.00))
        }

        if (!item.save(flush: true)) {
            render(view: "create", model: [item: item])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'item.label', default: 'Item'), item.id])
        redirect item
    }

    def edit() {
        def itemInstance = Item.get(params.id)
        if (!itemInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'item.label', default: 'Item'), params.id])
            redirect(action: "index")
            return
        }

        [item: itemInstance]
    }

    @Transactional
    def update(Item item) {
        if (item == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (item.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond item.errors, view:'edit'
            return
        }

        item.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'item.label', default: 'Item'), item.id])
                redirect item
            }
            '*'{ respond item, [status: OK] }
        }
    }

    @Transactional
    def delete(Item item) {

        if (item == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        item.delete flush:true

        flash.message = message(code: 'default.deleted.message', args: [message(code: 'item.label', default: 'Item'), item.id])
        redirect action:"index"

    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'item.label', default: 'Item'), item.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

//    def update(Item item) {
//        def itemInstance = Item.get(params.id)
//        if (!itemInstance) {
//            flash.message = message(code: 'default.not.found.message', args: [message(code: 'item.label', default: 'Item'), params.id])
//            redirect(action: "index")
//            return
//        }
//
//        if (params.version) {
//            def version = params.version.toLong()
//            if (itemInstance.version > version) {
//                itemInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
//                        [message(code: 'item.label', default: 'Item')] as Object[],
//                        "Another user has updated this Item while you were editing")
//                render(view: "edit", model: [itemInstance: itemInstance])
//                return
//            }
//        }
//
//        bindData(itemInstance, params, [exclude: 'date'])
//
//        itemInstance.date = params.date('date', ['MM/dd/yyyy'])
//        itemInstance.owner = 'thanrahan'
//        itemInstance.updateUser = 'thanrahan'
//        itemInstance.lastUpdate = new Date()
//
//        if (!itemInstance.save(flush: true)) {
//            render(view: "edit", model: [itemInstance: itemInstance])
//            return
//        }
//
//        flash.message = message(code: 'default.updated.message', args: [message(code: 'item.label', default: 'Item'), itemInstance.id])
//        redirect(action: "index")
//    }
//
//    def delete() {
//        def itemInstance = Item.get(params.id)
//        if (!itemInstance) {
//            flash.message = message(code: 'default.not.found.message', args: [message(code: 'item.label', default: 'Item'), params.id])
//            redirect(action: "index")
//            return
//        }
//
//        try {
//            itemInstance.delete(flush: true)
//            flash.message = message(code: 'default.deleted.message', args: [message(code: 'item.label', default: 'Item'), params.id])
//            redirect(action: "index")
//        }
//        catch (DataIntegrityViolationException e) {
//            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'item.label', default: 'Item'), params.id])
//            redirect(action: "index")
//        }
//    }

    @Transactional
    def payNow() {

        def itemInstance = Item.get(params.id)

        if (!itemInstance || itemInstance.billPayee == null || itemInstance.billPayee.equals("")) {
            flash.message = "Bill Details not found for Budget Item"
            redirect(action: "index")
            return

        }

        def receiptInstance = new Receipt()

        receiptInstance.owner = 'thanrahan'
        receiptInstance.date = new Date()
        receiptInstance.payee = itemInstance.billPayee
        receiptInstance.category = itemInstance.name
        receiptInstance.credit = itemInstance.billAmount
        receiptInstance.createUser = 'thanrahan'
        receiptInstance.dateCreated = new Date()
        receiptInstance.updateUser = 'thanrahan'
        receiptInstance.lastUpdated = new Date()

        receiptInstance.save()

        itemInstance.bucketAmount = itemInstance.bucketAmount - itemInstance.billAmount

        itemInstance.billDate = null
        itemInstance.billPayee = ''
        itemInstance.billAmount = null

        itemInstance.save(flush: true)

        flash.message = 'New receipt has been created.'
        redirect(action: "index")

    }

    def payDay() {

        def itemList = Item.findAllByOwner("thanrahan")

        itemList.each { item->

            def bucketAmount = item.bucketAmount
            def weeklyAmount = (item.monthlyBucketAmount / 2)

            if (bucketAmount == null)
            {
                bucketAmount = 0.00
            }

            if (weeklyAmount == null)
            {
                weeklyAmount = 0.00
            }

            item.bucketAmount = bucketAmount + weeklyAmount

            if (!item.save(flush: true)) {
                render(view: "edit", model: [itemInstance: item])
                return
            }

        }

        redirect(action:"index")
    }
}
