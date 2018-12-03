import { Injectable } from '@angular/core';

@Injectable()
export class BaseService {

    //----------------METHODS-------------------

       /**
     * @method return the range in days between two dates
     * @param date1 first date
     * @param date2 second date
     */
    dateDiffInDays(date1, date2) {
        //Get 1 day in milliseconds
        let oneDay: number = 1000 * 60 * 60 * 24;

        // Convert both dates to milliseconds
        let date1Ms: number = date1.getTime();
        let date2Ms: number = date2.getTime();

        // Calculate the difference in milliseconds
        let differenceMs: number = date2Ms - date1Ms;

        // Convert back to days and return
        let differenceDays: number = Math.round(differenceMs / oneDay) + 1;
        if (differenceDays < 1)
            differenceDays = 1;
        return differenceDays;
    }

    /**
     * @method return the number in percent format
     * @param num a number to conver to percent
     */
    toPercent(num: number): string {
        return `${Math.round(num * 100) / 100 * 100}%`
    }

    /**
     * @method return the number in short format
     * @param num a number to short
     * @param digits num of digits after comma
     */
    toShortNumber(num: number, digits: number=2): number {
        if (digits <= 0)
            return Math.round(num);
        let x: number = 10 ** digits;
        return Math.round(num * x) / x;
    }

}
