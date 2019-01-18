package com.hanranet.mydesktop.statements

import com.hanranet.mydesktop.budget.Item
import com.hanranet.mydesktop.receipts.Receipt
import org.springframework.web.context.request.RequestContextHolder

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class StatementController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Statement.list(params), model:[statementInstanceTotal: Statement.count()]
    }

    def show(Statement statement) {

        def statementInstance = Statement.get(params.id)
        if (!statementInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'statement.label', default: 'Statement'), params.id])
            redirect(action: "list")
            return
        }

        def receiptList = Receipt.findAllByOwnerAndReconcileNo("thanrahan", statementInstance.id)

        def debitReceipts = new ArrayList()
        def creditReceipts = new ArrayList()

        receiptList.each { receipt->

            if (receipt.debit > 0)
            {
                debitReceipts.add(receipt)
            }
            else
            {
                creditReceipts.add(receipt)
            }
        }

        [statementInstance: statementInstance, debitReceipts: debitReceipts, creditReceipts: creditReceipts]
    }

    def create() {

        def statement = new Statement()

        def lastStatement = Statement.find("FROM Statement ORDER BY dateCreated")

        if (lastStatement) {
            statement.beginDate = lastStatement.endingDate + 1
            statement.beginBalance = lastStatement.endingBalance
            statement.endingDate = lastStatement.endingDate + 30
        }

        def receiptList = Receipt.findAllByOwnerAndReconcileNoIsNull("thanrahan")

        def debitReceipts = new ArrayList()
        def creditReceipts = new ArrayList()

        receiptList.each { receipt->

            if (receipt.debit > 0)
            {
                debitReceipts.add(receipt)
            }

            if (receipt.credit > 0)
            {
                creditReceipts.add(receipt)
            }
        }

        [statementInstance: statement, debitReceipts: debitReceipts, creditReceipts: creditReceipts]
    }

    @Transactional
    def save(Statement statement) {

        statement.owner = 'thanrahan'

        if (statement == null)
        {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (statement.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond statement.errors, view:'create'
            return
        }

        statement.save flush:true

        println params

        def creditList = params.creditReceipts

        creditList.each{receiptId->

            def receipt = Receipt.get(receiptId)

            receipt.reconcileNo = statement.id
            receipt.updateUser = "SYSTEM_RECONCILE"
            receipt.lastUpdated = new Date()

            if (!receipt.save(flush: true)) {
                println("Unable to update credit receipt during reconciliation - id=" + receipt.id + " statementid=" + statementInstance.id)
            }

        }

        def debitList = params.debitReceipts

        debitList.each{receiptId->

            def receipt = Receipt.get(receiptId)

            receipt.reconcileNo = statement.id
            receipt.updateUser = "SYSTEM_RECONCILE"
            receipt.lastUpdated = new Date()

            if (!receipt.save(flush: true)) {
                println("Unable to update debit receipt during reconciliation - id=" + receipt.id + " statementid=" + statementInstance.id)
            }

        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'statement.label', default: 'Statement'), statement.id])
                redirect statement
            }
            '*' { respond statement, [status: CREATED] }
        }

    }

    def edit(Statement statement) {

        respond statement
    }

    @Transactional
    def update(Statement statement) {
        if (statement == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (statement.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond statement.errors, view:'edit'
            return
        }

        statement.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'statement.label', default: 'Statement'), statement.id])
                redirect statement
            }
            '*'{ respond statement, [status: OK] }
        }
    }

    @Transactional
    def delete(Statement statement) {

        if (statement == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        statement.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'statement.label', default: 'Statement'), statement.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }


    def autoReconcile() {

        def cleanCsvReceiptList = new ArrayList()
        def cleanMydReceiptList = new ArrayList()

        def csvReceiptList = session.csvReceiptList

        def inSession = false

        if (params.file != null) {
            csvReceiptList = getReceiptListFromCSV(request.getFile('file'))
            session.csvReceiptList = csvReceiptList
            cleanCsvReceiptList = getCleanCSVList(csvReceiptList)
            cleanMydReceiptList = getCleanMYDList(csvReceiptList)
            inSession = true
        } else if (csvReceiptList != null) {
            cleanCsvReceiptList = getCleanCSVList(csvReceiptList)
            cleanMydReceiptList = getCleanMYDList(csvReceiptList)
            inSession = true
        }

        def categoryList = Item.list()
        categoryList.add(new Item(name: "Salary"))

        [csvReceiptList: cleanCsvReceiptList, mydReceiptList: cleanMydReceiptList, inSession: inSession, categoryList: categoryList]
    }

    private ArrayList<Receipt> getCleanCSVList(csvReceiptList)
    {
        def ArrayList<Receipt> cleanCsvList = new ArrayList<Receipt>()

        // Pull all myd receipts
        def mydReceiptList = Receipt.findAll("from Receipt where owner = 'thanrahan' and reconcileNo is null order by debit desc, credit desc")

        // Loop through csv list removing items that are already in myd
        for (Iterator<Receipt> csvIter = csvReceiptList.iterator(); csvIter.hasNext(); )
        {
            def csvReceipt = csvIter.next()

            def match = false

            // Loop through myd receipts looking for a match
            for (Iterator<Receipt> mydIter = mydReceiptList.iterator(); mydIter.hasNext(); )
            {
                def mydReceipt = mydIter.next()

                if ( csvReceipt.debit == mydReceipt.debit && csvReceipt.credit == mydReceipt.credit )
                {
                    mydIter.remove()
                    match = true
                    break
                }
            }

            // If receipt not found in myd receipts, add it to the clean list
            if (!match) {
                cleanCsvList.add(csvReceipt)
            }
        }

        return cleanCsvList
    }

    private getCleanMYDList(csvReceiptList)
    {

        def mydReceiptList = Receipt.findAll("from Receipt where owner = 'thanrahan' and reconcileNo is null order by debit, credit desc")

        for (Iterator<Receipt> csvIter = csvReceiptList.iterator(); csvIter.hasNext(); )
        {
            def csvReceipt = csvIter.next()

            for (Iterator<Receipt> mydIter = mydReceiptList.iterator(); mydIter.hasNext(); )
            {
                def mydReceipt = mydIter.next()

                if ( csvReceipt.debit == mydReceipt.debit && csvReceipt.credit == mydReceipt.credit )
                {
                    mydIter.remove()
                    break
                }
            }
        }

        return mydReceiptList
    }

    private getReceiptListFromCSV(uploadedFile)
    {
        //todo sort file by debit, credit
        def uploadedReceipts = new ArrayList()

        if(!uploadedFile.empty)
        {
            def is = uploadedFile.getInputStream()

            byte[] fileData     = is.getBytes()
            String data         = new String(fileData)

            // Convert CSV to receipt array
            String delim        = "\n"
            StringTokenizer st = new StringTokenizer(data, delim, false)

            ArrayList csvReceipts = new ArrayList()

            def header = true

            while (st.hasMoreTokens())
            {
                if (!header)
                {
                    String flatReceipt = st.nextToken()
                    def receipt = flattenReceipt(flatReceipt)
                    uploadedReceipts.add(receipt)
                }
                else
                {
                    st.nextToken()
                    header = false
                }
            }
        }

        return uploadedReceipts

    }

    private Receipt flattenReceipt(flatReceipt)
    {
        def receipt = new Receipt()

        // Format equals : Date, CheckNo, Name, Memo, Amount
        String delim = ",";
        StringTokenizer st = new StringTokenizer(flatReceipt, delim, false);

        def date = st.nextToken()
        def checkNo = st.nextToken()
        def name = st.nextToken()
        def memo = st.nextToken()
        def amount = st.nextToken()

        receipt.date = new Date(date)

        try
        {
            def numericCheckNo = Integer.parseInt(checkNo)
            receipt.checkNo = numericCheckNo
        }
        catch (Exception ex)
        {
        }

        receipt.payee = removeSpecialCharacters(memo)

        amount = amount.replaceAll("\r", "");
        receipt.reconcileAmount = new BigDecimal(amount)

        if (receipt.reconcileAmount < 0)
        {
            receipt.credit = new BigDecimal(amount) * -1
            receipt.debit = new BigDecimal(0)
        }
        else
        {
            receipt.debit = new BigDecimal(amount)
            receipt.credit= new BigDecimal(0)
        }

        return receipt
    }

    private String removeSpecialCharacters(payee)
    {
        payee = payee.replaceAll("Download from usbank.com. ", "")
        payee = payee.replaceAll('"', "")

        return payee
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'statement.label', default: 'Statement'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
