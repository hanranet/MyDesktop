package com.hanranet.mydesktop

import com.hanranet.mydesktop.receipts.Receipt
import com.hanranet.mydesktop.statements.Statement
import com.hanranet.mydesktop.vacation.Event
import com.hanranet.mydesktop.vacation.PTO
import grails.transaction.Transactional

@Transactional
class PTOService {

//    def getHoursLeft(PTO pto) {
//
//        def total = pto.getDays()
//
//        def used = sumDays(pto)
//
//        def left = total - used
//
//        left.toString()
//
//    }


    def getHoursUsed(PTO pto) {

        def usedTotal = 0

        def eventList = Event.findAll("from Event as e where e.owner=? and e.type=?", ['thanrahan', pto.getType()])

        eventList.each {
            usedTotal = usedTotal + it.getDays()
        }
        usedTotal
    }
}
