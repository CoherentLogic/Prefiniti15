<cfoutput>#DateFormat(DateAdd("d", 5, DateAdd("d", "-#DayOfWeek(Now()) - 1#", Now())), "mm/dd/yyyy")#</cfoutput>