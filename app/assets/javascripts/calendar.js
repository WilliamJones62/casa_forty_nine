(function($) {

	"use strict";


	$(document).ready(function () {
    function calendarDates(passed_month, passed_year) {
        var calendar = calendars.cal1;
        makeWeek(calendar.weekline);
        calendar.datesBody.empty();
        var calMonthArray = makeMonthArray(passed_month, passed_year);
        var r = 0;
        var u = false;
        while (!u) {
            if (daysArray[r] == calMonthArray[0].weekday) {
                u = true
            } else {
                calendar.datesBody.append('<div class="blank"></div>');
                r++;
            }
        }
        document.getElementById("previousMonth").disabled = false;
        for (var cell = 0; cell < 42 - r; cell++) { // 42 date-cells in calendar
            if (cell >= calMonthArray.length) {
                calendar.datesBody.append('<div class="blank"></div>');
            } else {
                var shownDate = calMonthArray[cell].day;
                var iter_date = new Date(passed_year, passed_month, shownDate);
                if (
                (
                (shownDate != today.getDate() && passed_month == today.getMonth()) || passed_month != today.getMonth()) && iter_date < today) {
                    var m = '<div class="past-date">';
                } else {
                    var m = checkToday(iter_date) ? '<div class="today">' : '<div class="available">';
                    if (m == '<div class="today">') {
                        // This month contains today's date, so disable the previous month button
                        document.getElementById("previousMonth").disabled = true;
                    } 
                    if (booked.includes(shownDate)) {
                        // this date is part of an existing booking
                        m = '<div class="past-date">';
                    }
                }
                calendar.datesBody.append(m + shownDate + "</div>");
            }
        }

        var color = "#444444";
        calendar.calHeader.find("h2").text(i[passed_month] + " " + passed_year);
        calendar.weekline.find("div").css("color", color);
        calendar.datesBody.find(".today").css("color", "#00bdaa");

        // find elements (dates) to be clicked on each time
        // the calendar is generated
        var clicked = false;
        selectDates(selected);

        clickedElement = calendar.datesBody.find(".available");
        clickedElement.on("click", function () {
            clicked = $(this);

            if (firstClick && secondClick) {
                thirdClicked = getClickedInfo(clicked, calendar);
                var firstClickDateObj = new Date(firstClicked.year,
                firstClicked.month,
                firstClicked.date);
                var secondClickDateObj = new Date(secondClicked.year,
                secondClicked.month,
                secondClicked.date);
                var thirdClickDateObj = new Date(thirdClicked.year,
                thirdClicked.month,
                thirdClicked.date);
                if (secondClickDateObj > thirdClickDateObj && thirdClickDateObj > firstClickDateObj) {
                    secondClicked = thirdClicked;
                    // then choose dates again from the start :)
                    bothCals.find(".calendar_content").find("div").each(function () {
                        $(this).removeClass("selected");
                    });
                    selected = {};
                    selected[firstClicked.year] = {};
                    selected[firstClicked.year][firstClicked.month] = [firstClicked.date];
                    selected = addChosenDates(firstClicked, secondClicked, selected);
                } else { // reset clicks
                    selected = {};
                    firstClicked = [];
                    secondClicked = [];
                    firstClick = false;
                    secondClick = false;
                    document.getElementById("previousMonth").disabled = false;
                    document.getElementById("nextMonth").disabled = false;
                    bothCals.find(".calendar_content").find("div").each(function () {
                        $(this).removeClass("selected");
                        if ($(this).hasClass( "noncontiguous")){
                            $(this).removeClass('noncontiguous');
                            $(this).addClass('available');
                        }
                    });
                    selectButton.addClass("d-none");
                }
            }
            if (!firstClick) {
                firstClick = true;
                firstClicked = getClickedInfo(clicked, calendar);
                selected[firstClicked.year] = {};
                selected[firstClicked.year][firstClicked.month] = [firstClicked.date];
            } else {
                secondClick = true;
                secondClicked = getClickedInfo(clicked, calendar);
                // what if second clicked date is before the first clicked?
                var firstClickDateObj = new Date(firstClicked.year,
                firstClicked.month,
                firstClicked.date);
                var secondClickDateObj = new Date(secondClicked.year,
                secondClicked.month,
                secondClicked.date);

                if (firstClickDateObj > secondClickDateObj) {

                    var cachedClickedInfo = secondClicked;
                    secondClicked = firstClicked;
                    firstClicked = cachedClickedInfo;
                    selected = {};
                    selected[firstClicked.year] = {};
                    selected[firstClicked.year][firstClicked.month] = [firstClicked.date];

                } else if (firstClickDateObj.getTime() == secondClickDateObj.getTime()) {
                    selected = {};
                    firstClicked = [];
                    secondClicked = [];
                    firstClick = false;
                    secondClick = false;
                    document.getElementById("previousMonth").disabled = false;
                    document.getElementById("nextMonth").disabled = false;
                    $(this).removeClass("selected");
                    bothCals.find(".calendar_content").find("div").each(function () {
                        if ($(this).hasClass( "noncontiguous")){
                            $(this).removeClass('noncontiguous');
                            $(this).addClass('available');
                        }
                    });
                    selectButton.addClass("d-none");
                }


                // add between dates to [selected]
                selected = addChosenDates(firstClicked, secondClicked, selected);
            }
            selectDates(selected);
            let selectedLen = Object.keys(selected).length;
            if (selectedLen != 0) {
                if (firstClick) {
                    // all this stuff only needs to be done on the first click. Need
                    // to work out how to do this efficiently.
                    selectButton.removeClass("d-none");
                    // Dates in a booking must be contiguous.
                    // Check if there is a booking on either side of the selected day. If
                    // there is then grey out the appropriate days and the month button(s).
                    var monthHash = Object.values(selected)[0];
                    var selectDay = Object.values(monthHash)[0];
                    var priorBookedDate = findPriorBookedDate(selectDay)
                    if (priorBookedDate != 0) {
                        preventPriorDateSelection(priorBookedDate)
                    }
                    var nextBookedDate = findNextBookedDate(selectDay)
                    if (nextBookedDate != 0) {
                        preventNextDateSelection(nextBookedDate)
                    }
                    // Only need to do this stuff on the first click.
                    // Maybe set a boolean to check below if the dates are unselected.
                    // Look in 'booked' then compare to 'selected'. Find the latest booked
                    // before the selected date then add the "past-date" class to the dates 
                    // up to the first of the month, and disable previous month button.
                    // Then look in 'booked and findthe earliest booked after the selected date
                    // and add the "past-date" class to the dates up to the end of the month
                    // and disable the next month button.
                }
            } else {
                // If dates and month buttons have been greyed out above those changes 
                // should be reversed here.
            };

            var myJSON = JSON.stringify(selected);
            console.log(`selected = ${myJSON}`);
            myJSON = JSON.stringify(booked);
            console.log(`booked = ${myJSON}`);
        });

    }

    function findPriorBookedDate(selectDay) {
        var reveresed = [...booked].reverse();
        for (var i = 0; i < reveresed.length; i++) {
            if (selectDay > reveresed[i]) {//if the current item is smaller than the parameter
                return reveresed[i]; //return the value at the index you are on
            }; 
        } 
        // there is no previous booking this month
        return 0;
    }

    function preventPriorDateSelection(firstDay) {
        document.getElementById("previousMonth").disabled = true;
        var dateElements = datesBody1.find('div');
        dateElements.each(function (index) {
            var number = +($(this).text());
            if (!isNaN(number)) {
                if (number >= firstDay) {
                    return
                } else if ($(this).hasClass( "available")){
                    $(this).addClass('noncontiguous');
                    $(this).removeClass('available');
                }
            }
        });
    }

    function findNextBookedDate(selectDay) {
        for (var i = 0; i < booked.length; i++) {
            if (selectDay < booked[i]) {//if the current item is smaller than the parameter
                return booked[i]; //return the value at the index you are on
            }; 
        } 
        // there is no previous booking this month
        return 0;
    }

    function preventNextDateSelection(firstDay) {
        document.getElementById("nextMonth").disabled = true;
        var dateElements = datesBody1.find('div');
        dateElements.each(function (index) {
            var number = +($(this).text());
            if (!isNaN(number)) {
                if (number <= firstDay) {
                    return
                } else if ($(this).hasClass( "available")){
                    $(this).addClass('noncontiguous');
                    $(this).removeClass('available');
                }
            }
        });
    }

    function selectDates(selected) {
        if (!$.isEmptyObject(selected)) {
            var dateElements1 = datesBody1.find('div');
            var dateElements2 = datesBody2.find('div');

            function highlightDates(passed_year, passed_month, dateElements) {
                if (passed_year in selected && passed_month in selected[passed_year]) {
                    var daysToCompare = selected[passed_year][passed_month];
                    for (var d in daysToCompare) {
                        dateElements.each(function (index) {
                            if (parseInt($(this).text()) == daysToCompare[d]) {
                                $(this).addClass('selected');
                            }
                        });
                    }

                }
            }

            highlightDates(year, month, dateElements1);
            highlightDates(nextYear, nextMonth, dateElements2);
        }
    }

    function makeMonthArray(passed_month, passed_year) { // creates Array specifying dates and weekdays
        var e = [];
        for (var r = 1; r < getDaysInMonth(passed_year, passed_month) + 1; r++) {
            e.push({
                day: r,
                // Later refactor -- weekday needed only for first week
                weekday: daysArray[getWeekdayNum(passed_year, passed_month, r)]
            });
        }
        return e;
    }

    function makeWeek(week) {
        week.empty();
        for (var e = 0; e < 7; e++) {
            week.append("<div>" + daysArray[e].substring(0, 3) + "</div>")
        }
    }

    function getDaysInMonth(currentYear, currentMon) {
        return (new Date(currentYear, currentMon + 1, 0)).getDate();
    }

    function getWeekdayNum(e, t, n) {
        return (new Date(e, t, n)).getDay();
    }

    function checkToday(e) {
        var todayDate = today.getFullYear() + '/' + (today.getMonth() + 1) + '/' + today.getDate();
        var checkingDate = e.getFullYear() + '/' + (e.getMonth() + 1) + '/' + e.getDate();
        return todayDate == checkingDate;

    }

    function getAdjacentMonth(curr_month, curr_year, direction) {
        var theNextMonth;
        var theNextYear;
        if (direction == "next") {
            theNextMonth = (curr_month + 1) % 12;
            theNextYear = (curr_month == 11) ? curr_year + 1 : curr_year;
        } else {
            theNextMonth = (curr_month == 0) ? 11 : curr_month - 1;
            theNextYear = (curr_month == 0) ? curr_year - 1 : curr_year;
        }
        return [theNextMonth, theNextYear];
    }

    function setUpDates() {
        today = new Date;
        year = today.getFullYear();
        month = today.getMonth();
        var nextDates = getAdjacentMonth(month, year, "next");
        nextMonth = nextDates[0];
        nextYear = nextDates[1];
    }

    var e = 480;

    var today;
    var year,
    month,
    nextMonth,
    nextYear;

    var r = [];
    var i = [
        "January",
        "Feburary",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"];
    var daysArray = [
        "Sunday",
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday"];

    var cal1 = $("#calendar_first");
    var calHeader1 = cal1.find(".calendar_header");
    var weekline1 = cal1.find(".calendar_weekdays");
    var datesBody1 = cal1.find(".calendar_content");

    var cal2 = $("#calendar_second");
    var calHeader2 = cal2.find(".calendar_header");
    var weekline2 = cal2.find(".calendar_weekdays");
    var datesBody2 = cal2.find(".calendar_content");

    var bothCals = $(".calendar");

    var switchButton = bothCals.find(".calendar_header").find('.switch-month');

    var calendars = {
        "cal1": {
            "name": "first",
                "calHeader": calHeader1,
                "weekline": weekline1,
                "datesBody": datesBody1
        },
        "cal2": {
            "name": "second",
                "calHeader": calHeader2,
                "weekline": weekline2,
                "datesBody": datesBody2
        }
    }


    var clickedElement;
    var firstClicked,
    secondClicked,
    thirdClicked;
    var firstClick = false;
    var secondClick = false;
    var selected = {};

    setUpDates();
    // need to get all the booked days for this month and load them in the calendar
    var booked = [];
    getBookedDays();
    var selectButton = $("#calendar_commit_button");
    // the select button should be hidden until dates are selected
    selectButton.addClass("d-none");
    selectButton.on("click", function () {
        postBooking();
    });

    setTimeout(() => calendarDates(month, year), 1000);
    switchButton.on("click", function () {
        var clicked = $(this);
        var generateCalendars = function (e) {
            var nextDatesFirst = getAdjacentMonth(month, year, e);
            var nextDatesSecond = getAdjacentMonth(nextMonth, nextYear, e);
            month = nextDatesFirst[0];
            year = nextDatesFirst[1];
            nextMonth = nextDatesSecond[0];
            nextYear = nextDatesSecond[1];

            getBookedDays();
            setTimeout(() => calendarDates(month, year), 1000);
        };
        if (clicked.attr("class").indexOf("left") != -1) {
            generateCalendars("previous");
        } else {
            generateCalendars("next");
        }
        clickedElement = bothCals.find(".calendar_content").find("div");
    });

    function getBookedDays() {
        // Call the API to get the days that are already booked this month 
        booked = [];
        const req = new XMLHttpRequest();
        req.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                var dates = JSON.parse(this.responseText);
                booked = dates["booked"];
            }
        };
        
        req.open('GET', `http://localhost:3000/api/v1/users/1/booked.json?year=${year}&month=${month}`);
        req.send();
    }

    function postBooking() {
        // call the API to create a booking
        const xhttp = new XMLHttpRequest();
        xhttp.onload = function() {
            selected = {};
            firstClicked = [];
            secondClicked = [];
            firstClick = false;
            secondClick = false;
            selectButton.addClass("d-none");
            getBookedDays();
            setTimeout(() => calendarDates(month, year), 1000);
            var response = JSON.parse(this.responseText);
            alert(response["message"]);
        }
        xhttp.open("POST", '/api/v1/users/1/booking.json');
        xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        var selectedString = JSON.stringify(selected);

        xhttp.send(`selected=${selectedString}`);
    }

    //  Click picking stuff
    function getClickedInfo(element, calendar) {
        var clickedInfo = {};
        var clickedCalendar,
        clickedMonth,
        clickedYear;
        clickedCalendar = calendar.name;
        clickedMonth = clickedCalendar == "first" ? month : nextMonth;
        clickedYear = clickedCalendar == "first" ? year : nextYear;
        clickedInfo = {
            "calNum": clickedCalendar,
                "date": parseInt(element.text()),
                "month": clickedMonth,
                "year": clickedYear
        }
        return clickedInfo;
    }


    // Finding between dates MADNESS. Needs refactoring and smartening up :)
    function addChosenDates(firstClicked, secondClicked, selected) {
        if (secondClicked.date > firstClicked.date || secondClicked.month > firstClicked.month || secondClicked.year > firstClicked.year) {
            var added_year = secondClicked.year;
            var added_month = secondClicked.month;
            var added_date = secondClicked.date;

            if (added_year > firstClicked.year) {
                // first add all dates from all months of Second-Clicked-Year
                selected[added_year] = {};
                selected[added_year][added_month] = [];
                for (var i = 1;
                i <= secondClicked.date;
                i++) {
                    selected[added_year][added_month].push(i);
                }

                added_month = added_month - 1;
                while (added_month >= 0) {
                    selected[added_year][added_month] = [];
                    for (var i = 1;
                    i <= getDaysInMonth(added_year, added_month);
                    i++) {
                        selected[added_year][added_month].push(i);
                    }
                    added_month = added_month - 1;
                }

                added_year = added_year - 1;
                added_month = 11; // reset month to Dec because we decreased year
                added_date = getDaysInMonth(added_year, added_month); // reset date as well

                // Now add all dates from all months of inbetween years
                while (added_year > firstClicked.year) {
                    selected[added_year] = {};
                    for (var i = 0; i < 12; i++) {
                        selected[added_year][i] = [];
                        for (var d = 1; d <= getDaysInMonth(added_year, i); d++) {
                            selected[added_year][i].push(d);
                        }
                    }
                    added_year = added_year - 1;
                }
            }

            if (added_month > firstClicked.month) {
                if (firstClicked.year == secondClicked.year) {
                    selected[added_year][added_month] = [];
                    for (var i = 1;
                    i <= secondClicked.date;
                    i++) {
                        selected[added_year][added_month].push(i);
                    }
                    added_month = added_month - 1;
                }
                while (added_month > firstClicked.month) {
                    selected[added_year][added_month] = [];
                    for (var i = 1;
                    i <= getDaysInMonth(added_year, added_month);
                    i++) {
                        selected[added_year][added_month].push(i);
                    }
                    added_month = added_month - 1;
                }
                added_date = getDaysInMonth(added_year, added_month);
            }

            for (var i = firstClicked.date + 1;
            i <= added_date;
            i++) {
                selected[added_year][added_month].push(i);
            }
        }
        return selected;
    }
});


})(jQuery);
